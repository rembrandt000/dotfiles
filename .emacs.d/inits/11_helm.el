;; helm
(require 'helm-config)
(helm-mode 1)

;; ミニバッファでC-hをバックスペースに割り当て
(define-key helm-map (kbd "C-h") 'delete-backward-char)
(eval-after-load "helm-files"
  '(progn
     (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
     (define-key helm-find-files-map (kbd "C-i") 'helm-execute-persistent-action)))

;; killバッファーにはhelmはいらない
;; (add-to-list 'helm-completing-read-handlers-alist '(kill-buffer . nil))
;; helm-source-buffers-list を詳細に表示しない
(setq helm-buffer-details-flag nil)
;; 自動補完を無効にする
(setq helm-ff-auto-update-initial-value nil)
; ワードラップしなくて良い！。のとバッファリストに余計な物は出したくない。
(custom-set-variables
 '(helm-truncate-lines t)
 '(helm-buffer-max-length 20)
 '(helm-boring-buffer-regexp-list '("^*"))
 '(tramp-mode nil)
 )


;; キーバインド
(let ((key-and-func
       `((,(kbd "M-y")     helm-show-kill-ring)
         (,(kbd "C-c i")   helm-imenu)
         (,(kbd "M-x")     helm-M-x)
         (,(kbd "C-x b")   helm-buffers-list)
         (,(kbd "C-c h")   helm-multi-files)
         (,(kbd "C-x c f")   helm-mini)
         (,(kbd "C-x o")   helm-occur)
         )))
  (loop for (key func) in key-and-func
        do (global-set-key key func)))


;; C-k を押すと先頭から削除されるし kill ring にも追加されない
;; Emulate `kill-line' in helm minibuffer
(setq helm-delete-minibuffer-contents-from-point t)
(defadvice helm-delete-minibuffer-contents (before helm-emulate-kill-line activate)
  "Emulate `kill-line' in helm minibuffer"
  (kill-new (buffer-substring (point) (field-end))))


;; ----------------------------------------------------------
;;; helm-bm.el設定
(require 'helm-bm)
;; migemoくらいつけようね
(push '(migemo) helm-source-bm)
;; annotationはあまり使わないので仕切り線で表示件数減るの嫌
(setq helm-source-bm (delete '(multiline) helm-source-bm))

(defun bm-toggle-or-helm ()
  "2回連続で起動したらhelm-bmを実行させる"
  (interactive)
  (bm-toggle)
  (when (eq last-command 'bm-toggle-or-helm)
    (helm-bm)))
(global-set-key (kbd "M-SPC") 'bm-toggle-or-helm)

;;; これがないとemacs -Qでエラーになる。おそらくバグ。
(require 'compile)


;; ----------------------------------------------------------
;; helmコマンドで migemo を有効にする
;; helm で正しく migemo を動作させるための対策
;; http://rubikitch.com/2014/12/19/helm-migemo/
;; https://github.com/emacs-helm/helm/pull/379
(require 'helm-migemo)
;;; この修正が必要
(eval-after-load "helm-migemo"
  '(defun helm-compile-source--candidates-in-buffer (source)
     (helm-aif (assoc 'candidates-in-buffer source)
         (append source
                 `((candidates
                    . ,(or (cdr it)
                           (lambda ()
                             ;; Do not use `source' because other plugins
                             ;; (such as helm-migemo) may change it
                             (helm-candidates-in-buffer (helm-get-current-source)))))
                   (volatile) (match identity)))
       source)))
(helm-migemize-command helm-occur)
(helm-migemize-command helm-imenu)
(helm-migemize-command helm-mini)
;; ;(setq helm-use-migemo t)
;; ;; 候補が表示されないときがあるので
;; ;; migemoらないように設定
;; (defadvice helm-c-apropos
;;   (around ad-helm-apropos activate)
;;   (let ((helm-use-migemo nil))
;;     ad-do-it))
;; (defadvice helm-M-x
;;   (around ad-helm-M-x activate)
;;   (let ((helm-use-migemo nil))
;;     ad-do-it))

;; helm の候補表示画面で migemo でマッチした部分もハイライトさせる対策
;; http://highmt.wordpress.com/2010/10/25/anything%E3%81%A7%E3%83%9E%E3%83%83%E3%83%81%E9%83%A8%E5%88%86%E3%81%AE%E3%83%8F%E3%82%A4%E3%83%A9%E3%82%A4%E3%83%88%E3%82%92migemo%E3%81%AB%E5%AF%BE%E5%BF%9C%E3%81%95%E3%81%9B%E3%82%8B/
(defadvice helm-mp-highlight-match-internal (around ad-helm-mp-highlight-match-internal-for-migemo activate)
  ;; (cl-letf (((symbol-function 'helm-mp-3-get-patterns)
  (letf (((symbol-function 'helm-mp-3-get-patterns)
          (lambda (pattern)
            (loop for (pred . re) in
                  (helm-mp-3-get-patterns-internal pattern) ; avoid being cached
                  collect (cons pred (migemo-get-pattern re))))))
    ad-do-it))


;; ----------------------------------------------------------
;; helm-descbinds
(require 'helm-descbinds)
(helm-descbinds-mode)
; (define-key global-map [f1-b] 'helm-descbinds)   ;; 既に登録済


;; ----------------------------------------------------------


;; ----------------------------------------------------------
;; helm-swoop.el設定
(require 'helm-swoop)
;;; isearchからの連携を考えるとC-r/C-sにも割り当て推奨
;;; ace-isearchでさらに置き換え
(global-ace-isearch-mode 1)
; (define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
; (define-key helm-swoop-map (kbd "C-s") 'helm-next-line)

;;; 検索結果をcycleしない、お好みで
(setq helm-swoop-move-to-line-cycle nil)

(cl-defun helm-swoop-nomigemo (&key $query ($multiline current-prefix-arg))
  "シンボル検索用Migemo無効版helm-swoop"
  (interactive)
  (let ((helm-swoop-pre-input-function
         (lambda () (format "\\_<%s\\_> " (thing-at-point 'symbol)))))
    (helm-swoop :$source (delete '(migemo) (copy-sequence (helm-c-source-swoop)))
                :$query $query :$multiline $multiline)))
;;; C-M-:に割り当て
(global-set-key (kbd "C-M-:") 'helm-swoop-nomigemo)

;;; [2014-11-25 Tue]
(when (featurep 'helm-anything)
  (defadvice helm-resume (around helm-swoop-resume activate)
    "helm-anything-resumeで復元できないのでその場合に限定して無効化"
    ad-do-it))

;;; ace-isearch
(global-ace-isearch-mode 1)

;;; [2015-03-23 Mon]C-u C-s / C-u C-u C-s
(defun isearch-forward-or-helm-swoop (use-helm-swoop)
  (interactive "p")
  (let (current-prefix-arg
        (helm-swoop-pre-input-function 'ignore))
    (call-interactively
     (case use-helm-swoop
       (1 'isearch-forward)
       (4 'helm-swoop)
       (16 'helm-swoop-nomigemo)))))
(global-set-key (kbd "C-s") 'isearch-forward-or-helm-swoop)

;;; replacement of `next-error' and `previous-error'
;;; resumable helm/anything buffers
(defvar helm-resume-goto-buffer-regexp
  (rx (or (regexp "Helm Swoop") "helm imenu" (regexp "helm.+grep") "helm-ag"
          "occur"
          "*anything grep" "anything current buffer")))
(defvar helm-resume-goto-function nil)
(defun helm-initialize--resume-goto (resume &rest _)
  (when (and (not (eq resume 'noresume))
             (ignore-errors
               (string-match helm-resume-goto-buffer-regexp helm-last-buffer)))
    (setq helm-resume-goto-function
          (list 'helm-resume helm-last-buffer))))
(advice-add 'helm-initialize :after 'helm-initialize--resume-goto)
(defun anything-initialize--resume-goto (resume &rest _)
  (when (and (not (eq resume 'noresume))
             (ignore-errors
               (string-match helm-resume-goto-buffer-regexp anything-last-buffer)))
    (setq helm-resume-goto-function
          (list 'anything-resume anything-last-buffer))))
(advice-add 'anything-initialize :after 'anything-initialize--resume-goto)

;;; next-error/previous-error
(defun compilation-start--resume-goto (&rest _)
  (setq helm-resume-goto-function 'next-error))
(advice-add 'compilation-start :after 'compilation-start--resume-goto)
(advice-add 'occur-mode :after 'compilation-start--resume-goto)
(advice-add 'occur-mode-goto-occurrence :after 'compilation-start--resume-goto)
(advice-add 'compile-goto-error :after 'compilation-start--resume-goto)


(defun helm-resume-and- (key)
  (unless (eq helm-resume-goto-function 'next-error)
    (if (fboundp 'helm-anything-resume)
        (setq helm-anything-resume-function helm-resume-goto-function)
      (setq helm-last-buffer (cadr helm-resume-goto-function)))
    (execute-kbd-macro
     (kbd (format "%s %s RET"
                  (key-description (car (where-is-internal
                                         (if (fboundp 'helm-anything-resume)
                                             'helm-anything-resume
                                           'helm-resume))))
                  key)))
    (message "Resuming %s" (cadr helm-resume-goto-function))
    t))
(defun helm-resume-and-previous ()
  "Relacement of `previous-error'"
  (interactive)
  (or (helm-resume-and- "C-p")
      (call-interactively 'previous-error)))
(defun helm-resume-and-next ()
  "Relacement of `next-error'"
  (interactive)
  (or (helm-resume-and- "C-n")
      (call-interactively 'next-error)))

;;; Replace: next-error / previous-error
(require 'helm-config)
(ignore-errors (helm-anything-set-keys))
(global-set-key (kbd "M-g M-n") 'helm-resume-and-next)
(global-set-key (kbd "M-g M-p") 'helm-resume-and-previous)


