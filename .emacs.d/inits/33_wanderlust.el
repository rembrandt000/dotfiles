;;; wanderlust
;; 添付ファイル保存ディレクトリ
(cond (win-os
       (setq mime-save-directory (concat my-dropbox-directory "downloads/")
             wl-mime-save-directory (concat my-dropbox-directory "downloads/")))
      (linux-os
       (setq mime-save-directory "~/ダウンロード"
             wl-mime-save-directory "~/ダウンロード"))
      )

;; emlメールへの保存ディレクトリ
(cond (win-os
       (setq wl-temporary-file-directory (concat my-dropbox-directory "downloads/mail/")))
      (linux-os
       (setq wl-temporary-file-directory "~/ダウンロード"))
      )

(setq
 elmo-localdir-folder-path (concat my-dropbox-directory "soft/emacs/Mail/")
 elmo-msgdb-directory (concat my-dropbox-directory "soft/emacs/.elmo/")
 wl-address-file (concat my-dropbox-directory "soft/emacs/.addresses")
 wl-folders-file (concat my-dropbox-directory "soft/emacs/.folders")
 )

;; パスワードの保存
;; M-x elmo-passwd-alist-save
;; 保存場所の指定.
;; (setq elmo-passwd-alist-file-name (concat my-dropbox-directory "soft/emacs/wl-passwd.gpg"))

(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)


(setq wl-from "Takakusa Yasuo <takakusa.yasuo@rene-easton.com>")

;; SSL
(setq ssl-certificate-verification-policy 1)

;; IMAP
;(setq elmo-imap4-default-server "localhost")
(setq
 elmo-imap4-default-server "px4.cloudgate.jp"
 elmo-imap4-default-user "takakusa.yasuo@rene-easton.com"
 elmo-imap4-default-authenticate-type 'clear  ;"plain", 'clear, "login"
 elmo-imap4-default-port '18906
 elmo-imap4-default-stream-type 'ssl
 elmo-imap4-use-modified-utf7 t
 )

;; SMTP
(setq
 wl-smtp-connection-type 'ssl
; wl-smtp-connection-type 'starttls
; wl-smtp-authenticate-type "plain"
 wl-smtp-authenticate-type "login"
 wl-smtp-posting-port 18902
 wl-smtp-posting-user "takakusa.yasuo@rene-easton.com"
 wl-smtp-posting-server "px4.cloudgate.jp"
 wl-local-domain "rene-easton.com"
 )

(setq wl-folder-check-async t)  ; 非同期でチェックするように
(setq elmo-imap4-use-modified-utf7 t)  ; 日本語フォルダ対策

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
(setq wl-draft-reply-buffer-style 'full)
;; 送信済みIMAPフォルダは送信と同時に既読に
(setq wl-fcc-force-as-read t)
;; メール送信するときに自分を含めない
(setq wl-draft-always-delete-myself t)
;; HTMLメールを読む
;(require 'w3m-load)
(require 'mime-w3m)
;; メールのキャッシュ (初期設定はt)
(setq elmo-imap4-use-cache nil)
;; 起動時はオンラインモード (M-tでオンライン/オフライン切替)
;; plugged mode start up offline
(setq wl-plugged t)
;; じゃまなので表示させないメールヘッダ
(setq wl-message-ignored-field-list
  '(".*Received:" ".*Path:" ".*Id:" "^References:"
    "^Replied:" "^Errors-To:" "^Accept-Language:"
    "^Lines:" "^Sender:" ".*Host:" "^Xref:"
    "^Content-Type:" "^Precedence:"
    "^Status:" "^X-.*:" "^In-Reply-To:"
    "^Content-.*:" "^MIME-Version:" "^Thread-Topic:" "^Thread-Index:" 
    "^Delivered-To:" "^Authentication-Results:" "^Message-ID:" "^User-Agent:" 
    "^DKIM-Signature:" "^Received-SPF:"
   )
 )

;;(setq wl-default-folder "%inbox")
;(setq wl-draft-folder "%[Gmail]/下書き")   ; 下書きはIMAPフォルダ保存
(setq wl-draft-folder "+Drafts")           ; 下書きはローカル保存
;;(setq wl-trash-folder "%[Gmail]/ゴミ箱")
(setq wl-fcc "%[Gmail]/送信済みメール")
;;(setq wl-default-spec "%")


;;オンラインになったときに自動的にキューを送信するか どうか。初期設定は t。
(setq wl-auto-flush-queue nil)


;; 添付ファイルがあると『@』を表示する
(setq elmo-msgdb-extra-fields
      '("content-type")
      )
(setq wl-summary-line-format "%n%T%P%1@%Y/%M/%D(%W)%h:%m %t%[%17(%c %f%) %] %s")
;; sentディレクトリでは差出人表示を宛先に差し替える
(setq wl-summary-showto-folder-regexp "^\\+sent$")

;(setq elmo-msgdb-extra-fields
;      (cons "content-type" elmo-msgdb-extra-fields))
;(setq wl-summary-line-format-spec-alist
;      (append wl-summary-line-format-spec-alist
;         '((?@ (wl-summary-line-attached)))))
;(setq wl-summary-line-format
;      "%n%T%P%1@%M/%D(%W)%h:%m %t%[%17(%c %f%) %] %s")



;; GMail 風、新着レス順にソート
;; https://gist.github.com/whym/153020
;(defun wl-summary-overview-entity-compare-by-reply-number (a b)
;  "Compare entity A and B by latest number of replies."
;  (let ((fx #'(lambda (x)
;                (setq x (elmo-message-entity-number x))
;                (apply 'max x (wl-thread-entity-get-descendant
;                               (wl-thread-get-entity x))))))
;    (< (funcall fx a) (funcall fx b))))
;(add-to-list 'wl-summary-sort-specs 'reply-number)


;; ファイル名が日本語の添付ファイルをデコードする [semi-gnus-ja: 4332]
(eval-after-load "mime"
  '(defadvice mime-entity-filename
     (after eword-decode-for-broken-MUA activate)
     "Decode eworded file name for *BROKEN* MUA."
     (when (stringp ad-return-value)
       (setq ad-return-value (eword-decode-string ad-return-value t)))))
;; ファイル名が日本語の添付ファイルをエンコードする [semi-gnus-ja: 6046]
(eval-after-load "std11"
  '(defadvice std11-wrap-as-quoted-string
     (before encode-string activate)
     "Encode a string."
     (require 'eword-encode)
     (ad-set-arg 0 (eword-encode-string (ad-get-arg 0)))))


;; ドラフトを自動保存しない
;(setq wl-auto-save-drafts-interval nil)

;; サマリ終了時に次のフォルダに移る動きを抑制
(setq wl-summary-exit-next-move nil)

;; サマリモードに入った直後に最下部にカーソルを移動する
(add-hook 'wl-summary-prepared-hook 'wl-summary-display-bottom)

;; サマリとメッセージのウィンドウサイズの比率を設定
(setq wl-message-window-size '(1 . 4))

;; サマリ行を切り詰めない
(setq wl-summary-width nil)

