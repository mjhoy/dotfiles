;;; captures-test.el --- Unit tests for org capture functions

(require 'ert)
(require 'org)
(require 'init-org/captures)

(defvar mjhoy/test-people-org-content
  "#+TITLE: People & 1:1s
#+STARTUP: overview

* Alice
** Meeting Notes
* Bob
** Meeting Notes
* Carol
** Meeting Notes
")

(ert-deftest test-mjhoy/org-get-people-list ()
  "Test that we can extract people names from people.org"
  (let ((org-directory (make-temp-file "org-test-" t))
        (people-file nil))
    (unwind-protect
        (progn
          (setq people-file (concat org-directory "people.org"))
          (with-temp-file people-file
            (insert mjhoy/test-people-org-content))
          (let ((people (mjhoy/org-get-people-list)))
            (should (equal people '("Alice" "Bob" "Carol")))))
      (when (file-exists-p org-directory)
        (delete-directory org-directory t)))))

(ert-deftest test-mjhoy/org-capture-people-location-alice-meeting-notes ()
  "Test that we navigate to Alice's Meeting Notes correctly"
  (let ((org-directory (make-temp-file "org-test-" t))
        (people-file nil))
    (unwind-protect
        (progn
          (setq people-file (concat org-directory "people.org"))
          (with-temp-file people-file
            (insert mjhoy/test-people-org-content))

          ;; Mock completing-read to return "Alice"
          (cl-letf (((symbol-function 'completing-read)
                     (lambda (&rest _) "Alice")))
            (with-current-buffer (find-file-noselect people-file)
              (mjhoy/org-capture-people-location "Meeting Notes")

              ;; Check that we're in the right buffer
              (should (equal (buffer-file-name) people-file))

              ;; Check that we're at the end of the Meeting Notes heading line
              (should (equal (thing-at-point 'line t) "** Meeting Notes\n"))
              (should (= (point) (line-end-position)))

              ;; Check that the current heading is Meeting Notes under Alice
              (save-excursion
                (org-back-to-heading t)
                (let ((current-heading (org-get-heading t t t t))
                      (parent-heading (save-excursion
                                        (org-up-heading-safe)
                                        (org-get-heading t t t t))))
                  (should (equal current-heading "Meeting Notes"))
                  (should (equal parent-heading "Alice")))))))
      (when (file-exists-p org-directory)
        (delete-directory org-directory t)))))

(ert-deftest test-mjhoy/org-capture-people-location-bob-meeting-notes ()
  "Test that we navigate to Bob's Meeting Notes correctly"
  (let ((org-directory (make-temp-file "org-test-" t))
        (people-file nil))
    (unwind-protect
        (progn
          (setq people-file (concat org-directory "people.org"))
          (with-temp-file people-file
            (insert mjhoy/test-people-org-content))

          ;; Mock completing-read to return "Bob"
          (cl-letf (((symbol-function 'completing-read)
                     (lambda (&rest _) "Bob")))
            (with-current-buffer (find-file-noselect people-file)
              (mjhoy/org-capture-people-location "Meeting Notes")

              ;; Check that we're at the end of the Meeting Notes heading line
              (should (equal (thing-at-point 'line t) "** Meeting Notes\n"))
              (should (= (point) (line-end-position)))

              ;; Check parent heading is Bob
              (save-excursion
                (org-back-to-heading t)
                (let ((current-heading (org-get-heading t t t t))
                      (parent-heading (save-excursion
                                        (org-up-heading-safe)
                                        (org-get-heading t t t t))))
                  (should (equal current-heading "Meeting Notes"))
                  (should (equal parent-heading "Bob")))))))
      (when (file-exists-p org-directory)
        (delete-directory org-directory t)))))

(ert-deftest test-mjhoy/org-capture-person-heading ()
  "Test that we navigate to a person's heading correctly for action items"
  (let ((org-directory (make-temp-file "org-test-" t))
        (people-file nil))
    (unwind-protect
        (progn
          (setq people-file (concat org-directory "people.org"))
          (with-temp-file people-file
            (insert mjhoy/test-people-org-content))

          ;; Mock completing-read to return "Carol"
          (cl-letf (((symbol-function 'completing-read)
                     (lambda (&rest _) "Carol")))
            (with-current-buffer (find-file-noselect people-file)
              (mjhoy/org-capture-person-heading)

              ;; Check that we're at the end of Carol's heading line
              (should (equal (thing-at-point 'line t) "* Carol\n"))
              (should (= (point) (line-end-position)))

              ;; Check that the current heading is Carol
              (save-excursion
                (org-back-to-heading t)
                (let ((current-heading (org-get-heading t t t t)))
                  (should (equal current-heading "Carol")))))))
      (when (file-exists-p org-directory)
        (delete-directory org-directory t)))))

(provide 'init-org/captures-test)
