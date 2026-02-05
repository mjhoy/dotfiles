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

(defun org-query-test-get-headings (entries)
  "Extract headings from ENTRIES."
  (mapcar (lambda (e) (plist-get e :heading)) entries))

(ert-deftest org-query-test-get-entries-returns-list ()
  "Test that org-query--get-entries returns a list."
  (org-query-test-with-fixtures
   (let ((entries (org-query--get-entries '())))
     (should (listp entries))
     ;; inbox: 3, projects: 8, agenda: 2 = 13 total
     (should (= (length entries) 13)))))

(ert-deftest org-query-test-active-filters-correctly ()
  "Test that org-query-active only returns active states."
  (org-query-test-with-fixtures
   (let ((active (org-query--get-entries (list #'org-query--active-p)))
         (active-states '("TODO" "NEXT" "REVIEW" "DEPLOY")))
     (dolist (entry active)
       (should (member (plist-get entry :state) active-states)))
     (should (= (length active) 8)))))

(ert-deftest org-query-test-next-filters-correctly ()
  "Test that org-query--next-p only returns NEXT entries."
  (org-query-test-with-fixtures
   (let* ((entries (org-query--get-entries (list #'org-query--next-p)))
          (headings (org-query-test-get-headings entries)))
     (should (= (length entries) 2))
     (should (member "Write documentation" headings))
     (should (member "Prepare presentation" headings)))))

(ert-deftest org-query-test-scheduled-filters-correctly ()
  "Test that org-query--scheduled-p only returns scheduled entries."
  (org-query-test-with-fixtures
   (let* ((entries (org-query--get-entries (list #'org-query--scheduled-p)))
          (headings (org-query-test-get-headings entries)))
     (should (= (length entries) 1))
     (should (member "Morning standup" headings)))))

(ert-deftest org-query-test-deadlines-filters-correctly ()
  "Test that org-query--has-deadline-p only returns entries with deadlines."
  (org-query-test-with-fixtures
   (let* ((entries (org-query--get-entries (list #'org-query--has-deadline-p)))
          (headings (org-query-test-get-headings entries)))
     (should (= (length entries) 1))
     (should (member "Prepare presentation" headings)))))

(ert-deftest org-query-test-tags-filter ()
  "Test that org-query--tags-filter filters by tag."
  (org-query-test-with-fixtures
   (let* ((entries (org-query--get-entries (list (org-query--tags-filter '("code")))))
          (headings (org-query-test-get-headings entries)))
     (should (= (length entries) 2))
     (should (member "Add tests" headings))
     (should (member "Code review needed" headings)))))

(provide 'org-query-test)
;;; org-query-test.el ends here
