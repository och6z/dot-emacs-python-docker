;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Miscellaneous settings ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; completion framework "complete anything" for emacs
(use-package company
  :ensure t
  :defer t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (setq company-tooltip-align-annotations t
        company-idle-delay 0.2
        company-minimum-prefix-length 2
        company-require-match nil
        company-dabbrev-ignore-case nil
        company-dabbrev-code-ignore-case nil
        company-dabbrev-downcase nil))

;; documentation popup for company
(use-package company-quickhelp
  :ensure t
  :after company
  :init
  (with-eval-after-load 'company
    (company-quickhelp-mode)))

;; superior lisp interaction mode for emacs
(use-package slime
  :ensure t
  :init
  (setq inferior-lisp-program "sbcl"
        slime-contribs '(slime-fancy)))

;; company-mode completion backend for slime
(use-package slime-company
  :ensure t
  :defer t
  :after
  (:all slime company)
  :init
  (slime-setup '(slime-fancy slime-company)))

;; make bindings
(use-package hydra
  :ensure t
  :defer t)

;; template system
(use-package yasnippet
  :ensure t
  :init
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  :config
  (setq yas-snippet-dirs
        (cl-union yas-snippet-dirs
                  '("~/.emacs.d/snippets")))
  (yas-reload-all)
  (yas-global-mode t))

;; DocView mode is a major mode for viewing DVI, PostScript (PS), PDF, OpenDocument, and Microsoft Office documents
(use-package doc-view
  :defer t
  :config
  (setq doc-view-continuous t))

;; automatically reverts the current buffer when its visited file changes on disk
(use-package auto-revert
  :defer t
  :init
  (global-auto-revert-mode t)
  (setq revert-without-query t))

;; another alternative to ordinary line continuation is to use word wrap
(use-package visual-line
  :defer t
  :init
  (global-visual-line-mode t))

;; managing multiple terminal buffers
(use-package multi-term
  :ensure t
  :defer t)

;; add the symbol name to the features list
(provide 'misc-settings)
