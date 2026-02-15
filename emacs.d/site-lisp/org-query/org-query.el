;;; org-query.el --- Query org agenda from shell -*- lexical-binding: t -*-

;;; Code:

(require 'org)
(require 'json)

(defun org-query--plist-to-alist (plist)
  "Convert PLIST to alist for JSON encoding."
  (let ((alist nil))
    (while plist
      (let* ((key (pop plist))
             (val (pop plist))
             (sym (intern (substring (symbol-name key) 1)))) ; strip leading :
        (when val
          (push (cons sym (if (listp val)
                              (vconcat val) ; convert list to vector for JSON array
                            val))
                alist))))
    (nreverse alist)))

(defun org-query--entries-to-json (entries)
  "Convert ENTRIES to JSON string. Special handling for empty list."
  (if entries
      (json-encode (mapcar #'org-query--plist-to-alist entries))
    "[]"))

(defun org-query--format-timestamp (ts)
  "Format org timestamp TS as ISO date."
  (when ts
    (format-time-string "%Y-%m-%d" (org-timestamp-to-time ts))))

(defun org-query--get-entries (filters)
  "Return list of plists for all entries with a TODO state in org agenda files.
FILTERS is a list of predicate functions."
  (let ((entries nil))
    (dolist (file (org-agenda-files))
      (with-current-buffer (find-file-noselect file)
        (org-map-entries
         (lambda ()
           (let* ((state (org-get-todo-state))
                  (heading (substring-no-properties (org-get-heading t t t t)))
                  (line (line-number-at-pos))
                  (tags (org-get-tags))
                  (scheduled (org-get-scheduled-time (point)))
                  (deadline (org-get-deadline-time (point)))
                  (entry (list :heading heading
                               :state state
                               :file file
                               :line line
                               :tags tags)))
             (when scheduled
               (setq entry (plist-put entry :scheduled
                                      (format-time-string "%Y-%m-%d" scheduled))))
             (when deadline
               (setq entry (plist-put entry :deadline
                                      (format-time-string "%Y-%m-%d" deadline))))
             (when (and state
                        (cl-every (lambda (pred) (funcall pred entry)) filters))
               (push entry entries))))
         nil nil)))
    (nreverse entries)))

;; Filters

(defun org-query--tags-filter (tags)
  (if (null tags)
      (lambda (entry) t)
    (lambda (entry)
      (seq-some (lambda (tag)
                  (member tag (plist-get entry :tags)))
                tags))))

(defun org-query--active-p (entry)
  (let ((active-states '("TODO" "NEXT" "REVIEW" "DEPLOY")))
    (member (plist-get entry :state) active-states)))

(defun org-query--next-p (entry)
  (equal (plist-get entry :state) "NEXT"))

(defun org-query--scheduled-p (entry)
  (plist-get entry :scheduled))

(defun org-query--has-deadline-p (entry)
  (plist-get entry :deadline))

;; There is some weirdness with using emacsclient to call the above functions directly and
;; print their output to stdout -- I am getting weird async errors interleaved. Claude suggests
;; it is some issue with buffering, in any case I couldn't figure it out. For now, we're
;; going to write the output to a file, which avoids this error issue.

(defvar org-query-output-file
  (expand-file-name "org-query.json" temporary-file-directory)
  "File where org-query writes JSON output for shell consumption.")

(defun org-query--write-json (json-string)
  "Write JSON-STRING to `org-query-output-file' and return the path."
  (with-temp-file org-query-output-file
    (insert json-string))
  org-query-output-file)

(defun org-query-json! (query-type &optional tags-string)
  "Write query results as JSON to file, return path.
QUERY-TYPE is one of: todos, active, next, scheduled, deadlines.
TAGS-STRING is an optional comma-separated list of tags to filter by."
  (let* ((tags (when tags-string
                 (split-string tags-string "," t "[ \t]+")))
         (tags-filter (org-query--tags-filter tags))
         (base-filter (pcase query-type
                        ("todos" (lambda (entry) t))
                        ("active" #'org-query--active-p)
                        ("next" #'org-query--next-p)
                        ("scheduled" #'org-query--scheduled-p)
                        ("deadlines" #'org-query--has-deadline-p)
                        (_ (error "Unknown query type: %s" query-type))))
         (filtered (org-query--get-entries (list tags-filter base-filter))))
    (org-query--write-json (org-query--entries-to-json filtered))))

(provide 'org-query)
;;; org-query.el ends here
