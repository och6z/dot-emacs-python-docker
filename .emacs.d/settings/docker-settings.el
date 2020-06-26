;;;;;;;;;;;;;;;;;;;;;
;; Docker settings ;;
;;;;;;;;;;;;;;;;;;;;;

;; manage Docker from Emacs
(use-package docker
  :ensure t
  :defer t
  :bind ("C-c d" . docker))

;; Emacs mode for handling Dockerfiles
(use-package dockerfile-mode
  :ensure t
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("Dockerfile[a-zA-Z.-]*\\'" . dockerfile-mode)))

;; major mode for editing Docker-compose files
(use-package docker-compose-mode
  :ensure t
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("docker-compose.*\.yml\\'" . docker-compose-mode)))

;; add the symbol name to the features list
(provide 'docker-settings)
