;; simplenote2-browse	ノート同期
;; simplenote2-filter-note-by-tag [tag]	タグ選択
;; C-u M-x simplenote2-filter-note-by-tag	タグ選択解除
;; simplenote2-create-note-form-buffer	バッファをsimplenoteにアップロード準備(sync時にアップロード)
;; simplenote2-pull-buffer	simplenoteからバッファをダウンロード(新規で開き直し)
;; simplenote2-push-buffer	simplenoteへアップロード
;; simplenote2-sync-note	同期

(require 'simplenote2)
(setq simplenote2-email "rembrandt.bluewing@gmail.com")
(setq simplenote2-password "angelpower")
(simplenote2-setup)
