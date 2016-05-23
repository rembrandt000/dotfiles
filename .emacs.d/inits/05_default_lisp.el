;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ shell                                                         ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(when cyg-p
  (require 'shell)
  (setq explicit-shell-file-name "bash.exe")
  (setq shell-command-switch "-c")
  (setq shell-file-name "bash.exe")

  ;; (M-! and M-| and compile.el)
  (setq shell-file-name "bash.exe")
  (modify-coding-system-alist 'process ".*sh\\.exe" 'utf-8)
  )

(when win-p
  ;; M-x shell
  (defun set-shell-cmdproxy()
    (interactive)
    (setq shell-file-name "cmdproxy")
    (setq explicit-shell-file-name "cmdproxy")
    (setenv "SHELL" explicit-shell-file-name)
    (setq w32-quote-process-args t)
    (setq shell-command-switch "-c")
    )
  (set-shell-cmdproxy)
  ;; set eshell aliases
  (setq eshell-command-aliases-list
        (append
         (list
          (list "nyaos" "C:/bin/ConEmuPack/app/nyaos3/nyaos.exe")
          ))))


;; ----------------------------------------------------------
;; eww
;; ----------------------------------------------------------
; 検索エンジンを Google にする
;(setq eww-search-prefix "https://www.google.co.jp/search?q=")

; クイック検索。検索結果にハイライトをつける.
(defun eww-search (term)
  (interactive "sSearch terms: ")
  (setq eww-hl-search-word term)
  (eww-browse-url (concat eww-search-prefix term)))
 
(add-hook 'eww-after-render-hook (lambda ()
           (highlight-regexp eww-hl-search-word)
           (setq eww-hl-search-word nil)))


; 画像表示。画像は遅いので表示させない
(defun eww-disable-images ()
  "eww で画像表示させない"
  (interactive)
  (setq-local shr-put-image-function 'shr-put-image-alt)
  (eww-reload))
(defun eww-enable-images ()
  "eww で画像表示させる"
  (interactive)
  (setq-local shr-put-image-function 'shr-put-image)
  (eww-reload))
(defun shr-put-image-alt (spec alt &optional flags)
  (insert alt))
;; はじめから非表示
(defun eww-mode-hook--disable-image ()
  (setq-local shr-put-image-function 'shr-put-image-alt))
(add-hook 'eww-mode-hook 'eww-mode-hook--disable-image)


;;; 背景・文字色を無効化する
(defvar eww-disable-colorize t)
(defun shr-colorize-region--disable (orig start end fg &optional bg &rest _)
  (unless eww-disable-colorize
    (funcall orig start end fg)))
(advice-add 'shr-colorize-region :around 'shr-colorize-region--disable)
(advice-add 'eww-colorize-region :around 'shr-colorize-region--disable)
(defun eww-disable-color ()
  "ewwで文字色を反映させない"
  (interactive)
  (setq-local eww-disable-colorize t)
  (eww-reload))
(defun eww-enable-color ()
  "ewwで文字色を反映させる"
  (interactive)
  (setq-local eww-disable-colorize nil)
  (eww-reload))

; eww-lnum (Hit-a-Hintモード)
;; 表示がずれるので保留
(with-eval-after-load "eww"
  (define-key eww-mode-map "f" 'eww-lnum-follow)
  (define-key eww-mode-map "F" 'eww-lnum-universal))
(defun eww-lnum-read-interactive--not-truncate-lines (&rest them)
  (let ((truncate-lines nil))
    (apply them)))
(advice-add 'eww-lnum-read-interactive :around
            'eww-lnum-read-interactive--not-truncate-lines)


; ace-link.el (Hit-a-Hintモード)
(with-eval-after-load "eww"
(define-key eww-mode-map "r" 'eww-reload)
(define-key eww-link-keymap "y" 'ace-link-eww)
(define-key eww-mode-map "y" 'ace-link-eww))


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ search - isearch                                              ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; C-yで検索文字列にヤンク貼り付け
(define-key isearch-mode-map (kbd "C-y") 'isearch-yank-kill)

;; C-eで検索文字列を編集
(define-key isearch-mode-map (kbd "C-e") 'isearch-edit-string)

;; Tabで検索文字列を補完
(define-key isearch-mode-map (kbd "TAB") 'isearch-yank-word)

;; C-gで検索を終了
(define-key isearch-mode-map (kbd "C-g")
  '(lambda() (interactive) (isearch-done)))

;; 日本語の検索文字列をミニバッファに表示
(define-key isearch-mode-map (kbd "<compend>")
  '(lambda() (interactive) (isearch-update)))
(define-key isearch-mode-map (kbd "<kanji>")
  'isearch-toggle-input-method)
(add-hook
 'isearch-mode-hook
 '(lambda() (setq w32-ime-composition-window (minibuffer-window)))
 )
(add-hook
 'isearch-mode-end-hook
 '(lambda() (setq w32-ime-composition-window nil))
 )




