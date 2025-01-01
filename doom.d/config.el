;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq user-full-name "Abhishek Singh")

;; font
(setq-local puppet/font "Iosevka")
(setq doom-font (font-spec :family puppet/font :size 21 :weight 'medium)
      doom-variable-pitch-font (font-spec :family puppet/font :size 22)
      doom-unicode-font (font-spec :family puppet/font)
      doom-big-font (font-spec :family puppet/font :size 34 :weight 'regular))
(setq-default line-spacing 3) ;; 3% more line height i guess

;; appearance
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(add-to-list 'default-frame-alist '(fullscreen . fullscreen))


;; dashboard
(setq fancy-splash-image (concat doom-user-dir "/etc/splash/blackhole.png"))
(setq +doom-dashboard-functions #'(doom-dashboard-widget-banner doom-dashboard-widget-loaded))


;; org
(setq display-line-numbers-type 'relative)
(setq org-directory "~/org/")
(add-hook 'org-mode-hook (lambda () (display-line-numbers-mode 0)))

;; startup
;; set up the $PATH for emacs gui
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
(when (daemonp)
  (exec-path-from-shell-initialize))

;; settings
(setq auto-save-default nil)
(setq +evil-want-o/O-to-continue-comments nil)
(setq +default-want-RET-continue-comments t)
(setq evil-split-window-below t)
(setq evil-vsplit-window-right t)
;; Reload buffer if file on disk has changed (unless local changes exist)
(setq global-auto-revert-mode t)

;; keymaps
;; resize windows with ctrl arrow keys
(global-set-key (kbd "<C-down>") 'shrink-window)
(global-set-key (kbd "<C-up>") 'enlarge-window)
(global-set-key (kbd "<C-right>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-left>") 'enlarge-window-horizontally)
(map! :n "gf" 'evil-find-file-at-point-with-line)
;; (map! :n "L" 'switch-to-prev-buffer)
;; (map! :n "H" 'switch-to-next-buffer)
(map! :n "]c" #'+vc-gutter/next-hunk)
(map! :n "[c" #'+vc-gutter/previous-hunk)


;; latex
;; https://michaelneuper.com/posts/efficient-latex-editing-with-emacs/
(setq +latex-viewers '(pdf-tools))


;; load dockerfile config
(load (concat doom-user-dir "config/dockerfile.el"))

;; load dired config
(load (concat doom-user-dir "config/dired.el"))

;; load command window customisation
(load (concat doom-user-dir "config/command-window.el"))

;; load magit customisation
(load (concat doom-user-dir "config/magit.el"))

;; load pdf-tools customisation
(load (concat doom-user-dir "config/pdf-tools.el"))
