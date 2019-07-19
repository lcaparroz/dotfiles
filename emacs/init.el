(require 'package)

;; Package repositories
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("gnu-elpa" . "https://elpa.gnu.org/packages/") t)

;; Keep the installed packages in .emacs.d
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
(package-initialize)

;; Update package metadada if local cache is missing
(unless package-archive-contents
  (package-refresh-contents))

;; Create and set the autosave/backup directory
(defconst my-backup-directory (expand-file-name "backups/" user-emacs-directory))

(unless (file-exists-p my-backup-directory)
  (make-directory my-backup-directory))

(setq make-backup-files t)
(setq backup-directory-alist `((".*" . ,my-backup-directory)))

(setq auto-save-default t)
(setq auto-save-file-name-transforms `((".*" ,my-backup-directory t)))
(setq auto-save-list-file-prefix my-backup-directory)

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

;; Enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; Menlo font
(set-frame-font "Menlo 12")

;; Editing customization

;; Auto-pairing (parenthesis, brackets, quotes, etc)
(electric-pair-mode +1)

;; Some indentation automation
(electric-indent-mode +1)

;; Always use spaces instead of tabs, but maintain correct appearance
(setq-default indent-tabs-mode nil)
(setq-default tab-width 8)

;; Miscellaneous
(setq-default fill-column 81)
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

;; Built-in packages

(use-package flyspell
  :config
  (setq flyspell-issue-message-flag nil))

(use-package hl-line
  :config
  (global-hl-line-mode +1))

(use-package lisp-mode
  :config
  (add-hook 'emacs-lisp-mode-hook #'eldoc-mode)
  (add-hook 'emacs-lisp-mode-hook #'paredit-mode)
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode))

(use-package paren
  :config
  (show-paren-mode +1))

(use-package whitespace
  :config
  (setq whitespace-line-column 81)
  (setq whitespace-style
        '(face empty lines-tail newline newline-mark tabs tabs-mark trailing))
  (setq whitespace-display-mappings
        '((newline-mark 10 [172 10])
          (tabs-mark 9 [187 9])))
  (setq whitespace-global-modes '(not org-mode))
  (global-whitespace-mode))


(use-package windmove
  :config
  ;; shift + arrow keys to switch between windows
  (windmove-default-keybindings))

;; Third-party packages

(use-package deft
  :ensure t)

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
  :bind (("C-x g" . magit-status)))

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

(use-package material-theme
  :ensure t
  :config
  (load-theme 'material-light t))

(use-package seoul256-theme
  :ensure t
  :config
  (setq seoul256-background 256)
  (setq seoul256-alternative-background 237)
  (load-theme 'seoul256 t))

(use-package paredit
  :ensure t
  :config
  ;; enable in *scratch* buffer
  (add-hook 'lisp-interaction-mode-hook #'paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'paredit-mode))

(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

(use-package rainbow-delimiters
  :ensure t)

(use-package rg
  :ensure t
  :config
  (rg-enable-default-bindings))

(use-package rspec-mode
  :ensure t
  :config
  (add-hook 'after-init-hook 'inf-ruby-switch-setup))
