(setq w3m-command "w3m")
(require 'w3m)
(setq w3m-use-cookies t) 		 ;ログイン可能にする
(setq w3m-favicon-cache-expire-wait nil) ;favicon のキャッシュを消さない

(setq
 w3m-profile-directory (concat my-dropbox-directory "soft/dotfiles/.emacs.d/.w3m")
 w3m-default-save-directory (concat my-dropbox-directory "soft/dotfiles/.emacs.d/.w3m")
 w3m-bookmark-file (concat my-dropbox-directory "soft/dotfiles/.emacs.d/.w3m/bookmark.html")
 w3m-session-file (concat my-dropbox-directory "soft/dotfiles/.emacs.d/.w3m/.sessions")
 w3m-arrived-file (concat my-dropbox-directory "soft/dotfiles/.emacs.d/.w3m/.arrived")
 w3m-cookie-file (concat my-dropbox-directory "soft/dotfiles/.emacs.d/.w3m/.cookie")
 )


;; 右手だけで操作
 ; タブを移動する
;(with-eval-after-load "w3m"
  (define-key w3m-mode-map "l" '(lambda () (interactive) (w3m-next-buffer 1)))
  (define-key w3m-mode-map "h" '(lambda () (interactive) (w3m-next-buffer -1)))
  (define-key w3m-mode-map "p" '(lambda () (interactive) (w3m-view-previous-page)))
  ; タブを閉じる
  (define-key w3m-mode-map "o" 'w3m-delete-buffer)
  ; 次のリンクに飛ぶ
  (define-key w3m-mode-map "i" 'w3m-next-anchor)
  ; リンクを新しいタブで開く
  (define-key w3m-mode-map "'" 'w3m-view-this-url-new-session)
  ; リンクを普通に開く
  ; (define-key w3m-mode-map "'" 'w3m-view-this-url)
  ; カーソル下にある画像を表示
  (define-key w3m-mode-map "n" 'w3m-toggle-inline-image)
  ; ブックマークを表示
  (define-key w3m-mode-map "m" 'w3m-bookmark-view-new-session)
;)
