;; 添付ファイル保存ディレクトリ
(setq mime-save-directory (concat my-dropbox-directory "/downloads"))
(setq wl-mime-save-directory (concat my-dropbox-directory "/downloads/"))
;; emlメールへの保存ディレクトリ
(setq wl-temporary-file-directory (concat my-dropbox-directory "/soft/howm/mail/"))

;;(setq elmo-maildir-folder-path (concat my-dropbox-directory "soft/emacs/Mail"))
;;(setq elmo-localdir-folder-path (concat my-dropbox-directory "soft/emacs/Mail"))
;; 

(setq wl-from "Takakusa Yasuo <takakusa.yasuo@rene-easton.com>")

;; SSL
(setq ssl-certificate-verification-policy 1)

;; IMAP
;(setq elmo-imap4-default-server "localhost")
(setq elmo-imap4-default-server "px4.cloudgate.jp")
(setq elmo-imap4-default-user "takakusa.yasuo@rene-easton.com")
(setq elmo-imap4-default-authenticate-type 'clear) ;"plain", 'clear, "login"
(setq elmo-imap4-default-port '18906)
(setq elmo-imap4-default-stream-type 'ssl)

(setq elmo-imap4-use-modified-utf7 t)

;; SMTP
(setq wl-smtp-connection-type 'ssl)
(setq wl-smtp-posting-port 18902)
(setq wl-smtp-authenticate-type "login")
(setq wl-smtp-posting-user "takakusa.yasuo@rene-easton.com")
;(setq wl-smtp-posting-server "localhost")
(setq wl-smtp-posting-server "px4.cloudgate.jp")
(setq wl-local-domain "rene-easton.com")

;;(setq wl-default-folder "%inbox")
;;(setq wl-default-spec "%")
;;(setq wl-draft-folder "%[Gmail]/Drafts") ; Gmail IMAP
;;(setq wl-trash-folder "%[Gmail]/Trash")

(setq wl-folder-check-async t)	; 非同期でチェックするように

(setq elmo-imap4-use-modified-utf7 t)	; 日本語フォルダ対策

(autoload 'wl-user-agent-compose "wl-draft" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))

; inboxフォルダでの削除を「Archive」にする
;(setq wl-dispose-folder-alist
;      (cons '("^%inbox" . remove) wl-dispose-folder-alist))

;; 画面を普通のメーラみたいな 3ペインに
;; (setq wl-stay-folder-window t)
;; メールを書くときはフル画面にする
;; (setq wl-draft-reply-buffer-style 'full)
;; 送信済みIMAPフォルダは送信と同時に既読に
(setq wl-fcc-force-as-read t)
;; メール送信するときに自分を含めない
(setq wl-draft-always-delete-myself t)
;; HTMLメールを読む
;(require 'w3m-load)
(require 'mime-w3m)
;; パスワードの保存
;; M-x elmo-passwd-alist-save
;; 保存場所の指定.
(setq elmo-passwd-alist-file-name (concat my-dropbox-directory "soft/emacs/wl-passwd.gpg"))
;; メールのキャッシュ (初期設定はt)
(setq elmo-imap4-use-cache nil)
;; 起動時はオフラインモード (M-tでオンライン/オフライン切替)
;; plugged mode start up offline
(setq wl-plugged nil)
;; じゃまなので表示させないメールヘッダ
(setq wl-message-ignored-field-list
  '(".*Received:" ".*Path:" ".*Id:" "^References:"
    "^Replied:" "^Errors-To:"
    "^Lines:" "^Sender:" ".*Host:" "^Xref:"
    "^Content-Type:" "^Precedence:"
    "^Status:" "^X-.*:"
    "^Content-.*:" "^MIME-Version:"
    "^Delivered-To:"
   )
 )

(setq wl-fcc "%[Gmail]/送信済みメール")
(setq wl-draft-folder "%[Gmail]/下書き")


;;オンラインになったときに自動的にキューを送信するか どうか。初期設定は t。
(setq wl-auto-flush-queue nil)


;; 添付ファイルがあると『@』を表示する
(setq elmo-msgdb-extra-fields
      (cons "content-type" elmo-msgdb-extra-fields))
(setq wl-summary-line-format-spec-alist
      (append wl-summary-line-format-spec-alist
	      '((?@ (wl-summary-line-attached)))))
(setq wl-summary-line-format
      "%n%T%P%1@%M/%D(%W)%h:%m %t%[%17(%c %f%) %] %s")



;; GMail 風、新着レス順にソート
(defun wl-summary-overview-entity-compare-by-reply-number (a b)
  "Compare entity A and B by latest number of replies."
  (let ((fx #'(lambda (x)
                (setq x (elmo-message-entity-number x))
                (apply 'max x (wl-thread-entity-get-descendant 
                               (wl-thread-get-entity x))))))
    (< (funcall fx a) (funcall fx b))))
(add-to-list 'wl-summary-sort-specs 'reply-number)
