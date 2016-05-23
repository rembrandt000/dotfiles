;; ---------------------------------------------------------------------
;; 連携
;; ace-link.el (Hit-a-Hint)
(ace-link-setup-default)
(define-key org-mode-map (kbd "C-c M-o") 'ace-link-org)
;; wanderlust
(when (locate-library "wl")
  (require 'org-wl))
(setq org-return-follows-link t)

;; ---------------------------------------------------------------------
;; org-mode
(require 'org)

;; キーバインドの設定
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cr" 'org-remember)
(define-key org-mode-map (kbd "C-'") 'helm-imenu)

;; org-modeのルートディレクトリ
(setq org-directory (concat my-dropbox-directory "soft/howm/"))

;; agendaを使う
(setq org-agenda-files (list
                        org-directory
                        (concat org-directory "org")
                        (concat org-directory "2015/10")
                        (concat org-directory "2015/07")
                        (concat org-directory "2015/09")
                        ))


;; ---------------------------------------------------------------------
;; アジェンダでの時間間隔
(setq org-agenda-time-grid
  '((daily today require-timed)
    "----------------"
    (900 1000 1100 1200 1300 1400 1500 1600 1700 1800)))


;; TODO状態
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))
;; DONEの時刻を記録
(setq org-log-done 'time)

;; ---------------------------------------------------------------------
;; org と howm の連携
;(add-hook 'org-mode-hook 'howm-mode)
; Dropbox/Howmの下でorg-modeで編集する場合のみhowm-modeを追加。
(add-hook 'org-mode-hook
          (function (lambda ()
                      (if (string-match org-directory buffer-file-name)
                          (howm-mode)))))


;; title header は "*"
(setq howm-view-title-header "*") ;; ← howm のロードより前に書くこと


;; ORG
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(setq
;; アジェンダを現在のウィンドウで開く
org-agenda-window-setup 'current-window
;; アジェンダは別ウィンドウで開く
;; org-agenda-window-setup (quote other-window)
;;
;; アジェンダから抜けた時に、画面の構成をアジェンダ表示前に戻す
org-agenda-restore-windows-after-quit t)


;; キー割当の重複を避ける (お好みで)
;; C-c , がOrgとぶつかるので、C-x , に変更。
; (global-unset-key (kbd "C-z"))
(setq howm-prefix "\C-z,") ;; howm のキーを「C-c , □」から「C-z □」に変更

; (global-set-key "\C-x,," 'howm-menu)
; (setq howm-prefix "\C-x,")


(add-hook 'howm-mode-hook
          (function (lambda ()
                      ;; Orgは見出しに*を使う。Howmも*を使うようにできるが、そうすると今まで書いたメモがタイトル無しになって悲しいので、Howmは=のままにする。
                      ;; outline-mode的には*と=の両方を見出しとして扱うようにする。Orgの中でoutline-modeの関数を呼んでいるところがあるため。
                      (setq outline-regexp "[*=]+")
                      ;; Dropboxでバックアップがあるので、バックアップファイルは作らなくてもいいだろう。
                      (set (make-local-variable 'backup-inhibited) t))))

(add-hook 'howm-after-save-hook
          (function (lambda ()
                      ;; 内容が空の場合はファイルを削除する。
                      (if (= (point-min) (point-max))
                          (delete-file (buffer-file-name (current-buffer)))))))

;; ---------------------------------------------------------------------


