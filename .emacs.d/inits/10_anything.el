;---------------------------------------------------------------------
;; anything
(require 'anything-config)
(setq anything-sources
      (list
	anything-c-source-buffers
	anything-c-source-file-cache
	anything-c-source-file-name-history
	anything-c-source-files-in-current-dir
	;; anything-c-source-recentf
	;; anything-c-source-info-pages
	;; anything-c-source-man-pages
	anything-c-source-locate
	anything-c-source-emacs-commands
	anything-c-source-emacs-functions
	    ))
;; (global-set-key "\C-xb" 'anything-for-buffers)
;; (global-set-key "\C-l" 'anything-for-files)
;; (global-set-key "\C-x\C-f" 'anything-find-files)

(setq anything-use-migemo t)


;バッファ内検索
;(global-set-key (kbd "C-x o") 'anything-occur)
 
