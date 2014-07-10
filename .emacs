;; Prevent the cursor from blinking
(blink-cursor-mode 0)
;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
;; Don't let Emacs hurt your ears
(setq visible-bell t)

(show-paren-mode 1)

(global-set-key (kbd "C-c f") 'helm-ls-git-ls)
(global-set-key "\C-h" 'backward-delete-char)

;; You need to set `inhibit-startup-echo-area-message' from the
;; customization interface:
;; M-x customize-variable RET inhibit-startup-echo-area-message RET
;; then enter your username
(setq inhibit-startup-echo-area-message)
(scroll-bar-mode 0)
(tool-bar-mode 0)
;; (menu-bar-mode 0)

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

;; See http://bzg.fr/emacs-hide-mode-line.html
(defvar-local hidden-mode-line-mode nil)
(defvar-local hide-mode-line nil)
 
(define-minor-mode hidden-mode-line-mode
  "Minor mode to hide the mode-line in the current buffer."
  :init-value nil
  :global nil
  :variable hidden-mode-line-mode
  :group 'editing-basics
  (if hidden-mode-line-mode
      (setq hide-mode-line mode-line-format
            mode-line-format nil)
    (setq mode-line-format hide-mode-line
          hide-mode-line nil))
  (force-mode-line-update)
  (set-window-buffer nil (current-buffer))
  (when (and (called-interactively-p 'interactive)
             hidden-mode-line-mode)
    (run-with-idle-timer
     0 nil 'message
     (concat "Hidden Mode Line Mode enabled.  "
             "Use M-x hidden-mode-line-mode RET to make the mode-line appear."))))
 
;; Activate hidden-mode-line-mode
;;(hidden-mode-line-mode 1)

;; Set the color of the fringe
;;(custom-set-faces
;; '(fringe ((t (:background "white")))))

;;(custom-set-faces
;;  '(default ((t (:background "black" :foreground "grey"))))
;;  '(fringe ((t (:background "black")))))

(show-paren-mode 1)

(global-set-key "\C-h" 'backward-delete-char)
(fset 'yes-or-no-p 'y-or-n-p)

(require 'package)
(add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(unless (package-installed-p 'scala-mode2)
  (package-refresh-contents) (package-install 'scala-mode2))
;; load the ensime lisp code...
;; (add-to-list 'load-path "~/.emacs.d/ensime/elisp/")
;; (require 'ensime)

(helm-mode 1)
(setq helm-ff-auto-update-initial-value 1)

(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'scala-mode2 'sql-mode)
(setq ac-auto-start nil)
(ac-set-trigger-key "TAB")

(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)

(electric-pair-mode 1)
(delete-selection-mode 1)

(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)
(global-set-key (kbd "C-S-b") 'mc/edit-beginnings-of-lines)
(global-set-key (kbd "C-c C-r") 'mc/mark-sgml-tag-pair)


(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#657b83"])
 '(background-color "#002b36")
 '(background-mode dark)
 '(cursor-color "#839496")
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes (quote ("146d24de1bb61ddfa64062c29b5ff57065552a7c4019bee5d869e938782dfc2a" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(foreground-color "#839496")
 '(js3-cleanup-whitespace t)
 '(js3-indent-level 4)
 '(sql-postgres-program "/Applications/Postgres.app/Contents/MacOS/bin/psql")
 '(tab-stop-list (quote (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(set-variable 'magit-emacsclient-executable "/usr/local/bin/emacsclient")
(require 'edbi)


(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)



(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer.
Including indent-buffer, which should not be called automatically on save."
  (interactive)
  (untabify-buffer)
  (delete-trailing-whitespace)
  (indent-buffer))

(global-set-key (kbd "C-c n") 'cleanup-buffer)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-c d") 'sgml-delete-tag)
    
(require 'undo-tree)
(global-undo-tree-mode)

(require 'browse-kill-ring)
(global-set-key (kbd "C-c k") 'browse-kill-ring)

(setq web-mode-enable-current-element-highlight t)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(require 'js3-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
