(require 'orderless)

(setopt completion-styles '(orderless basic)
      completion-category-overrides '((files (styles basic partial-completion))))

(provide 'init-orderless)
