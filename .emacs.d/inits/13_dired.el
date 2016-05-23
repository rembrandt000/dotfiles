;; ----------------------------------------------------------
;; dired
; ブックマーク機能のキーバインド
; C-x r m  カレントバッファをブックマークに追加
; C-x r b  ブックマーク名を指定して開く
; C-x r l  ブックマークの一覧を表示
; d        一覧表示で、ブックマークに削除マークをつける
; x        一覧表示で、削除マークのついたものを削除
;;
;; ls オプション
; -A  . および .. を一覧表示しない
; -D  Emacs の dired モード用の出力を生成する
; -F  タイプ識別子 (*/=>@| のうちの一つ) を付けて出力する
; -G  詳細リスト形式の時にグループ名を表示しない
; -h  容量等をM表示
; -l  詳細リスト形式(ファイル所有者表示)
; -r  ソート順を反転させる
; -t  ファイル更新時間で新しい順にソートする
; -v  自然な (バージョン) 数字順でソートする


;;; diredを便利にする
(load "dired-x")


(when win-p
  (progn
    ;; 外部lsコマンドの使用有無
    (setq ls-lisp-use-insert-directory-program nil)
    ;; ls-lisp を使う
    (require 'ls-lisp)
    ;; lsのオプション
    (setq dired-listing-switches "-ht")
    ;; lsのオプションで -D を使わない
    (setq dired-use-ls-dired nil)
    ;; 時間フォーマットカスタマイズの使用有無
    (setq ls-lisp-use-localized-time-format nil)
    ;; 時間フォーマット
    (setq ls-lisp-format-time-list '(
                                     "%Y-%m-%d %H:%M"
                                     "%Y-%m-%d %H:--"
                                     ))
    ;; ファイルの持ち主など項目の表示を減らす
    (setq ls-lisp-verbosity nil)
    ))

(when cyg-p
  (progn
    ;; diredがエラーを吐く回避策。Emacs同梱のlsコマンドを使う
    (setq ls-lisp-use-insert-directory-program nil)
    ;; lsのオプション
    (cond
     (rem-u (setq dired-listing-switches "-AlgGhvr"))  ;; バージョン順
     (rec-u (setq dired-listing-switches "-AlgGht"))  ;; 更新日時順
     )
    ;; コピーなどを非同期にする
    (eval-after-load "dired-aux" '(require 'dired-async))
    ))

(when (eq linux-os t)
  (progn
    (setq ls-lisp-use-insert-directory-program nil)
    (setq dired-listing-switches "-AlgGhvr")
    (eval-after-load "dired-aux" '(require 'dired-async))
    ))


;; ディレクトリを先頭に表示
;; (setq ls-lisp-dirs-first t)

;; ディレクトリに対して再帰的なコピー/削除を行う
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)

;; diredバッファに切り替えるたびに更新
(setq dired-auto-revert-buffer t)

;; ファイル名の大文字小文字無視でソート
(setq ls-lisp-ignore-case t)

;; 無効コマンドdired-find-alternate-fileを有効にする
(put 'dired-find-alternate-file 'disabled nil)

;; diredを2つのウィンドウで開いている時に、デフォルトの移動orコピー先をもう一方のdiredで開いているディレクトリにする
(setq dired-dwim-target t)

;; diredバッファでC-sした時にファイル名だけにマッチするように
(setq dired-isearch-filenames t)

;; .zipで終わるファイルをZキーで展開できるように
;(add-to-list 'dired-compress-file-suffixes '("\\.zip\\'" ".zip" "unzip"))

