;;; packages.el --- pfc-fish layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author:  <neoarch@neoarch>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `pfc-fish-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `pfc-fish/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `pfc-fish/pre-init-PACKAGE' and/or
;;   `pfc-fish/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst pfc-fish-packages
  '((pfc-fish :location local)
    (ob-pfc-fish :location local)
    (company-pfc :location local :requires company)
    enlive
    eldoc))

(defun pfc-fish/init-pfc-fish ()
  (use-package pfc-fish
    :defer t
    :commands pfc-fish-mode
    :mode ("\\(?:\\.\\(?:fis\\|p\\(?:2\\(?:d\\(?:at\\|vr\\)\\|fis\\)\\|3\\(?:d\\(?:at\\|vr\\)\\|fis\\)\\)\\)\\)" . pfc-fish-mode)
    :init
    (progn
      (spacemacs/declare-prefix-for-mode 'pfc-fish-mode "mh" "help")
      (spacemacs/set-leader-keys-for-major-mode 'pfc-fish-mode
        "hh" 'pfc-describe-thing-at-point)
      (add-to-list 'display-buffer-alist
                   '("\\*w3m\\*" . ((display-buffer-reuse-window
                                     display-buffer-pop-up-window)
                                    . ((inhibit-duplicate-buffer . t)
                                       (inhibit-same-window      . t))))))))

(defun pfc-fish/init-ob-pfc-fish ()
  (use-package ob-pfc-fish
    :defer t
    :init
    (with-eval-after-load 'org
      (require 'ob-pfc-fish)
      (add-to-list 'org-babel-load-languages '(pfc-fish . t)))))

(defun pfc-fish/init-company-pfc ()
  (use-package company-pfc
    :defer t
    :init
    (progn
      (when (configuration-layer/package-used-p 'pfc-fish)
        (spacemacs|add-company-backends
          :backends (company-pfc company-dabbrev-code company-yasnippet)
          :modes pfc-fish-mode))
      (with-eval-after-load 'company-dabbrev-code
        (push 'pfc-fish-mode company-dabbrev-code-modes)))))

(defun pfc-fish/init-enlive ()
  (use-package enlive
    :defer t))

(defun pfc-fish/post-init-eldoc ()
  (with-eval-after-load "eldoc"
    (setq eldoc-idle-delay 0)))

;;; packages.el ends here
