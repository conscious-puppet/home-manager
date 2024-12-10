;;; magit.el --- Description -*- lexical-binding: t; -*-

(setq auto-revert-check-vc-info t)
(with-eval-after-load 'magit-mode
  (add-hook 'after-save-hook 'magit-after-save-refresh-status t))
(setq magit-blame-styles ;; vertical blame
      '((margin
         ;; (margin-width . 60)
         (margin-width . 39)
         ;; (margin-format . ("%.6H %-15.15a %C %s"))
         (margin-format . ("%.6H %-15.15a %C"))
         (margin-face . (magit-blame-margin))
         (margin-body-face . (magit-blame-dimmed))
         (show-message . t)
         )))

;;; magit.el ends here
