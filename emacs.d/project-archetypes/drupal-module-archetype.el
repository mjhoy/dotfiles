(defun create-drupal-module (module-name full-name description package)
  (interactive "sModule name (filename): \nsFull name: \nsDescription: \nsPackage: ")
  (pa-with-new-project module-name "drupal-module"
    ((cons "__module-name__" module-name)
     (cons "__full-name__" full-name)
     (cons "__description__" description)
     (cons "__package__" package))))

(pa-declare-project-archetype "drupal-module" 'create-drupal-module)
(provide 'drupal-module-archetype)
