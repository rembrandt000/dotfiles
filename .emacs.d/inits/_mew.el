;; mew
(require 'mew)

;(setq mew-prog-ssl "/usr/bin/stunnel4")

; IMAP for Gmail
(setq mew-proto "%")
(setq mew-user "takakusa.yasuo@rene-easton.com")
;(setq mew-imap-domain "rene-easton.com")
(setq mew-imap-server "localhost")
(setq mew-imap-user "takakusa.yasuo@rene-easton.com")
(setq mew-imap-auth  t)
;(setq mew-imap-ssl t)
;(setq mew-imap-ssl-port "18906")
(setq mew-imap-port "18906")
(setq mew-smtp-auth t)
;(setq mew-smtp-ssl t)
;(setq mew-smtp-ssl-port "18902")
(setq mew-smtp-port "18902")
(setq mew-smtp-user "takakusa.yasuo@rene-easton.com")
(setq mew-smtp-server "localhost")
(setq mew-fcc "%Sent") ; 送信メイルを保存する
(setq mew-imap-trash-folder "%[Gmail]/ゴミ箱")
(setq mew-use-cached-passwd t)
(setq mew-ssl-verify-level 0)

