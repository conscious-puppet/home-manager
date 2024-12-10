;;; command-window.el --- Description -*- lexical-binding: t; -*-

(eval-after-load 'evil-vars
  '(define-key evil-ex-completion-map (kbd "C-f") 'evil-ex-command-window))
(eval-after-load 'evil-vars
  '(define-key evil-ex-search-keymap (kbd "C-f") 'evil-ex-search-command-window))
(add-hook 'evil-command-window-mode-hook #'turn-off-smartparens-mode)
(add-hook 'minibuffer-setup-hook #'turn-off-smartparens-mode)
(add-hook 'lisp-mode-hook #'turn-off-smartparens-mode)

;;; command-window.el ends here
