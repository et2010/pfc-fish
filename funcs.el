(defun et/save-with-gbk-coding (path)
  (let ((fn (f-no-ext path))
        (ext (f-ext path)))
    (when (and (not (et/file-ascii-p path))
               ;; make sure we are not replicate the copy again
               (not (f-ext-p fn)))
      (let ((coding-system-for-write 'chinese-gbk-dos)
            (fpath (concat fn ".dos." ext)))
        (with-temp-file fpath
          (insert-file-contents path))))
    nil))

(defun et/file-ascii-p (path)
  (let ((encode (shell-command-to-string (concat "file " path)))
        (prefix (format "%s: ASCII " path)))
    (string-prefix-p prefix encode)))
