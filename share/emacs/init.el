(require 'package)

;; TSL/SSL (gnutls 3.6.3+) workaround for emacs below 26.3
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; Package repositories
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; Keep the installed packages in .emacs.d
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
(package-initialize)

;; Update package metadada if local cache is missing
(unless package-archive-contents
  (package-refresh-contents))

;; Create and set the autosave/backup directory
(defconst my-backup-directory
  (expand-file-name "backups/" user-emacs-directory))

(unless (file-exists-p my-backup-directory)
  (make-directory my-backup-directory))

(setq make-backup-files t)
(setq backup-directory-alist `((".*" . ,my-backup-directory)))

(setq auto-save-default t)
(setq auto-save-file-name-transforms `((".*" ,my-backup-directory t)))
(setq auto-save-list-file-prefix my-backup-directory)

;; Does not create lockfiles
(setq create-lockfiles nil)

;; UI customization

;; Disable blink cursor
(when (fboundp 'blink-cursor-mode)
  (blink-cursor-mode -1))

;; Disable startup screen
(setq inhibit-startup-screen t)

;; Disable the annoying bell ring
(setq ring-bell-function 'ignore)

;; Hide menu, tool and scroll bars
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(when (fboundp 'toggle-scroll-bar)
  (toggle-scroll-bar -1))
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; Display line/column number and size in every buffer
(when (fboundp 'column-number-mode)
  (column-number-mode t))
(when (fboundp 'line-number-mode)
  (line-number-mode t))
(when (fboundp 'size-indication-mode)
  (size-indication-mode t))
(when (fboundp 'global-display-line-numbers-mode)
  (global-display-line-numbers-mode))

;; Left-margin relative line numbers (mode line settings)
(setq-default display-line-numbers-type 'relative)
(setq-default display-line-numbers-current-absolute t)
(setq-default display-line-numbers-width 3)
(setq-default display-line-numbers-widen t)

;; Natural (a.k.a nice) scrolling
(setq scroll-margin 0)
(setq scroll-conservatively 100000)
(setq scroll-preserve-screen-position 1)

;; No soft-wraping of long lines
(setq-default truncate-lines t)

;; Enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; JetBrains Mono font
(set-frame-font "JetBrains Mono 12")

;; Editing customization

;; Auto-pairing (parenthesis, brackets, quotes, etc)
(electric-pair-mode +1)

;; Some indentation automation
(electric-indent-mode +1)

;; Always use spaces instead of tabs, but maintain correct appearance
(setq-default indent-tabs-mode nil)
(setq-default tab-width 8)

;; Miscellaneous

;; Fill column indicator
(setq-default fill-column 80)
(setq display-fill-column-indicator-column t)
(setq display-fill-column-indicator-character ?|)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

(setq x-select-enable-clipboard t)
(setq confirm-kill-emacs 'yes-or-no-p)

;; Revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

;; UTF-8 encoding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; Set custom file name so Emacs won't change init.el
(defconst my-custom-file
  (expand-file-name "custom.el" user-emacs-directory))
(setq custom-file my-custom-file)
(when (file-exists-p my-custom-file)
  (load custom-file))

;; Spell-checking configuration
(setq ispell-program-name (executable-find "hunspell")
      ispell-dictionary "en_US")

;; Packages configuration/installation/requirement

;; use-package package for package configuration/requirement
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)

;; Packages/archive signature workaround for emacs below 26.3
(use-package gnu-elpa-keyring-update
  :ensure t)

;; If the gnu-elpa-keyring-update fails to install:
;; * Open emacs
;; * M-: (setq package-check-signature nil)
;; * M-x package-refresh-contents RET
;; * M-x package-install RET gnu-elpa-keyring-update RET
;; * Close emacs and reopen it

;; Built-in packages

(use-package flyspell
  :config
  (setq flyspell-issue-message-flag nil))

(use-package hl-line
  :config
  (global-hl-line-mode +1))

(use-package lisp-mode
  :config
  (add-hook 'emacs-lisp-mode-hook #'eldoc-mode))

(use-package paren
  :config
  (show-paren-mode +1))

(use-package whitespace
  :config
  (setq whitespace-line-column 80)
  (setq whitespace-style
        '(face empty lines-tail newline newline-mark tabs tabs-mark trailing))
  (setq whitespace-display-mappings
        '((newline-mark 10 [172 10])
          (tabs-mark 9 [187 9])))
  (setq whitespace-global-modes '(not org-mode))
  (global-whitespace-mode))

;; Third-party packages

;; Create and set the cider history directory
(defconst cider-directory
  (expand-file-name "cider/" user-emacs-directory))
(unless (file-exists-p cider-directory)
  (make-directory cider-directory))

(use-package cider
  :ensure t
  :config
  (add-hook 'cider-mode-hook 'eldoc-mode)
  (add-hook 'clojure-mode-hook 'cider-mode)
  (setq cider-repl-pop-to-buffer-on-connect t)
  (setq cider-repl-history-file
        (expand-file-name "history" cider-directory)))

;; https://github.com/clojure-emacs/clojure-mode
(use-package clojure-mode
  :ensure t
  :config)

(use-package clojure-mode-extra-font-locking
  :ensure t
  :requires clojure-mode-extra-font-locking)

;; https://github.com/purcell/exec-path-from-shell
(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package ido-completing-read+
  :ensure t
  :config
  ;; CWD-files only/partial matches/recent file in buffer names
  (setq ido-auto-merge-work-directories-length -1)
  (setq ido-enable-flex-matching t)
  (setq ido-use-virtual-buffers t)
  ;; enable ido in all (possible) contexts
  (ido-mode t)
  (ido-ubiquitous-mode t)
  (ido-everywhere t))

(use-package inf-ruby
  :ensure t)

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status))
  :config
  (setq magit-remote-set-if-missing t)
  (setq git-commit-summary-max-length 50)
  (setq git-commit-fill-column 72))

(use-package markdown-mode
  :ensure t
  :config
  (add-hook 'markdown-mode-hook 'imenu-add-menubar-index)
  (setq imenu-auto-rescan t))

(use-package imenu-list
  :ensure t
  :bind (("C-'" . imenu-list-smart-toggle))
  :config
  (setq imenu-list-focus-after-activation t
        imenu-list-auto-resize nil))

(use-package paredit
  :ensure t
  :config
  ;; enable in *scratch* buffer
  (add-hook 'emacs-lisp-mode-hook #'paredit-mode)
  (add-hook 'lisp-interaction-mode-hook #'paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'paredit-mode)
  (add-hook 'clojure-mode-hook #'paredit-mode))

(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode))

(use-package rg
  :ensure t
  :config
  (rg-enable-default-bindings))

(use-package rspec-mode
  :ensure t
  :config
  (add-hook 'after-init-hook 'inf-ruby-switch-setup))

(use-package evil
  :ensure t
  :config
  (evil-mode 1))

;; Color themes
(defun system-theme-is (theme-name)
  (let ((theme (getenv "SYSTEM_THEME")))
    (and theme (string= theme-name theme))))

(defun system-theme-starts-with (text)
  (let ((theme (getenv "SYSTEM_THEME")))
    (and theme (if (string-prefix-p text theme) t nil))))

(cond ((system-theme-is "nord")
       (use-package nord-theme
                    :ensure t
                    :config
                    (load-theme 'nord t)))
      ((system-theme-is "iceberg-dark")
       (use-package iceberg-theme
                    :ensure t
                    :config
                    (iceberg-theme-create-theme-file)
                    (load-theme 'solarized-iceberg-dark t)))
      ((system-theme-is "gruvbox-material-light")
         (use-package gruvbox-theme
                    :ensure t
                    :config
                    (load-theme 'gruvbox-light-soft t)))
      (t (use-package material-theme
                    :ensure t
                    :config
                    (load-theme 'material-light t))))
