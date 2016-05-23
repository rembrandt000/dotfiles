;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ search - migemo                                               ;;;
;;;   https://github.com/emacs-jp/migemo                            ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(require 'migemo)

(defvar migemo-command nil)
(setq migemo-command "cmigemo")

(setq migemo-options '("-q" "--emacs"))

(defvar migemo-dictionary nil)

(defvar migemo-user-dictionary nil)

(defvar migemo-regex-dictionary nil)

(setq migemo-coding-system 'utf-8-unix)

(load-library "migemo")


(when win-p
  (setq migemo-dictionary (expand-file-name (concat my-dropbox-directory "soft/emacs/plugins/dict/utf-8/migemo-dict")))
  (migemo-init)
  )

(when cyg-p
  (defvar migemo-options nil)
  (defvar migemo-coding-system nil)
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  )

(when linux-os
  (setq migemo-dictionary (expand-file-name (concat my-dropbox-directory "soft/emacs/plugins/dict/utf-8/migemo-dict")))
  (migemo-init)
  )

