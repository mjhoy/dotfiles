(defun create-js-lib (project-name description file-name object)
  (interactive "sProject name: \nsDescription: \nsMain JS filename (without the.js): \nsObject name: ")
  (pa-with-new-project project-name "js-lib"
    ((cons "__project-name__" project-name)
     (cons "__description__" description)
     (cons "__file-name__" file-name)
     (cons "__object__" object))))

(pa-declare-project-archetype "js-lib" 'create-js-lib)

(provide 'js-lib-archetype)
