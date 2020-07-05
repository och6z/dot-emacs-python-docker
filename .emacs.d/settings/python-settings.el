;;;;;;;;;;;;;;;;;;;;;
;; Python settings ;;
;;;;;;;;;;;;;;;;;;;;;

;; python language in emacs
(use-package python
  :ensure nil
  :mode
  ("\\.py$" . python-mode)
  :config
  (setq python-shell-interpreter "ipython"
        python-indent-offset 4
        python-indent-guess-indent-offset t
        python-indent-guess-indent-offset-verbose nil
        ;; iPython interpreter
        python-shell-interpreter-args "-i --simple-prompt"
        ))

;; emacs python development environment
(use-package elpy
  :ensure t
  :defer t
  :after python
  :init
  (add-hook 'python-mode-hook 'elpy-mode)
  ;; (add-hook 'elpy-mode-hook (lambda ()
  ;;                             (add-hook 'before-save-hook
  ;;                                       'elpy-black-fix-code nil t)))
  :load-path "~/.emacs.d/elpa/elpy-[0-9.]*\\'"
  :config
  (setq elpy-rpc-python-command "python"
        elpy-rpc-virtualenv-path 'system)
  )

;; use autopep8 to beautify a python buffer
(use-package py-autopep8
  :ensure t
  :after python
  :config
  (setq py-autopep8-options '(
                              "--max-line-length=72"
                              "--aggressive"
                              "--aggressive"
                              ))
  ;; :init
  ;; (add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
  )

;; python black package to reformat python buffers
(use-package blacken
  :ensure t
  :after python
  :init
  (add-hook 'python-mode-hook 'blacken-mode)
  :config
  (setq blacken-line-length 88
        blacken-skip-string-normalization t
        blacken-fast-unsafe t)
  )

;; yapf to format python buffer
(use-package yapfify
  :ensure t
  :after python)

;; use isort to sort the imports in a python buffer
(use-package py-isort
  :ensure t
  :after python
  ;; :config
  ;; (setq py-isort-options '("--multi-line 3"))
  :init
  (add-hook 'before-save-hook 'py-isort-before-save)
  )

;; add the symbol name to the features list
(provide 'python-settings)
