;; Packages
(require 'package)

;; Package repositories
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("gnu-elpa" . "https://elpa.gnu.org/packages/") t)

;; Initialize packages before modifying them
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages
  '(deft
    ido-completing-read+
    magit
    markdown-mode
    material-theme
    paredit
    projectile
    rainbow-delimiters
    rspec-mode))

;; use-package package for package configuration/requirement
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)

;; Built-in packages

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
  (setq whitespace-line-column 80)
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

;; Install packages
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Create the autosave/backup directory
(defconst my-backup-directory (expand-file-name "backups" user-emacs-directory))
(unless (file-exists-p my-backup-directory)
  (make-directory my-backup-directory))

(setq make-backup-files t
      backup-directory-alist `((".*" . ,my-backup-directory)))
(setq auto-save-default t
      auto-save-file-name-transforms `((".*" ,my-backup-directory t))
      auto-save-list-file-prefix my-backup-directory)

;; Default theme
(load-theme 'material-light t)

;; mode line settings
(setq-default display-line-numbers-type 'relative
              display-line-numbers-current-absolute t
              display-line-numbers-width 3
              display-line-numbers-widen t)

(line-number-mode t)
(column-number-mode t)
(global-display-line-numbers-mode)

(blink-cursor-mode -1)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; Hide menu, tool and scroll bars
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; enable ido in all (possible) contexts
(ido-mode t)
(ido-ubiquitous-mode t)
(ido-everywhere t)

(setq ido-auto-merge-work-directories-length -1 ;; only matches files in the CWD
      ido-enable-flex-matching t                ;; partial matches
      ido-use-virtual-buffers t)                ;; include recently used files in buffer names

;; Auto-pair parenthesis, brackets and quote marks
(electric-pair-mode 1)

(electric-indent-mode 1)

(setq-default fill-column 80) ;; Sets a 80 character line width
(setq x-select-enable-clipboard t) ;; Enable copy/past-ing from clipboard
(setq confirm-kill-emacs 'yes-or-no-p) ;; Ask for confirmation before closing emacs

(prefer-coding-system 'utf-8) ;; Prefer UTF-8 encoding
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; disable startup screen
(setq inhibit-startup-screen t)

;; disable the annoying bell ring
(setq ring-bell-function 'ignore)

(global-set-key (kbd "C-x g") 'magit-status)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

(setq rspec-use-docker-when-possible t)
(set-frame-font "Menlo 12")
(setq-default indent-tabs-mode nil) ;; don't use tabs to indent
(setq-default tab-width 8) ;; but maintain correct appearance
