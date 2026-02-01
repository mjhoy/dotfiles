;;; org-query-test.el --- Tests for org-query -*- lexical-binding: t -*-

;;; Commentary:
;; Run with: emacs -batch -l ert -l org-query-test.el -f ert-run-tests-batch-and-exit

;;; Code:

(require 'ert)
(require 'org)

;; Load org-query from site-lisp directory
(add-to-list 'load-path (expand-file-name "../../site-lisp/org-query" (file-name-directory load-file-name)))
(require 'org-query)

(defvar org-query-test-fixture-dir
  (expand-file-name "fixtures" (file-name-directory load-file-name))
  "Directory containing test org files.")

(defmacro org-query-test-with-fixtures (&rest body)
  "Execute BODY with `org-agenda-files' set to test fixtures."
  `(let ((org-agenda-files (list
                            (expand-file-name "inbox.org" org-query-test-fixture-dir)
                            (expand-file-name "projects.org" org-query-test-fixture-dir)
                            (expand-file-name "agenda.org" org-query-test-fixture-dir))))
     ,@body))

(ert-deftest org-query-test-get-entries-returns-list ()
  "Test that org-query--get-entries returns a list."
  (org-query-test-with-fixtures
   (let ((entries (org-query--get-entries)))
     (should (listp entries)))))

(ert-deftest org-query-test-get-entries-structure ()
  "Test that entries are plists with :heading, :state, :file, :line."
  (org-query-test-with-fixtures
   (let ((entries (org-query--get-entries)))
     (dolist (entry entries)
       (should (plist-get entry :heading))
       (should (plist-get entry :state))
       (should (plist-get entry :file))
       (should (plist-get entry :line))
       (should (stringp (plist-get entry :heading)))
       (should (stringp (plist-get entry :state)))
       (should (stringp (plist-get entry :file)))
       (should (numberp (plist-get entry :line)))))))

(ert-deftest org-query-test-get-entries-count ()
  "Test that we get the expected number of entries."
  (org-query-test-with-fixtures
   (let ((entries (org-query--get-entries)))
     ;; inbox: 3, projects: 8, agenda: 2 = 13 total
     (should (= (length entries) 13)))))


(ert-deftest org-query-test-active-filters-correctly ()
  "Test that org-query-active only returns active states."
  (org-query-test-with-fixtures
   (let ((active (org-query-active))
         (active-states '("TODO" "NEXT" "REVIEW" "DEPLOY")))
     (dolist (entry active)
       (should (member (plist-get entry :state) active-states))))))

(ert-deftest org-query-test-active-count ()
  "Test that org-query-active returns expected count."
  (org-query-test-with-fixtures
   (let ((active (org-query-active)))
     ;; TODO: 4, NEXT: 2, REVIEW: 1, DEPLOY: 1 = 8
     (should (= (length active) 8)))))

(ert-deftest org-query-test-next-only-next ()
  "Test that org-query-next only returns NEXT entries."
  (org-query-test-with-fixtures
   (let ((next-entries (org-query-next)))
     (dolist (entry next-entries)
       (should (equal (plist-get entry :state) "NEXT"))))))

(ert-deftest org-query-test-next-count ()
  "Test that org-query-next returns expected count."
  (org-query-test-with-fixtures
   (let ((next-entries (org-query-next)))
     ;; "Write documentation" and "Prepare presentation"
     (should (= (length next-entries) 2)))))

(ert-deftest org-query-test-specific-headings ()
  "Test that specific headings are found."
  (org-query-test-with-fixtures
   (let ((entries (org-query--get-entries)))
     (should (cl-find "Review pull request" entries
                      :key (lambda (e) (plist-get e :heading)) :test #'equal))
     (should (cl-find "Write documentation" entries
                      :key (lambda (e) (plist-get e :heading)) :test #'equal))
     (should (cl-find "Ready for deploy" entries
                      :key (lambda (e) (plist-get e :heading)) :test #'equal)))))

;;; JSON tests

(ert-deftest org-query-test-todos-json-valid ()
  "Test that org-query-todos-json returns valid JSON."
  (org-query-test-with-fixtures
   (let* ((json-string (org-query-todos-json))
          (parsed (json-read-from-string json-string)))
     (should (vectorp parsed))
     (should (= (length parsed) 13)))))

(ert-deftest org-query-test-json-structure ()
  "Test that JSON entries have heading, state, file, and line keys."
  (org-query-test-with-fixtures
   (let* ((json-string (org-query-todos-json))
          (parsed (json-read-from-string json-string)))
     (dolist (entry (append parsed nil))
       (should (assoc 'heading entry))
       (should (assoc 'state entry))
       (should (assoc 'file entry))
       (should (assoc 'line entry))
       (should (stringp (cdr (assoc 'file entry))))
       (should (numberp (cdr (assoc 'line entry))))))))

(ert-deftest org-query-test-active-json-count ()
  "Test that org-query-active-json returns correct count."
  (org-query-test-with-fixtures
   (let* ((json-string (org-query-active-json))
          (parsed (json-read-from-string json-string)))
     (should (= (length parsed) 8)))))

(ert-deftest org-query-test-next-json-count ()
  "Test that org-query-next-json returns correct count."
  (org-query-test-with-fixtures
   (let* ((json-string (org-query-next-json))
          (parsed (json-read-from-string json-string)))
     (should (= (length parsed) 2)))))

;;; File-based output tests

(ert-deftest org-query-test-file-output-creates-file ()
  "Test that org-query-json! creates a file."
  (org-query-test-with-fixtures
   (let ((path (org-query-json! "todos")))
     (should (stringp path))
     (should (file-exists-p path)))))

(ert-deftest org-query-test-file-output-valid-json ()
  "Test that file contains valid JSON."
  (org-query-test-with-fixtures
   (let* ((path (org-query-json! "active"))
          (content (with-temp-buffer
                     (insert-file-contents path)
                     (buffer-string)))
          (parsed (json-read-from-string content)))
     (should (vectorp parsed))
     (should (= (length parsed) 8)))))

(ert-deftest org-query-test-file-no-control-chars ()
  "Test that file output has no unescaped control characters."
  (org-query-test-with-fixtures
   (let* ((path (org-query-json! "todos"))
          (content (with-temp-buffer
                     (insert-file-contents path)
                     (buffer-string))))
     ;; Should not contain raw control characters (except in properly escaped form)
     (should-not (string-match-p "[\x00-\x1f]" content)))))

;;; Scheduled/deadline tests

(ert-deftest org-query-test-scheduled-filter ()
  "Test that org-query-scheduled only returns scheduled entries."
  (org-query-test-with-fixtures
   (let ((scheduled (org-query-scheduled)))
     (should (= (length scheduled) 1))
     (dolist (entry scheduled)
       (should (plist-get entry :scheduled))))))

(ert-deftest org-query-test-deadlines-filter ()
  "Test that org-query-deadlines only returns entries with deadlines."
  (org-query-test-with-fixtures
   (let ((deadlines (org-query-deadlines)))
     (should (= (length deadlines) 1))
     (dolist (entry deadlines)
       (should (plist-get entry :deadline))))))

(ert-deftest org-query-test-scheduled-date-format ()
  "Test that scheduled dates are in ISO format."
  (org-query-test-with-fixtures
   (let ((scheduled (org-query-scheduled)))
     (dolist (entry scheduled)
       (should (string-match-p "^[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}$"
                               (plist-get entry :scheduled)))))))

(ert-deftest org-query-test-json-includes-dates ()
  "Test that JSON output includes scheduled and deadline fields."
  (org-query-test-with-fixtures
   (let* ((json-string (org-query-scheduled-json))
          (parsed (json-read-from-string json-string)))
     (should (> (length parsed) 0))
     (dolist (entry (append parsed nil))
       (should (assoc 'scheduled entry))))))

;;; Tag tests

(ert-deftest org-query-test-entries-have-tags ()
  "Test that entries include tags."
  (org-query-test-with-fixtures
   (let ((entries (org-query--get-entries)))
     (dolist (entry entries)
       (should (plist-member entry :tags))))))

(ert-deftest org-query-test-tag-filter-single ()
  "Test filtering by a single tag."
  (org-query-test-with-fixtures
   (let* ((all-entries (org-query--get-entries))
          (work-entries (org-query--filter-by-tags all-entries '("work"))))
     (should (> (length work-entries) 0))
     (should (< (length work-entries) (length all-entries)))
     (dolist (entry work-entries)
       (should (member "work" (plist-get entry :tags)))))))

(ert-deftest org-query-test-tag-filter-multiple ()
  "Test filtering by multiple tags (OR logic)."
  (org-query-test-with-fixtures
   (let* ((all-entries (org-query--get-entries))
          (filtered (org-query--filter-by-tags all-entries '("docs" "code"))))
     (should (> (length filtered) 0))
     (dolist (entry filtered)
       (should (or (member "docs" (plist-get entry :tags))
                   (member "code" (plist-get entry :tags))))))))

(ert-deftest org-query-test-tag-filter-empty ()
  "Test that nil tags returns all entries."
  (org-query-test-with-fixtures
   (let* ((all-entries (org-query--get-entries))
          (filtered (org-query--filter-by-tags all-entries nil)))
     (should (= (length filtered) (length all-entries))))))

(ert-deftest org-query-test-json-includes-tags ()
  "Test that JSON output includes tags array."
  (org-query-test-with-fixtures
   (let* ((json-string (org-query-todos-json))
          (parsed (json-read-from-string json-string)))
     (dolist (entry (append parsed nil))
       (should (assoc 'tags entry))))))

(ert-deftest org-query-test-org-query-json-with-tags ()
  "Test org-query-json! with tag filtering."
  (org-query-test-with-fixtures
   (let* ((path (org-query-json! "active" "work"))
          (content (with-temp-buffer
                     (insert-file-contents path)
                     (buffer-string)))
          (parsed (json-read-from-string content)))
     (should (> (length parsed) 0))
     (dolist (entry (append parsed nil))
       (should (seq-contains-p (cdr (assoc 'tags entry)) "work"))))))

(provide 'org-query-test)
;;; org-query-test.el ends here
