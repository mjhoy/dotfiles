(if (file-exists-p (expand-file-name "~/proj/linear-emacs"))
    (progn
      (add-to-list 'load-path (expand-file-name "~/proj/linear-emacs"))
      (require 'linear)
      ))

(provide 'init-linear)
