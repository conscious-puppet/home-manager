;;; pdf-tools.el --- Description -*- lexical-binding: t; -*-

(use-package pdf-tools
  :hook (pdf-view-mode . (lambda ()
                           (evil-mode t)
                           (pdf-view-midnight-minor-mode t)
                           ))
  :init
  (setq-default pdf-view-midnight-invert nil)
  :config
  (map! :after pdf-view
        :map pdf-view-mode-map
        :n "/" 'pdf-occur)
  (map! :after pdf-occur
        :map pdf-occur-buffer-mode-map
        :n "n" (lambda () (interactive) (forward-line) (pdf-occur-view-occurrence))
        :n "N" (lambda () (interactive) (forward-line -1) (pdf-occur-view-occurrence))))

;;; pdf-tools.el ends here
