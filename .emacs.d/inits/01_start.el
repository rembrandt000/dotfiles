;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ language - coding system                                      ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(when win-p
  (prefer-coding-system 'utf-8-dos)                     ;; 日本語入力のための設定
  (setq default-buffer-file-coding-system 'utf-8-dos)   ;; 新規作成時の文字コード
  (setq default-file-name-coding-system 'sjis)          ;; diredで日本語file名出力
  (set-terminal-coding-system 'sjis)                    ;; eshellの文字コード
  (setq default-process-coding-system '(sjis . sjis))   ;; サブプロセスの入出力に使用
  (set-default-font "ＭＳ ゴシック-10")
  )
(when cyg-p
;;  (set-terminal-coding-system 'sjis)                    ;; eshellの文字コード
  (set-default-coding-systems 'utf-8-unix)                              ;; デフォルトの文字コード
  (prefer-coding-system 'utf-8-unix)                                    ;; テキストファイル／新規バッファの文字コード
  (set-file-name-coding-system 'utf-8-unix)                             ;; ファイル名の文字コード
  (set-keyboard-coding-system 'utf-8-unix)                              ;; キーボード入力の文字コード
  (setq default-process-coding-system '(undecided-dos . utf-8-unix))    ;; サブプロセスのデフォルト文字コード
  ;; 現在のフォントは (frame-parameter nil 'font) を評価
  (add-to-list 'default-frame-alist
             '(font . "-outline-\300\202l\300\202r \300\203S\300\203V\300\203b\300\203N-normal-normal-normal-mono-13-*-*-*-c-*-iso8859-1"))
  ;; windows形式のドライブレターを認識させる (c:\windows とか)
  (require 'cygwin-mount)
  (require 'windows-path)
  (windows-path-activate)
  )

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ language - input method                                       ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(when cyg-p
  (set-language-environment "Japanese")
  )

(cond (win-os
;; モードラインの表示文字列
(setq-default w32-ime-mode-line-state-indicator "[--]")                 ;; おこのみで
(setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))   ;; おこのみで

;; IME初期化
(w32-ime-initialize)

;; デフォルト IME
(setq default-input-method "W32-IME")

;; バッファ切り替え時の状態引継ぎ設定
(setq w32-ime-buffer-switch-p nil)

))

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ screen - frame                                                ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(setq inhibit-startup-message t)    ;; 起動時の画面を消す
(setq initial-scratch-message "")   ;; メッセージを消す
(tool-bar-mode 0)                 ;; ツールバー(アイコン)を消す
(menu-bar-mode 0)                ;; メニューバーを消す


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ screen - mode line                                            ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(column-number-mode t)          ;; 行番号表示
(line-number-mode t)            ;; 列番号表示
(display-time)                  ;; 時間表示
(which-function-mode 1)         ;; 現在の関数名をモードラインに表示

(when cyg-p
  ;; cp932エンコードの表記変更
  (coding-system-put 'cp932 :mnemonic ?P)
  (coding-system-put 'cp932-dos :mnemonic ?P)
  (coding-system-put 'cp932-unix :mnemonic ?P)
  (coding-system-put 'cp932-mac :mnemonic ?P)

  ;; UTF-8エンコードの表記変更
  (coding-system-put 'utf-8 :mnemonic ?U)
  (coding-system-put 'utf-8-with-signature :mnemonic ?u)

  ;; 改行コードの表記追加
  (setq eol-mnemonic-dos       ":Dos ")
  (setq eol-mnemonic-mac       ":Mac ")
  (setq eol-mnemonic-unix      ":Unx ")
  (setq eol-mnemonic-undecided ":??? ")
  )


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ screen - buffer                                               ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; バッファ画面外文字の切り詰め表示
(setq truncate-lines nil)

;; ウィンドウ縦分割時のバッファ画面外文字の切り詰め表示
(setq truncate-partial-width-windows t)

;; 同一バッファ名にディレクトリ付与
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ screen - cursor                                               ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; カーソルの点滅を止める
(blink-cursor-mode 0)

;; 非アクティブウィンドウのカーソル表示
(setq-default cursor-in-non-selected-windows t)

;; IME無効／有効時のカーソルカラー定義
(unless (facep 'cursor-ime-off)
  (make-face 'cursor-ime-off)
  (set-face-attribute 'cursor-ime-off nil
                      :background "DarkRed" :foreground "White")
  )
(unless (facep 'cursor-ime-on)
  (make-face 'cursor-ime-on)
  (set-face-attribute 'cursor-ime-on nil
                      :background "DarkGreen" :foreground "White")
  )

;; IME無効／有効時のカーソルカラー設定
(add-hook
 'input-method-inactivate-hook
 '(lambda()
    (if (facep 'cursor-ime-off)
        (let ( (fg (face-attribute 'cursor-ime-off :foreground))
               (bg (face-attribute 'cursor-ime-off :background)) )
          (set-face-attribute 'cursor nil :foreground fg :background bg)
          )
      )
    )
 )
(add-hook
 'input-method-activate-hook
 '(lambda()
    (if (facep 'cursor-ime-on)
        (let ( (fg (face-attribute 'cursor-ime-on :foreground))
               (bg (face-attribute 'cursor-ime-on :background)) )
          (set-face-attribute 'cursor nil :foreground fg :background bg)
          )
      )
    )
 )

(show-paren-mode 1)             ;; 対応する括弧を光らせる。
(setq show-paren-style 'mixed)  ;; ウィンドウ内に収まらないときだけ括弧内も光らせる。

;; 現在行を目立たせる
(global-hl-line-mode t)
(defface my-hl-line-face
  '((((class color) (background dark))  ;; カラーかつ, 背景が dark ならば,
     (:background "gray20"))            ;; 背景を黒に.
    (((class color) (background light)) ;; カラーかつ, 背景が light ならば,
     (:background "alice blue" t))      ;; 背景を ForestGreen に.
    (t (:bold t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)
(smart-cursor-color-mode 1)

;; カーソルの場所を保存する
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file "~/.emacs.d/emacs-places")


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ screen - linum                                                ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(require 'linum)

;; バッファ中の行番号表示
(global-linum-mode)

;; ;; 行移動を契機に描画
;; (defvar linum-line-number 0)
;; (declare-function linum-update-current "linum" ())
;; (defadvice linum-update-current
;;     (around linum-update-current-around activate compile)
;;   (unless (= linum-line-number (line-number-at-pos))
;;     (setq linum-line-number (line-number-at-pos))
;;     ad-do-it
;;     ))
;;
;; ;; バッファ中の行番号表示の遅延設定
;; (defvar linum-delay nil)
;; (setq linum-delay t)
;; (defadvice linum-schedule (around linum-schedule-around () activate)
;;   (run-with-idle-timer 1.0 nil #'linum-update-current))


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ file - backup                                                 ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; ファイルオープン時のバックアップ（~）
(setq make-backup-files   t)    ;; 自動バックアップの実行有無
(setq version-control     t)    ;; バックアップファイルへの番号付与
(setq kept-new-versions   3)    ;; 最新バックアップファイルの保持数
(setq kept-old-versions   0)    ;; 最古バックアップファイルの保持数
(setq delete-old-versions t)    ;; バックアップファイル削除の実行有無

;; ファイルオープン時のバックアップ（~）の格納ディレクトリ
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
            backup-directory-alist))

;; 編集中ファイルのバックアップの実行有無 (#)
(setq auto-save-default t)

;; 保存時に自動バックアップファイルを削除 (nilで削除しない)
(setq delete-auto-save-files t)

;; 編集中ファイル（##）の格納ディレクトリ
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backup/") t)))

;; 編集中ファイルのバックアップ間隔（秒）
(setq auto-save-timeout 1)

;; バッファ自動再読み込み
(global-auto-revert-mode 1)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ file - lockfile                                               ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; ロックファイルの生成を抑止
(setq create-lockfiles nil)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ theme                                                         ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; テーマ格納ディレクトリのパス追加
(add-to-list 'custom-theme-load-path
             (file-name-as-directory (concat user-emacs-directory "theme"))
             )

;; テーマ選択
;; (load-theme 'solarized-light t)
;; (load-theme 'solarized-dark t)
;; (load-theme 'gnupack-dark t)
(cond (rem-u
       (load-theme 'atom-dark t))
      ((eq window-system 'nil)
       (load-theme 'tango-dark t))
        (rec-u
      (load-theme ' tango t))
      )


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ server                                                        ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; emacs-server起動
(require 'server)
(defun server-ensure-safe-dir (dir) "Noop" t)
(setq server-socket-dir "~/.emacs.d")
(unless (server-running-p)
  (server-start)
)



;; ------------------------------------------------------------------------
;; ミニバッファ拡大防止
(setq resize-mini-windows t)

;; 画像ファイルを表示
(auto-image-file-mode t)

;; beep音を消す
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; タブをスペース4字
(setq-default tab-width 4 indent-tabs-mode nil)

;; ------------------------------------------------------------------------
;; 全角空白、タブ文字、行末空白の表示
;;   http://homepage1.nifty.com/blankspace/emacs/color.html
(defface my-face-b-1 '((t (:background "bisque"))) nil)
(defface my-face-b-2 '((t (:background "LemonChiffon2"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("　" 0 my-face-b-1 append)
     ("\t" 0 my-face-b-2 append)
     ("[ \t]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)


;; 削除確認などでyes/noと入れる代わりにy/nが使える
;; さらに簡略化でエンターでyesにする
(fset 'yes-or-no-p 'y-or-n-p)
(define-key query-replace-map [return] 'act)
(define-key query-replace-map [?\C-m] 'act)


;; ------------------------------------------------------------------------
;; arrowingするときの警告有無
(put 'narrow-to-region 'disabled nil)

;; custiize-option 設定保存ファイル
(setq custom-file "~/.emacs.d/98_custom_file.el")

;; 大文字化小文字化実行時の確認有無
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
;------------------------------------------------------------------------

