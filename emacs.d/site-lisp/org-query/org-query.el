;;; org-query.el --- Query org agenda from shell -*- lexical-binding: t -*-

;;; Code:

(require 'org)
(require 'json)

(defun org-query--plist-to-alist (plist)
  "Convert PLIST to alist for JSON encoding.
Keyword keys become symbols. Nil values are omitted except for
:tags which becomes an empty array. Lists become vectors for JSON arrays."
  (let ((alist nil)
        (always-include '(:tags))) ; keys to include even when nil
    (while plist
      (let* ((key (pop plist))
             (val (pop plist))
             (sym (intern (substring (symbol-name key) 1)))) ; strip leading :
        (when (or val (member key always-include))
          (push (cons sym (if (listp val)
                              (vconcat val) ; convert list to vector for JSON array
                            val))
                alist))))
    (nreverse alist)))

(defun org-query--entries-to-json (entries)
  "Convert ENTRIES to JSON string.
ENTRIES is a list of plists."
  (json-encode (mapcar #'org-query--plist-to-alist entries)))

(defun org-query--format-timestamp (ts)
  "Format org timestamp TS as ISO date string, or nil if TS is nil."
  (when ts
    (format-time-string "%Y-%m-%d" (org-timestamp-to-time ts))))

(defun org-query--get-entries ()
  "Return list of plists for all entries with a TODO state.
Each plist has :heading, :state, :file, :line, :tags, and optionally
:scheduled and :deadline keys."
  (let ((entries nil)
        (inhibit-message t))
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
             (when state
               (push entry entries))))
         nil nil)))
    (nreverse entries)))

(defun org-query--filter-by-tags (entries tags)
  "Filter ENTRIES to only those having at least one of TAGS.
TAGS is a list of tag strings."
  (if (null tags)
      entries
    (seq-filter (lambda (entry)
                  (seq-some (lambda (tag)
                              (member tag (plist-get entry :tags)))
                            tags))
                entries)))

(defun org-query-active ()
  "Return only active TODO entries (TODO, NEXT, REVIEW, DEPLOY)."
  (let ((active-states '("TODO" "NEXT" "REVIEW" "DEPLOY")))
    (seq-filter (lambda (entry)
                  (member (plist-get entry :state) active-states))
                (org-query--get-entries))))

(defun org-query-next ()
  "Return only NEXT entries."
  (seq-filter (lambda (entry)
                (equal (plist-get entry :state) "NEXT"))
              (org-query--get-entries)))

(defun org-query-scheduled ()
  "Return only entries with a SCHEDULED date."
  (seq-filter (lambda (entry)
                (plist-get entry :scheduled))
              (org-query--get-entries)))

(defun org-query-deadlines ()
  "Return only entries with a DEADLINE date."
  (seq-filter (lambda (entry)
                (plist-get entry :deadline))
              (org-query--get-entries)))

;;; JSON output functions

(defun org-query-todos-json ()
  "Return all TODO entries as JSON."
  (org-query--entries-to-json (org-query--get-entries)))

(defun org-query-active-json ()
  "Return active TODO entries as JSON."
  (org-query--entries-to-json (org-query-active)))

(defun org-query-next-json ()
  "Return NEXT entries as JSON."
  (org-query--entries-to-json (org-query-next)))

(defun org-query-scheduled-json ()
  "Return scheduled entries as JSON."
  (org-query--entries-to-json (org-query-scheduled)))

(defun org-query-deadlines-json ()
  "Return entries with deadlines as JSON."
  (org-query--entries-to-json (org-query-deadlines)))

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
         (base-entries (pcase query-type
                         ("todos" (org-query--get-entries))
                         ("active" (org-query-active))
                         ("next" (org-query-next))
                         ("scheduled" (org-query-scheduled))
                         ("deadlines" (org-query-deadlines))
                         (_ (error "Unknown query type: %s" query-type))))
         (filtered (org-query--filter-by-tags base-entries tags)))
    (org-query--write-json (org-query--entries-to-json filtered))))

(provide 'org-query)
;;; org-query.el ends here
