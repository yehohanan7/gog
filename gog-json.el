(defun gog/split (s)
  (split-string
   (let ((case-fold-search nil))
     (downcase
      (replace-regexp-in-string "\\([a-z]\\)\\([A-Z]\\)" "\\1 \\2" s)))
   "[^A-Za-z0-9]+"))

(defun gog/underscore (s)
  (mapconcat 'downcase   (gog/split s) "_"))

(defun gog-json ()
  (interactive)
  (save-excursion    
    (let ((end (line-number-at-pos)))
      (goto-char (mark))
      (let ((start (line-number-at-pos)))
        (while (< start end)
          (let ((line (string-trim (thing-at-point 'line))))
            (if (not (string-blank-p line))
                (let* ((words (split-string line))
                       (json-var (gog/underscore (car words)))
                       (result (format "  `json:\"%s\"`"  json-var)))
                  (move-end-of-line 1)
                  (insert result)
                  (move-beginning-of-line 1)))
            (forward-line)
            (incf start)))))))

(provide 'gog-json)
