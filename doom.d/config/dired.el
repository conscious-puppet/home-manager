;;; dired.el --- Description -*- lexical-binding: t; -*-

;; hjkl in dired
(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file
  (kbd "+") 'dired-create-empty-file
  )

;;; dired.el ends here
