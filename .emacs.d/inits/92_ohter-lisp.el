;; -----------------------------------------------
;;; scratch-popの設定
;; C-c cで*scratch*バッファを開く
;; C-gで閉じる
;; C-c C-eでバッファを全消去
;; C-c C-cでバッファの内容をkill-ringに入れて閉じる
(require 'scratch-pop)
(global-set-key (kbd "C-c c") 'scratch-pop)

;;; ついでにscratchバッファを快適にする設定
;; (makunbound 'scratch-ext-minor-mode-map)
(define-minor-mode scratch-ext-minor-mode
  "*scratch*バッファ専用のマイナーモード"
  nil ""
  '(
    ("\C-c\C-c" . scratch-pop-kill-ring-save-exit)
    ("\C-c\C-e" . erase-buffer)
    ))

(with-current-buffer (get-buffer-create "*scratch*")
  (erase-buffer)
  (ignore-errors
    (insert-file-contents auto-save-buffers-enhanced-file-related-with-scratch-buffer))
; (org-mode)                            ;好みに応じて
  (setq header-line-format "scratch!!")
  (scratch-ext-minor-mode 1))

(defun scratch-pop-kill-ring-save-exit ()
  "*scratch*バッファの内容をkill-ringに入れてから閉じる"
  (interactive)
  (kill-new (buffer-string))
  (erase-buffer)
  (funcall (if (fboundp 'popwin:close-popup-window)
               'popwin:close-popup-window
             'quit-window)))

;(define-key scratch-ext-minor-mode-map (kbd "C-c C-c") 'scratch-pop-kill-ring-save-exit)


;;; C-x a sでauto-save-buffers-enhancedの有効・無効をトグル
(global-set-key "\C-xas" 'auto-save-buffers-enhanced-toggle-activity)



;; -----------------------------------------------
(require 'auto-save-buffers-enhanced)

;;; *scratch*を ~/.emacs.d/scratch に自動保存するだけ
;;; ファイルを自動保存したい人はregexpsの設定をしてください
; (setq auto-save-buffers-enhanced-include-regexps '(".+")) ;全ファイル
(setq auto-save-buffers-enhanced-include-regexps nil)
;; not-save-fileと.ignoreは除外する
; (setq auto-save-buffers-enhanced-exclude-regexps '("^not-save-file" "\\.ignore$"))
(setq auto-save-buffers-enhanced-exclude-regexps nil)
;;; *scratch*も ~/.emacs.d/scratch に自動保存
(setq auto-save-buffers-enhanced-save-scratch-buffer-to-file-p t)
(setq auto-save-buffers-enhanced-file-related-with-scratch-buffer
      (locate-user-emacs-file "scratch"))
(auto-save-buffers-enhanced t)

;;; Wroteのメッセージを抑制
(setq auto-save-buffers-enhanced-quiet-save-p t)

;;; C-x a sでauto-save-buffers-enhancedの有効・無効をトグル
(global-set-key "\C-xas" 'auto-save-buffers-enhanced-toggle-activity)



;; -----------------------------------------------
;; window-numbering
;; 数字+Altで分割画面をジャンプ
(window-numbering-mode 1)
(setq window-numbering-assign-func
      (lambda () (when (equal (buffer-name) "*Calculator*") 9)))


;; アクティブな window を可視化する hiwin-mode
(require 'hiwin)
(hiwin-mode) ; 起動時から有効にしたい場合
(cond ((eq window-system nil)
	   (set-face-background 'hiwin-face "gray30"))	;; ターミナルの場合
      (rec-u
       (set-face-background 'hiwin-face "gray85"))  ;; 非アクティブウィンドウの背景色を設定
      (cyg-p rem-u
             (set-face-background 'hiwin-face "gray30"))  ;; 非アクティブウィンドウの背景色を設定
      )
;(set-face-background 'hiwin-face "gray90")

;; ;; undo-treeモードの設定 (C-x u)
;; (when (require 'undo-tree nil t)
;;   (global-undo-tree-mode))


;;; redo+
(require 'redo+)
(global-set-key (kbd "C-M-/") 'redo)
(setq undo-no-redo t)                   ;; 過去のundoがredoされないようにする
(setq undo-limit 600000)
(setq undo-strong-limit 900000)

;; popwin.el
(setq pop-up-windows nil)
(require 'popwin nil t)
(when (require 'popwin nil t)
  (setq anything-samewindow nil)
  (setq display-buffer-function 'popwin:display-buffer)
  (push '("*Buffer+File*" :height 0.3) popwin:special-display-config)
  (push '("helm" :regexp t :height 0.4) popwin:special-display-config)
  (push '("*Completions*" :height 0.4) popwin:special-display-config)
  (push '("*compilation*" :height 0.4 :noselect t :stick t) popwin:special-display-config)
  (push '("*Helm Swoop*" :height 0.4) popwin:special-display-config)
  (push '("Swoop" :regexp t :height 0.4) popwin:special-display-config)
  )


;; C-u C-n や C-u C-pとタイプすればace-jump-line-modeが発動
(defadvice next-line (around my-next-line activate)
  (if (eq (ad-get-arg 0) 4)
      (ace-jump-line-mode)
    ad-do-it))
(defadvice previous-line (around my-previous-line activate)
  (if (eq (ad-get-arg 0) 4)
      (ace-jump-line-mode)
    ad-do-it))



;; -----------------------------------------------
;; shell-pop
;(require 'shell-pop)'
; 
;(custom-set-variables
; '(shell-pop-default-directory "~/")
; '(shell-pop-shell-type (quote ("eshell" "*eshell*"
;                                (lambda nil (eshell shell-pop-term-shell)))))
; '(shell-pop-term-shell "C:/bin/ConEmuPack/app/nyaos3/nyaos.exe")
; '(shell-pop-universal-key "C-t")
; '(shell-pop-window-height 30)
; '(shell-pop-full-span t)
; '(shell-pop-window-position "bottom"))


;;; nyaosを利用する場合 暫定版
;; (setq nyaos.exe nil)
;(setq nyaos.exe
;      (or (executable-find "nyaos")
;          (executable-find (concat "c:\\bin\\ConEmuPack\\app\\nyaos3" "\\nyaos"))))
;(when nyaos.exe
;  (setq explicit-shell-file-name nyaos.exe
;        shell-file-name explicit-shell-file-name
;        shell-command-switch ""
;        explicit-nyaos.exe-args '()
;        shell-file-name-chars "~/A-Za-z0-9_^$!#%&{}@`'.,:()-")
;  )

;; bashを利用する場合
;(setq explicit-shell-file-name "C:/path/to/bash.exe")
;(setq shell-file-name "bash")
;(setq explicit-bash.exe-args '("--noediting" "--login" "-i"))
;(setenv "SHELL" shell-file-name)
;(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)


;; multi-term
(require 'multi-term)
;(setq nyaos.exe
;      (or (executable-find "nyaos")
;          (executable-find (concat "c:\\bin\\ConEmuPack\\app\\nyaos3" "\\nyaos"))))
;(when nyaos.exe
;  (setq explicit-shell-file-name nyaos.exe
;        shell-file-name explicit-shell-file-name

;(setq explicit-shell-file-name "C:/bin/ConEmuPack/app/nyaos3/nyaos.exe")
;(setq shell-file-name explicit-shell-file-name)
;(add-to-list 'exec-path "C:/bin/ConEmuPack/app/nyaos3")

;(setq multi-term-program "C:\\bin\\ConEmuPack\\app\\nyaos3\\nyaos.exe")



;; volatile-highlights。undoやyankした後にどこが変わったかをハイライトしてくれる
(require 'volatile-highlights)
(volatile-highlights-mode t)



;; loccur
(require 'loccur)



;; sync-recentf
;; recentf(最近開いたファイル)を複数のEmacs間で同期
(require 'sync-recentf)
(setq recentf-auto-cleanup 60)
(recentf-mode 1)

