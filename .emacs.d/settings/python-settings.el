;;;;;;;;;;;;;;;;;;;;;
;; Python settings ;;
;;;;;;;;;;;;;;;;;;;;;

;; python language in emacs
(use-package python
  :ensure nil
  :mode
  ("\\.py$" . python-mode)
  :config
  (setq python-shell-interpreter "python3"
        python-indent-offset 4
        python-indent-guess-indent-offset t
        python-indent-guess-indent-offset-verbose nil
        ;; iPython interpreter
        ; python-shell-interpreter "ipython"
        ; python-shell-interpreter-args "--simple-prompt -i"
        ))

;; emacs python development environment
(use-package elpy
  :ensure t
  :defer t
  :after python
  :init
  (add-hook 'python-mode-hook 'elpy-mode)
  :load-path "~/.emacs.d/elpa/elpy-[0-9.]*\\'"
  :config
  (setq elpy-rpc-python-command "python3"
        elpy-rpc-virtualenv-path 'system)
  )

;; use autopep8 to beautify a python buffer
(use-package py-autopep8
  :ensure t
  :after python
  :config
  (setq py-autopep8-options '("--max-line-length=100"))
  :init
  (add-hook 'python-mode-hook 'py-autopep8-enable-on-save))

;; use isort to sort the imports in a python buffer
(use-package py-isort
  :ensure t
  :after python
  :config
  (setq py-isort-options '("--lines=100"))
  :init
  (add-hook 'before-save-hook 'py-isort-before-save))

;; add the symbol name to the features list
(provide 'python-settings)
