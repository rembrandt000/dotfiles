;; 設定ファイルを読み込むだけのマクロ
; (global-set-key (kbd "C-x l") 'my-load-init-file)
(defun my-load-init-file()
  "init.elを読み込む"
  (interactive)
  (find-file "~/.emacs.d/init.el"))


;; ----------------------------------------------------------
;; フレームサイズ変更
;; C-c C-r 後に h j k l でサイズ変更
(defun my-window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        action c)
    (catch 'end-flag
      (while t
        (setq action
              (read-key-sequence-vector (format "size[%dx%d]"
                                                (window-width)
                                                (window-height))))
        (setq c (aref action 0))
        (cond ((= c ?l)
               (enlarge-window-horizontally dx))
              ((= c ?h)
               (shrink-window-horizontally dx))
              ((= c ?j)
               (enlarge-window dy))
              ((= c ?k)
               (shrink-window dy))
              ;; otherwise
              (t
               (let ((last-command-char (aref action 0))
                     (command (key-binding action)))
                 (when command
                   (call-interactively command)))
               (message "Quit")
               (throw 'end-flag t)))))))
(global-set-key "\C-c\C-r" 'my-window-resizer)


;; ----------------------------------------------------------
;; recentf定期保存
(defvar my-recentf-list-prev nil)

(defadvice recentf-save-list
  (around no-message activate)
  "If `recentf-list' and previous recentf-list are equal,
do nothing. And suppress the output from `message' and
`write-file' to minibuffer."
  (unless (equal recentf-list my-recentf-list-prev)
    (cl-flet ((message (format-string &rest args)
                       (eval `(format ,format-string ,@args)))
              (write-file (file &optional confirm)
                          (let ((str (buffer-string)))
                            (with-temp-file file
                              (insert str)))))
      ad-do-it
      (setq my-recentf-list-prev recentf-list))))
 
(defadvice recentf-cleanup
    (around no-message activate)
  "suppress the output from `message' to minibuffer"
  (cl-flet ((message (format-string &rest args)
                     (eval `(format ,format-string ,@args))))
    ad-do-it))
 
(setq recentf-save-file (expand-file-name "recentf" user-emacs-directory))
(setq recentf-max-saved-items 2000)
(setq recentf-max-menu-items 50)
(setq recentf-exclude '("recentf"))
(setq recentf-auto-cleanup 100)
(run-with-idle-timer 30 t 'recentf-save-list)
(recentf-mode t)



