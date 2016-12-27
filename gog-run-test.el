(defun gog-test-name ()
  (save-excursion
    (re-search-backward "func")
    (re-search-forward "T")
    (word-at-point)))

(defun gog-current-package ()
  (file-relative-name default-directory (concat (getenv "GOPATH") "/src")))

(defun gog-run-test ()
  (interactive)
  (let ((package (gog-current-package))
        (test-name (gog-test-name)))
    (setq gog-run-test-command (format "go test %s -run %s" package test-name))
    (shell-command gog-run-test-command)))

(defun gog-run-last-test ()
  (interactive)
  (shell-command gog-run-test-command))


(provide 'gog-run-test)
