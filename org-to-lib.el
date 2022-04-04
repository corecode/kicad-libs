;;; org-to-lib --- convert org table to kicad library
;;; Commentary:
;;; Code:

(require 'org-table)

(defun 2c-translate-table-to-pins ()
  "Convert org table to kicad library."
  (interactive)
  (let* ((tbuf (current-buffer))
         (obuf (find-file-other-window
               (concat (file-name-sans-extension buffer-file-name) ".lib")))
         (y 1))
    (with-current-buffer tbuf
      (while (org-table-goto-line y)
        (let ((pin (string-trim (org-table-get-field 1)))
              (name (string-trim (org-table-get-field 2)))
              (type (string-trim (org-table-get-field 3))))
          (with-current-buffer obuf
            (insert (substring-no-properties (concat "X " name " " pin " 0 " (format "%d" (* y -100)) " 150 R 40 50 1 1 " type)))
            (newline))
          (setq y (1+ y)))))))
(provide 'org-to-lib)
;;; org-to-lib ends here
