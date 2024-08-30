(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode 1)
(show-paren-mode 1)
(save-place-mode 1)
(global-auto-revert-mode 1)
(global-hl-line-mode 0)

(setq visible-bell 0)
(setq bell-volume 0)
(setq ring-bell-function 'flash-mode-line)

(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(setq use-dialog-box nil)
(setq global-auto-revert-non-file-buffers t)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq history-length 100)
(savehist-mode 1)

(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

(if (eq system-type 'darwin)
    (setq dired-listing-switches "-lahB")
    (setq dired-listing-switches "-lahB --group-directories-first"))

(when (eq system-type 'darwin)
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char)) ; sets fn-delete to be right-delete

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

(load-theme 'deeper-blue t)

(global-set-key [remap list-buffers] 'ibuffer) ; nicer buffer switching with C-x C-b
