;;;;;;;;;;;;;;;;;;;;;;
;; General settings ;;
;;;;;;;;;;;;;;;;;;;;;;

;; number of bytes of consing between garbage collections
(setq gc-cons-threshold 64000000
      gc-cons-percentage 0.6)

(add-hook 'after-init-hook
          (lambda ()
            ;; restore number of bytes after startup
            (setq gc-cons-threshold 800000
                  gc-cons-percentage 0.1)
            (garbage-collect)) t)

;; character encoding default
(prefer-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)

(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

(setq blink-cursor-mode t
      font-use-system-font nil
      byte-compile-warnings nil
      byte-compile-error-on-warn nil
      browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium")

;; "yes or no" to "y or n"
(defalias 'yes-or-no-p 'y-or-n-p)

;;;;;;;;;;;;;;;;;;;;
;; Editing/Indent ;;
;;;;;;;;;;;;;;;;;;;;

(use-package indent
  :defer t
  :init
  ;; control tabs or space are used for indentation
  (setq-default indent-tabs-mode nil)
  ;; list of tab stop positions
  (setq tab-stop-list (number-sequence 4 200 4))
  ;; untabify spaces when save file
  ;; (add-hook 'write-file-hooks
  ;;           (lambda ()
  ;;             (untabify (point-min) (point-max))))
  )

(use-package electricity
  :defer t
  :preface
  (defun electric-pair-start ()
    (electric-pair-mode t))
  :init
  (add-hook 'after-init-hook 'electric-pair-start)
  (add-hook 'electric-pair-mode-hook
            (lambda ()
              (setq electric-pair-pairs
                    '((?\{ . ?\})))))
  (add-hook 'electric-pair-local-mode-hook
            (lambda ()
              (setq electric-pair-pairs
                    '((?\{ . ?\}))))))

;;;;;;;;;;;;;;;;;;;;;;
;; Editing/Matching ;;
;;;;;;;;;;;;;;;;;;;;;;

;; matching pairs of parentheses and other characters
(use-package paren-showing
  :defer t
  :preface
  (defun show-paren-start ()
    (show-paren-mode t))
  :init
  (add-hook 'after-init-hook 'show-paren-start))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Editing/Editing Basics ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package editing-basics
  :defer t
  :init
  ;; distance between tab stops, in colums
  (setq-default tab-width 4))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Convenience/Whitespace ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; renders spaces, tabs, newlines with a visible glyph
(use-package whitespace
  :init
  (setq whitespace-style '(face trailing tabs spaces newline empty space-mark tab-mark newline-mark))
  (global-whitespace-mode t)
  ;; delete trailing whitespace before saving
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  :custom-face
  (whitespace-trailing ((t (:background "light gray" :foreground "dark-violet"))))
  (whitespace-tab ((t (:background "light gray" :foreground "red"))))
  (whitespace-space-after-tab ((t (:background nil :foreground "yellow"))))
  (whitespace-space ((t (:background nil :foreground "red"))))
  (whitespace-newline ((t (:background nil :foreground "red"))))
  (whitespace-empty ((t (:background "light gray" :foreground nil)))))

;;;;;;;;;;;;
;; Files/ ;;
;;;;;;;;;;;;

(use-package time-stamp
  :init
  (setq time-stamp-pattern '("8/Last modified:[ \t]+\\\\?[\"<]+%:y-%02m-%02d %02H:%02M:%02S\\\\?[\">]"))
  ;; new time stamp every time saving
  (add-hook 'before-save-hook 'time-stamp))

;;;;;;;;;;;;;;;;;;
;; Files/Backup ;;
;;;;;;;;;;;;;;;;;;

(use-package backup
  :defer t
  :init
  ;; copy all files, don't rename
  (setq backup-by-copying t
        ;; use version numbers for backups
        version-control t
        ;; don't ask to delete excess backup versions
        delete-old-versions t
        ;; number of oldest version to keep
        kept-old-versions 1
        ;; number of newest version to keep
        kept-new-versions 5
        ;; default backup directory
        backup-directory-alist '(("" . "~/.emacs.d/backup"))
        ;; backup versioned files
        vc-make-backup-files t))

;;;;;;;;;;;;;;;;;;;;
;; Files/Uniquify ;;
;;;;;;;;;;;;;;;;;;;;

;; construct unique buffer names
(use-package uniquify
  :init
  (setq uniquify-buffer-name-style 'post-forward
        ;; rerationalize buffer names after a buffer has been killed
        uniquify-after-kill-buffer-p t
        ;; regular expression matching buffer names
        uniquify-ignore-buffers-re "^\\*"
        ;; minimum number of directory name components included in buffer name
        uniquify-min-dir-content 3
        ;; string separator for buffer name components
        uniquify-separator "|"))

;;;;;;;;;;;;;;;;;;;;;
;; Files/Auto Save ;;
;;;;;;;;;;;;;;;;;;;;;

(use-package auto-save
  :defer t
  :init
  ;; auto-saving of every file-visiting buffer
  (setq auto-save-default nil))

;;;;;;;;;;;;;;;;;;;
;; Files/Recentf ;;
;;;;;;;;;;;;;;;;;;;

(use-package recentf
  :config
  ;; recentf mode is enabled
  (recentf-mode t))

;;;;;;;;;;;;;;;;;
;; Environment ;;
;;;;;;;;;;;;;;;;;

(use-package initialization
  :defer t
  :init
  ;; turn-off startup screen
  (setq inhibit-startup-screen t
        ;; drop scratch message
        initial-scratch-message nil))

(use-package mode-line
  :defer t
  :init
  ;; column number in minibuffer
  (setq column-number-mode t))

(use-package display
  :defer t
  :init
  (setq-default truncate-lines t)
  ;; turn-off alarm-bell
  (setq ring-bell-function #'ignore))

;;;;;;;;;;;;;;;;;;;;;;
;; Environment/Menu ;;
;;;;;;;;;;;;;;;;;;;;;;

(use-package menu-bar
  :custom-face
  (menu ((t (:background "color-235" :foreground "color-246"))))
  :config
  (menu-bar-mode t))

(use-package tool-bar
  :if
  window-system
  :config
  (tool-bar-mode 0))

;;;;;;;;;;;;;;;;;;;;;;;
;; Faces/Basic Faces ;;
;;;;;;;;;;;;;;;;;;;;;;;

(use-package faces
  :custom-face
  (tty-menu-disabled-face ((t (:background "color-242" :foreground "lightgray"))))
  (tty-menu-enabled-face ((t (:background "color-246" :foreground "color-235")))))

;;;;;;;;;;;;;;;;;;;;
;; Custom themes ;;
;;;;;;;;;;;;;;;;;;;;

(use-package ample-theme
  :init
  (progn (load-theme 'ample t t)
         (enable-theme 'ample))
  :defer t
  :ensure t)

;; add the symbol name to the features list
(provide 'general-settings)
