(defun kicad-update-attr ()
  (interactive)
  (let ((fps))
    (while (search-forward "(module ")
      (beginning-of-line)
      (let* ((start (point))
             (mod (read (current-buffer)))
             (fp (nth 1 mod)))
        (unless (assoc 'attr mod)
          (when (or (member fp fps)
                    (y-or-n-p (format "Mark footprint %s as SMD?" fp)))
            (add-to-list 'fps fp)
            (save-excursion
              (goto-char start)
              (search-forward "(path")
              (end-of-line)
              (insert "\n    (attr smd)"))))))))