;; ディレクトリの移動キーを追加(wdired 中は無効)
(define-key dired-mode-map (kbd "<left>") 'dired-up-directory)
(define-key dired-mode-map (kbd "<right>") 'dired-open-in-accordance-with-situation)



;; dired で RET (dired-find-file) と a dired-find-alternate-file) の入れ替え
;; ファイルなら別バッファで、ディレクトリなら同じバッファで開く
(defun dired-open-in-accordance-with-situation ()
  (interactive)
  (let ((file (dired-get-filename)))
    (if (file-directory-p file)
        (dired-find-alternate-file)
      (dired-find-file))))

;; 上位フォルダ移動時に、新しいバッファを作成しない
(defun dired-my-up-directory (&optional other-window)
  "Run dired on parent directory of current directory.
Find the parent directory either in this buffer or another buffer.
Creates a buffer if necessary."
  (interactive "P")
  (let* ((dir (dired-current-directory))
         (up (file-name-directory (directory-file-name dir))))
    (or (dired-goto-file (directory-file-name dir))
        ;; Only try dired-goto-subdir if buffer has more than one dir.
        (and (cdr dired-subdir-alist)
             (dired-goto-subdir up))
        (progn
          (if other-window
              (dired-other-window up)
            (progn
              (kill-buffer (current-buffer))
              (dired up))
            (dired-goto-file dir)))
        )))

;; RET 標準の dired-find-file では dired バッファが複数作られるので
;; dired-find-alternate-file を代わりに使う
(define-key dired-mode-map (kbd "RET") 'dired-open-in-accordance-with-situation)
(define-key dired-mode-map (kbd "a") 'dired-find-file)
(define-key dired-mode-map (kbd "f") 'dired-find-alternate-file)
;; 「^」がを押しにくい場合「c」でも上の階層に移動できるようにする
;; (define-key dired-mode-map "c" 'dired-up-directory)
(define-key dired-mode-map "c" 'dired-my-up-directory)



; ファイルの一括操作
;  http://www.emacswiki.org/elisp/wdired.el
;    dired で r を押して編集開始。
;      C-s で確定、C-c C-k で破棄
;      l:ファイル名を小文字にする
;      c:ファイル名の一文字を大文字にする
;      u:ファイル名を大文字にする
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)



;; Dired で Windows に関連付けられたファイルを起動する。
;; 案２
(defun dired-open-by-os-association ()
  (interactive)
  (browse-url-default-browser (dired-get-file-for-visit)))
;;; dired のキー割り当て追加
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map "z" 'dired-open-by-os-association)
            )) ;;; 関連付け

;; 案１
;; (defun uenox-dired-winstart ()
;;   "Type '\\[uenox-dired-winstart]': win-start the current line's file."
;;   (interactive)
;;   (if (eq major-mode 'dired-mode)
;;       (let ((fname (dired-get-filename)))
;;         (w32-shell-execute "open" fname)
;;         (message "win-started %s" fname))))
;; ;;; dired のキー割り当て追加
;; (add-hook 'dired-mode-hook
;;           (lambda ()
;;             (define-key dired-mode-map "z" 'uenox-dired-winstart)
;;             )) ;;; 関連付け



;;; diredで anythingを使ってファイル・ディレクトリを絞り込む
;;; anything in dired
;(defun my/anything-dired ()
;  (interactive)
;  (let ((curbuf (current-buffer)))
;    (if (anything-other-buffer
;         '(anything-c-source-files-in-current-dir+)
;         " *anything-dired*")
;        (kill-buffer curbuf))))
;
;(define-key dired-mode-map (kbd "p") 'my/anything-dired)
;

;; ----------------------------------------------------------
;; runner (diredで独自関連付け)
;; ! で関連付け実行
;; C-c! で関連付けの設定編集
(require 'runner)                       ;needed
(define-key dired-mode-map (kbd "C-c !") 'runner-add-extension)

;; Runner Outputバッファを表示しないようにする
;;(add-to-list 'display-buffer-alist (cons "\\*Async Shell Command\\*.*" (cons #'display-buffer-no-window nil)))
;;(add-to-list 'display-buffer-alist (cons "\\*Runner Output*.*" (cons #'display-buffer-no-window nil)))


;; ----------------------------------------------------------
;; bf-mode (bで別ウィンドウにファイル表示トグル)
;; xdoc2txt
;; (require 'bf-mode)
;; (setq bf-mode-directly-quit t)                      ;; dired で q とすると、dired を終了する
;; (setq bf-mode-browsing-size 300)                     ;; 別ウィンドウに表示するサイズの上限
;; (setq bf-mode-except-ext '("\\.exe$" "\\.com$"))    ;; 別ウィンドウに表示しないファイルの拡張子
;; ;; 容量がいくつであっても表示して欲しいもの
;; (setq bf-mode-force-browse-exts
;;       (append '("\\.texi$" "\\.el$")
;;               bf-mode-force-browse-exts))
;; (setq bf-mode-html-with-w3m t)                      ;; html は w3m で表示する
;; (setq bf-mode-archive-list-verbose nil)             ;; 圧縮されたファイルを表示しない
;; (setq bf-mode-directory-list-verbose t)             ;; ディレクトリ内のファイル一覧を表示
;; (auto-compression-mode nil)                         ;; 圧縮されたファイルを直接編集
;; ;; (setq archive-zip-use-pkzip nil)




;; ----------------------------------------------------------
;; dired-subtree
(require 'dired-subtree)
;;; iを置き換え
(define-key dired-mode-map (kbd "i") 'dired-subtree-insert)
;;; org-modeのようにTABで折り畳む
(define-key dired-mode-map (kbd "<tab>") 'dired-subtree-remove)
;;; C-x n nでsubtreeにナローイング
(define-key dired-mode-map (kbd "C-x n n") 'dired-subtree-narrow)


;; find-dired対応
(defadvice find-dired-sentinel (after dired-details (proc state) activate)
  (ignore-errors
    (with-current-buffer (process-buffer proc)
      (dired-details-activate))))
;; (progn (ad-disable-advice 'find-dired-sentinel 'after 'dired-details) (ad-update 'find-dired-sentinel))

;;; [2014-12-30 Tue]^をdired-subtreeに対応させる
(defun dired-subtree-up-dwim (&optional arg)
  "subtreeの親ディレクトリに移動。そうでなければ親ディレクトリを開く(^の挙動)。"
  (interactive "p")
  (or (dired-subtree-up arg)
      (dired-up-directory)))
(define-key dired-mode-map (kbd "^") 'dired-subtree-up-dwim)



;; ----------------------------------------------------------
;; stripe-buffer
;; diredをシマシマ表示
;(add-hook 'dired-mode-hook 'turn-on-stripe-buffer-mode)
;(add-hook 'dired-mode-hook 'stripe-listify-buffer)
;(add-hook 'org-mode-hook 'stripe-listify-buffer)

;(with-eval-after-load 'dired-subtree
;  (set-face-attribute 'dired-subtree-depth-1-face nil :background "#B4C342")
;  (set-face-attribute 'dired-subtree-depth-2-face nil :background "#F2804F")
;  (set-face-attribute 'dired-subtree-depth-3-face nil :background "#9EA0E5")
;  (set-face-attribute 'dired-subtree-depth-4-face nil :background "#DEB542")
;  (set-face-attribute 'dired-subtree-depth-5-face nil :background "#657b83")
;  (set-face-attribute 'dired-subtree-depth-6-face nil :background "#657b83"))
;
;(with-eval-after-load 'stripe-buffer 
;  (set-face-attribute 'stripe-dired-subtree-depth-1-face nil :background "#cbd57c")
;  (set-face-attribute 'stripe-dired-subtree-depth-2-face nil :background "#f7b396")
;  (set-face-attribute 'stripe-dired-subtree-depth-3-face nil :background "#dadbf5")
;  (set-face-attribute 'stripe-dired-subtree-depth-4-face nil :background "#e9cf83")
;  (set-face-attribute 'stripe-dired-subtree-depth-5-face nil :background "#657b83")
;  (set-face-attribute 'stripe-dired-subtree-depth-6-face nil :background "#657b83"))



;; スペースでマークする (FD like)
(define-key dired-mode-map " " 'dired-toggle-mark)
(defun dired-toggle-mark (arg)
  "Toggle the current (or next ARG) files."
  ;; S.Namba Sat Aug 10 12:20:36 1996
  (interactive "P")
  (let ((dired-marker-char
         (if (save-excursion (beginning-of-line)
                             (looking-at " "))
             dired-marker-char ?\040)))
    (dired-mark arg)
;    (dired-next-line 1)
    ))



;; ---------------------------------------------------------------------
;; emacs unify-opening.el
;; org-modeでの file: のリンクを開き方をdiredと同じにする
;; http://rubikitch.com/2015/02/11/unify-opening/
;;; 画像ファイルをemacsではなくて外部アプリケーションで開く場合はこの設定が必要
(setq auto-mode-alist
      (cl-delete-if (lambda (x) (equal (cdr x) 'image-mode))
                    auto-mode-alist))
;; オフィスファイルをemacsで開かないようにする
(setq auto-mode-alist
      (remove (rassoc 'doc-view-mode-maybe auto-mode-alist) auto-mode-alist))

(require 'unify-opening)
;; 上手く動かなかったら直接指定
(when win-p
  (add-to-list 'org-file-apps '(
;;                                 ("\\.xlsm$" . "EXCEL.EXE %s")
;;                                 ("\\.xlsx$" . "EXCEL.EXE %s")
;;                                 ("\\.xls$" . "EXCEL.EXE %s")
                                ("\\.pdf$" . (concat my-portableapps-directory "/PDF-XChangeViewerPortable/App/PDFV_Portable/PDFXCview.exe %s"))
                                ("\\.zip$" . (concat my-portableapps-directory "/7-ZipPortable/app/7-zip/7zG.exe x %s"))
                                )))



;; ---------------------------------------------------------------------
;; マークしているファイルやディレクトリを Pキー でまとめて圧縮
(defvar dired-do-create-archival-method
  '(("zip" "\\.zip$" ".zip" "zip -r")
    ("tar+gzip" "\\.t\\(ar\\.\\)?gz$" ".tar.gz" "tar cvzf")
    ("tar+bzip2" "\\.t\\(ar\\.bz2\\|bz\\)$" ".tar.bz2" "tar cvjf")
    ))

(defun dired-do-create-archived-file (output-filename arg)
  "マークしたファイルをまとめて圧縮する."
  (interactive "FOUTPUT FILENAME: \nP")
  (let ((def (caar dired-do-create-archival-method))
        opt)
    (mapc
     (lambda (x)
       (when (string-match (nth 1 x) output-filename)
         (setq opt x)))
     dired-do-create-archival-method)
    (setq opt (or opt
                  (assoc (completing-read (format "Select archival method (default %s): " def)
                                          dired-do-create-archival-method nil t nil nil def)
                         dired-do-create-archival-method)))
    (or (when (string= "" (file-name-nondirectory output-filename))
          ;; 出力ファイル名が入力されていなかったらエラーとする.
          (message "ERROR: Output filename is empty."))
        (when (file-exists-p
               (setq output-filename
                     (concat output-filename (unless (string-match (nth 1 opt) output-filename) (nth 2 opt)))))
          ;; 出力ファイル名と同じ名前のファイルが, 既にあった場合, 上書きするか問い合わせる.
          (not (y-or-n-p (concat "file " output-filename " exists. overwrite the file ?"))))
        ;; 実際に圧縮をする.
        (let (add-file)
          (when arg
            (while (y-or-n-p "ADD FILE?")
              (add-to-list 'add-file (file-relative-name (read-file-name "" nil nil t)))))
          (dired-do-shell-command (format "%s %s *" (nth 3 opt) output-filename) nil
                                  (append (dired-get-marked-files t) add-file))))))

(define-key dired-mode-map (kbd "P") 'dired-do-create-archived-file)



;; .zipで終わるファイルをZキーで展開できるように
(add-to-list 'dired-compress-file-suffixes '("\\.zip\\'" ".zip" "unzip"))


