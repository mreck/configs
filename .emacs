;; MacOS
(if (eq system-type 'darwin)
  (setq dired-listing-switches "-lahB")
  (setq dired-listing-switches "-lahB --group-directories-first"))

(when (eq system-type 'darwin)
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char))

;; UI
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(blink-cursor-mode 0)
(column-number-mode t)
(show-paren-mode t)
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

(load-theme 'deeper-blue)
(set-face-attribute 'default nil :height 140)
(fset 'yes-or-no-p 'y-or-n-p)
(setq backup-inhibited t)
(save-place-mode 1)

;; custom functions
;(defun m/what-column()
;  "return the current column number"
;  (string-to-number (car (last (split-string (car (last (split-string (what-cursor-position) " "))) "=")))))

;(defun m/duplicate-line()
;  "duplicate the line, keeping the cursor position"
;  (interactive)
;  (let ((c (m/what-column)))
;    (duplicate-line)))

;; recent files
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;; other window key bindings(global-set-key (kbd "C-x C-F") 'find-file-other-window)
(global-set-key (kbd "C-x F") 'find-file-other-window)

;; leader key bindings
;(global-unset-key (kbd "C-SPC"))
(global-set-key (kbd "S-SPC d") 'duplicate-line)
(global-set-key (kbd "S-SPC r") 'query-replace)
(global-set-key (kbd "S-SPC b") 'ibuffer)
