;;; packed.el

;; install if not installed
(defvar my-package-list
  '(
    ;; ここに使っているパッケージを書く
    ace-isearch
    ace-link
    anything
    atom-dark-theme             ;; atomのAtom.ioテーマ移植
    auto-save-buffers-enhanced  ;; 自動保存
    bf-mode                     ;; xdoc2txtと連携
    buffer-move                 ;; 分割ウィンドウ間のバッファ入替
    calfw                       ;; カレンダー
    csv-mode
    dired-filter                ;; prefix-key "/"
    dired-subtree               ;; subディレクトリのインライン表示
    direx
    elscreen
    elscreen-persist
    eww-lnum                    ;; ewwでHint-a-Hint
    helm
    helm-bm
    helm-descbinds
    helm-migemo
    helm-swoop                  ;; occurの強化版
    japanese-holidays
    loccur
    multi-term                  ;; ターミナル
    popwin                      ;; バッファのポップアップ表示
    redo+
    runner                      ;; 独自関連付け実行
    scratch-pop                 ;; C-ccでscratchを開く
    smart-cursor-color          ;; カーソルの背景色を文字色に合わせて見やすくする
    simplenote2
    sync-recentf                ;; recentf(最近開いたファイル)を複数のEmacs間で同期
    unify-opening               ;; org-modeの関連付け実行をdiredと同じにする
    volatile-highlights         ;; undoやyankした後にどこが変わったかをハイライト
    w3m
    wanderlust                  ;; メーラー
    window-numbering
    ))

(when win-p
  (setq my-package-list
        (append
         '(
           migemo
           hiwin           ;; アクティブな window を可視化する hiwin-mode
           ) my-package-list)))
(when cyg-p
  (setq my-package-list
        (append
         '(
           cygwin-mount    ;; Cygwin のドライブ・プレフィックスを有効に
           term-run        ;; NTEmacsだとtermが動かない
           ) my-package-list)))

(let ((not-installed
       (loop for package in my-package-list
             when (not (package-installed-p package))
             collect package)))
  (when not-installed
    (package-refresh-contents)
    (dolist (package not-installed)
      (package-install package))))

;; 削除した elisp
;; init-loader  ;; init.elで設定済
;; e2wm           ;; elscreenとの相性悪い
;; e2wm-direx
;; one-key
;; persp-mode
;; shell-pop
;; stripe-buffer   ;; diredをシマシマ表示にする
;; undo-tree       ;; undo-redoをグラフィカルに
