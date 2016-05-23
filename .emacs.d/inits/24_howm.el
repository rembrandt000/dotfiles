;---------------------------------------------------------------------
;---------------------------------------------------------------------
;; howm
;; README.ja.rd
;; http://howm.sourceforge.jp/README-j.html
;; howmの設定ファイル一式
;; case 2: はじめて C-c , , した時に読み込む
(setq howm-menu-lang 'ja)
; (global-set-key (kbd "C-c , ,") 'howm-menu)	;; org-modeと重なるのC-zに変更済

;; howmが生成するファイルの置き場所
(setq howm-directory (concat my-dropbox-directory "soft/howm/"))

;; キーワード一覧
;(setq howm-keyword-file ".howm-keys")
(setq howm-keyword-file (concat howm-directory "menu/.howm-keys"))
;; 履歴一覧
(setq howm-history-file (concat howm-directory "menu/.howm-history"))

; 新しくメモを作る時は、先頭の「=タイトル」だけ挿入。
(setq howm-template "= %title%cursor\n\n")

;; ファイル名
(setq howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.org")

;; save 時にメニューを更新しない
(setq howm-menu-refresh-after-save nil)
(setq howm-refresh-after-save nil)

;---------------------------------------------------------------------
(require 'anything-howm)

(defun anything-buffers ()
  (interactive)
  (anything-other-buffer
   '(
     ;; anything-c-source-buffers  ;;これをやめて
     anything-c-source-buffers+-howm-title ;;これを追加
     anything-c-source-files-in-current-dir
     anything-c-source-bookmarks
     anything-c-source-recentf ;;など
     ;; anything-c-source-file-name-history
     ;; ...
     )
   "*Buffer+File*"))

(global-set-key (kbd "C-l") 'anything-buffers)

;; 「最近のメモ」をいくつ表示するか
(setq anything-howm-recent-menu-number-limit 600)

(global-set-key (kbd "C-2") 'ah:menu-command)
(global-set-key (kbd "C-3") 'ah:cached-howm-menu)

;---------------------------------------------------------------------

;; org形式の表示
;; 日付のフォーマット変更
(setq howm-dtime-format (concat "<" howm-dtime-body-format ">"))
(setq howm-insert-date-format "<%s>")
;; 日付の検索するフォーマットも変更
(setq howm-reminder-regexp-grep-format (concat "<" howm-date-regexp-grep "[ :0-9月火水木金土日]*>%s"))
(setq howm-reminder-regexp-format (concat "\\(<" howm-date-regexp "[ :0-99月火水木金土日]*>\\)\\(\\(%s\\)\\([0-9]*\\)\\)"))
;; 今日の日付を挿入する変数も変更
(setq howm-reminder-today-format (format howm-insert-date-format howm-date-format))
;;ちなみにここを変更しなかった場合は、Doneしたタスクがhowmメニュー上で表示されなくなります。 そうしたらメニューからやったタスクが消えていくので いいかも
;; ついでにhowmでDoneしたときにorg-modeでもDoneされるようにする
(defadvice howm-action-lock-done-done(after my-org-todo-done () activate) (org-todo))



