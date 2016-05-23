(global-set-key "\C-h" 'backward-delete-char)                       ;; C-h でBackSpace
(global-set-key "\C-x\C-b" 'bs-show)                                ;; C-xC-bをM-x bs-showに変更
(global-set-key [M-kanji] 'ignore)                                  ;; M-kanjiとうるさいので...
(global-set-key (kbd "C-t") 'other-window)                          ;; C-tでバッファ間移動
(define-key global-map (kbd "C-M-n") 'next-multiframe-window)       ;; 次のウィンドウへ移動
(define-key global-map (kbd "C-M-p") 'previous-multiframe-window)   ;; 前のウィンドウへ移動
(global-set-key (kbd "C-M-,") 'scroll-up-line)                      ;; １行づつスクロールアップ
(global-set-key (kbd "C-M-.") 'scroll-down-line)                    ;; １行づつスクロールダウン
(global-set-key "\C-x\C-f" 'helm-find-files)
(global-set-key (kbd "C-c t") 'toggle-truncate-lines)               ;; C-c tで折り返しオンオフ
(define-key dired-mode-map (kbd ",") 'helm-occur)                   ;; diredで , で検索開始
(global-set-key (kbd "M-s o") 'loccur)

;; Shift + ↓ or → or ← or ↑でバッファ移動
(setq windmove-wrap-around t)
(windmove-default-keybindings)

;; buffer-move - bufferの移動
(global-set-key (kbd "M-g h") 'buf-move-left)
(global-set-key (kbd "M-g j") 'buf-move-down)
(global-set-key (kbd "M-g k") 'buf-move-up)
(global-set-key (kbd "M-g l") 'buf-move-right)

