;;(require 'e2wm)
(global-set-key (kbd "M-+") 'e2wm:start-management)
;; 終了する場合は「C-c ; Q」で

;; パースペクティブ設定
(setq e2wm:c-code-recipe
      '(| (:left-max-size 35)
          (- (:upper-size-ratio 0.6)
             tree history)
          (- (:lower-max-size 150)
             (| (:right-max-size 30)
                main imenu)
             sub)))

(setq e2wm:c-code-winfo
      '((:name main)
        (:name tree    :plugin direx)
        (:name history :plugin history-list)
        (:name imenu   :plugin imenu :default-hide nil)
        (:name sub     :buffer "*info*" :default-hide t)))

(setq e2wm:c-doc-recipe
      '(- (:lower-max-size 150)
          '(| (:right-max-size 30)
              main
              (- (upper-size-ratio 0.4)
                 agenda cal))
          sub))

(setq e2wm:c-doc-winfo
      '((:name main)
        (:name agenda);   :buffer "*Org Agenda*")
        (:name cal :for bijin);      :buffer "*cfw-calendar*")
        (:name sub      :buffer "*info*" :default-hide t)
        ))

(setq e2wm:c-blank-buffer         ; 白紙バッファ
       (let ((buf (get-buffer-create " *e2wm:blank*")))
         (with-current-buffer buf
           (setq buffer-read-only nil)
           (buffer-disable-undo buf)
           (erase-buffer)
           (setq buffer-read-only t)) buf))



;; キーバインド
(e2wm:add-keymap
 e2wm:pst-minor-mode-keymap
 '(
;   ("<M-left>" . e2wm:dp-code) ; codeへ変更
;   ("<M-right>"  . e2wm:dp-two)  ; twoへ変更
;   ("<M-up>"    . e2wm:dp-doc)  ; docへ変更
;   ("<M-down>"  . e2wm:dp-dashboard) ; dashboardへ変更
   ("C-."       . e2wm:pst-history-forward-command) ; 履歴を進む
   ("C-,"       . e2wm:pst-history-back-command) ; 履歴をもどる
   ("prefix L"  . ielm)
   ("M-m"       . e2wm:pst-window-select-main-command)
   ) e2wm:prefix-key)


;; プラグインカスタマイズ
;; for bijin (default)
(setq e2wm:def-plugin-clock-url "http://www.bijint.com/jp/img/clk/%H%M.jpg")
(setq e2wm:def-plugin-clock-referer "http://www.bijint.com/jp/")


;;; For elscreen.el

;; elscreen.el は e2wm と同じく、フレーム内のウインドウの挙動を監視し、
;; ウインドウの状態を保存、復帰している。そのため、スクリーン（タブ）
;; を作ると、e2wmはウインドウを管理できなくなる。デフォルトの状態では、
;; スクリーンを複数作らなければelscreen.el自体を動かすことについては
;; 特に問題はない。

;; 回避方法としては、elscreenの管理オブジェクトの中にe2wmの管理オブジェ
;; クトを入れてelscreenの傘下に入るという方法を行う。これにより、
;; elscreenごとに異なる異なるe2wmインスタンスを持つ頃が出来る。
;; （e2wmの所々でグローバルで値を共有しているところがあるので今後直す）

(eval-after-load "elscreen"
  '(progn
     ;; overrides storages for elscreen
     (defadvice e2wm:frame-param-get (around e2wm:ad-override-els (name &optional frame))
       ;; frame is not used...
       (e2wm:message "** e2wm:frame-param-get : %s " name)
       (let ((alst (cdr (assq 'e2wm-frame-prop
                              (elscreen-get-screen-property
                               (elscreen-get-current-screen))))))
         (setq ad-return-value (and alst (cdr (assq name alst))))))
     (defadvice e2wm:frame-param-set (around e2wm:ad-override-els (name val &optional frame))
       (e2wm:message "** e2wm:frame-param-set : %s / %s" name val)
       (let* ((screen (elscreen-get-current-screen))
              (screen-prop (elscreen-get-screen-property screen))
              (alst (cdr (assq 'e2wm-frame-prop screen-prop))))
         (set-alist 'alst name val)
         (set-alist 'screen-prop 'e2wm-frame-prop alst)
         (elscreen-set-screen-property screen screen-prop)
         (setq ad-return-value val)))
     ;; grab switch events
     (defun e2wm:elscreen-define-advice (function)
       (eval
        `(defadvice ,function (around e2wm:ad-override-els)
           (e2wm:message "** %s vvvv" ',function)
           (when (e2wm:managed-p)
             (e2wm:message "** e2wm:managed")
             (let ((it (e2wm:pst-get-instance)))
               (e2wm:pst-method-call e2wm:$pst-class-leave it (e2wm:$pst-wm it)))
             (e2wm:pst-minor-mode -1))
           (e2wm:message "** ad-do-it ->")
           ad-do-it
           (e2wm:message "** ad-do-it <-")
           (e2wm:message "** e2wm:param %s"
                         (cdr (assq 'e2wm-frame-prop
                                    (elscreen-get-screen-property
                                     (elscreen-get-current-screen)))))
           (when (e2wm:managed-p)
             (e2wm:message "** e2wm:managed")
             (let ((it (e2wm:pst-get-instance)))
               (e2wm:pst-method-call e2wm:$pst-class-start it (e2wm:$pst-wm it)))
             (e2wm:pst-minor-mode 1))
           (e2wm:message "** %s ^^^^^" ',function)
           )))
     (defadvice elscreen-create (around e2wm:ad-override-els)
       (let (default-wcfg)
         (when (e2wm:managed-p)
           (loop for screen in (reverse (sort (elscreen-get-screen-list) '<))
                 for alst = (cdr (assq 'e2wm-frame-prop
                                       (elscreen-get-screen-property screen)))
                 for wcfg = (and alst (cdr (assq 'e2wm-save-window-configuration alst)))
                 if wcfg
                 do (setq default-wcfg wcfg) (return)))
         ad-do-it
         (when default-wcfg
           (set-window-configuration default-wcfg))))
     (defadvice elscreen-run-screen-update-hook (around e2wm:ad-override-els)
       (flet ((e2wm:managed-p () nil))
         ad-do-it
         ))

     ;; apply defadvices to some elscreen functions
     (loop for i in '(elscreen-goto
                      elscreen-kill
                      elscreen-clone
                      elscreen-swap)
           do (e2wm:elscreen-define-advice i))
     (defun e2wm:elscreen-override ()
       (ad-activate-regexp "^e2wm:ad-override-els$")
       (setq e2wm:override-window-ext-managed t))
     (defun e2wm:elscreen-revert ()
       (ad-deactivate-regexp "^e2wm:ad-override-els$")
       (setq e2wm:override-window-ext-managed nil))
     ;; start and exit
     (add-hook 'e2wm:pre-start-hook 'e2wm:elscreen-override)
     (add-hook 'e2wm:post-stop-hook 'e2wm:elscreen-revert)
     ))

