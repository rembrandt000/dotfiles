;;; Emacs のカレンダーに日本の祝日を設定する (japanese-holidays)
(eval-after-load "holidays"
  '(progn
     (require 'japanese-holidays)
     (setq calendar-holidays ; 他の国の祝日も表示させたい場合は適当に調整
           (append japanese-holidays holiday-local-holidays holiday-other-holidays))
     (setq mark-holidays-in-calendar t) ; 祝日をカレンダーに表示
     ;; 土曜日・日曜日を祝日として表示する場合、以下の設定を追加します。
     ;; 変数はデフォルトで設定済み
     (setq japanese-holiday-weekend '(0 6)     ; 土日を祝日として表示
           japanese-holiday-weekend-marker     ; 土曜日を水色で表示
           '(holiday nil nil nil nil nil japanese-holiday-saturday))
     (add-hook 'calendar-today-visible-hook 'japanese-holiday-mark-weekend)
     (add-hook 'calendar-today-invisible-hook 'japanese-holiday-mark-weekend)
     ;; “きょう”をマークするには以下の設定を追加します。
     (add-hook 'calendar-today-visible-hook 'calendar-mark-today)))



;;; Emacsでカレンダーコンポーネントを作ってみた (calfw)
(require 'calfw) ; 初回一度だけ
;; (cfw:open-calendar-buffer) ; カレンダー表示

;; calfw org-mode連携プログラム
(require 'calfw-org)
;(define-key global-map (kbd "C-cc") 'cfw:open-org-calendar)

;; howm連携プログラム
(eval-after-load "howm-menu"
  '(progn
    (require 'calfw-howm)
    (cfw:install-howm-schedules)
    (define-key howm-mode-map (kbd "M-C") 'cfw:open-howm-calendar)
))



