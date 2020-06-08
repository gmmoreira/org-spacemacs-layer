;;; packages.el --- gmmoreira-org layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Guilherme Moreira <guilhermemoreira@IDC0221>
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
;; added to `gmmoreira-org-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `gmmoreira-org/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `gmmoreira-org/pre-init-PACKAGE' and/or
;;   `gmmoreira-org/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst gmmoreira-org-packages
  '(org org-roam org-journal)
  "The list of Lisp packages required by the gmmoreira-org layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun gmmoreira-org/post-init-org ()
  (setq
    org-export-coding-system 'utf-8
    org-directory "~/org"
    org-agenda-files '("~/org/" "~/org/roam/")
    )
  )

(defun gmmoreira-org/post-init-org-journal ()
  (spacemacs/set-leader-keys
    "ort" 'org-journal-open-current-journal-file
    "orjj" 'org-journal-new-entry
    "orjt" 'org-journal-new-scheduled-entry
    )
  (setq
    org-journal-dir "~/org/roam/"
    org-journal-date-prefix "#+TITLE: "
    org-journal-file-format "%Y-%m-%d.org"
    org-journal-date-format "%A, %Y-%m-%d"
    )
  )

(defun gmmoreira-org/init-org-roam ()
  (use-package org-roam
    :after org
    :hook (org-mode . org-roam-mode)
    :config
    (require 'org-roam-protocol)
    :custom
    (org-roam-directory "~/org/roam/")
    :bind
    ("C-c n l" . org-roam)
    ("C-c n f" . org-roam-find-file)
    ("C-c n i" . org-roam-insert)
    ("C-c n g" . org-roam-graph-show)
    ("C-c n j" . org-journal-new-entry))
  )

(defun gmmoreira-org/post-init-org-roam ()
  (spacemacs/declare-prefix "or" "org-roam")
  (spacemacs/set-leader-keys
    "ori" 'org-roam-insert
    "orl" 'org-roam
    "org" 'org-roam-graph
    "orbb" 'org-roam-switch-to-buffer
    "orff" 'org-roam-find-file
    "orfi" 'org-roam-jump-to-index
    )
  )
;;; packages.el ends here
