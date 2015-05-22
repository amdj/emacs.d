
;; Emacs is not a package manager, and here we load its package manager!
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)


;; This file is setup to get a minimalistic emacs in the terminal. 

;;------------------------------Font
(set-face-attribute 'default nil :height 100)
;; Customize settings
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-for-comint-mode t)
 '(c-backslash-max-column 80)
 '(c-cleanup-list
   (quote
    (brace-else-brace brace-elseif-brace empty-defun-braces one-liner-defun defun-close-semi list-close-comma scope-operator)))
 '(c-enable-xemacs-performance-kludge-p t)
 '(comint-buffer-maximum-size 10000)
 '(comint-completion-addsuffix t)
 '(comint-move-point-for-output t)
 '(comint-scroll-to-bottom-on-input t)
 '(compilation-ask-about-save t)
 '(compilation-scroll-output (quote first-error))
 '(compilation-skip-threshold 2)
 '(ede-project-directories (quote ("/home/anne/wip/code/timedomainmodel")))
 '(electric-indent-mode t)
 '(electric-layout-mode t)
 '(flymake-google-cpplint-command "/usr/bin/cpplint")
 '(flymake-google-cpplint-filter
   "-whitespace/line_length,-build/include,-legal/copyright,-build/header_guard,-readability/casting")
 '(flymake-google-cpplint-linelength "120")
 '(flymake-google-cpplint-verbose "3")
 '(frame-background-mode (quote dark))
 '(mark-ring-max 20)
 '(multi-term-program "/bin/bash")
 '(multi-term-scroll-show-maximum-output t)
 '(multi-term-scroll-to-bottom-on-output t)
 '(next-screen-context-lines 10)
 '(org-pretty-entities t)
 '(org-pretty-entities-include-sub-superscripts t)
 '(standard-indent 2)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-set-key (kbd "C-x C-o") 'ff-find-other-file)

;;-------------------- theme
(when (display-graphic-p)
  (progn
    ;;(color-theme-solarized)
    (add-to-list 'custom-theme-load-path "/home/anne/.emacs.d/plugins_anne/emacs-color-theme-solarized/")
    (load-theme 'solarized t)
  )                                     ;progn
)

(add-to-list 'load-path "/home/anne/.emacs.d/plugins_anne")

;; GLOBAL CONFIGURATION SETTINGS ****************************************

;; ------------------------------ Line numbers
(global-linum-mode 1)
(column-number-mode 1)

;; splash screen anymore
(setq inhibit-splash-screen t)

(defun select-next-window ()
  "Switch to the next window" 
  (interactive)
  (select-window (next-window)))

(defun select-previous-window ()
  "Switch to the previous window" 
  (interactive)
  (select-window (previous-window)))

(global-set-key (kbd "C-1") 'other-frame)
(global-set-key (kbd "C-2") 'select-previous-window)
(global-set-key (kbd "C-3") 'select-next-window)
(global-set-key (kbd "C-S-n") 'next-buffer)
(global-set-key (kbd "C-S-p") 'previous-buffer)

;; Line truncation
(global-set-key (kbd "<f12>") 'toggle-truncate-lines)


;; When two buffers have same filename, we want to see more difference than just <2>
(require 'uniquify)

;; ------------------------------ cmake-mode
(require 'cmake-mode)

;; Custom save place for autosaves
(require 'saveplace)                          ;; get the package
(setq save-place-file "~/.emacs_thismachine/saveplace") ;; keep my ~/ clean
(setq-default save-place t)                   ;; activate it for all buffers
;; Custom directory to save files
(setq backup-directory-alist `(("." . "~/.emacs_thismachine/")))

;; ------------------------------ Execute keyboard macro to F-5
(global-set-key (kbd "<f5>") 'kmacro-end-and-call-macro)


;;------------------------------ ido-mode (interactive-do-mode)
(require 'ido-ubiquitous)
(ido-mode 1)
(ido-ubiquitous-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

;; Improved M-x command
(require 'smex) ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                  ; when Smex is auto-initialized on its first run.
(global-set-key "\C-x\C-m" 'smex)
(global-set-key "\C-x\C-j" 'smex-major-mode-commands)
; Addition from Archwiki
(defalias 'yes-or-no-p 'y-or-n-p)

; An example how key bindings can be done to functions
(global-set-key (kbd "<f7>") 'query-replace)
(global-set-key (kbd "<f6>") 'query-replace-regexp)

;;------------------------------Open recent file
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;;--------------- For debugging emacs files
(setq stack-trace-on-error t)

;; ---------------------------------------------------------------


;; ------------------------------------------------------------------
;; Showing parentheses
(show-paren-mode 1)
(setq show-paren-style 'expression)
(setq show-paren-delay 0)
;;---------------------------------------------------------------

;;---------------------------------------------------------------

;; CODE SPECIFIC SETTINGS ****************************************

;; Paren experiment
;; (setq skeleton-pair t)

;; c++ mode for header files
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cxx\\'" . c++-mode))
;; Comment line code (Added by Anne)
(global-set-key "\C-ck" 'comment-or-uncomment-region)
(fset 'comment-line
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([24 114 32 114 1 67108896 5 3 107 24 114 106 114] 0 "%d")) arg)))
(global-set-key "\C-cc" 'comment-line)
   

;; Move 20 lines downward
;;(global-set-key (kbd "C-m") "\C-n\C-l")
(setq scroll-preserve-screen-position t)


(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)

;; Imortant addition from Anne: only one compilation window at a time!
(add-to-list
 'display-buffer-alist
 '("\\*compilation\\*" display-buffer-reuse-window
   (reusable-frames . t)))
(add-to-list 'display-buffer-alist
 '("\\*UBP Python2\\*" display-buffer-reuse-window
   (reusable-frames . t)))

;; ---------------------------------------------------------------------

;; ---------------------------------------------------------
;; Fast window switching with the shift key
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))



;; Indent whole buffer
(defun indent-whole-buffer ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))
(setq next-line-add-newlines t)


;;-------------------- org mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)


;;------------------------------ auto fll mode
(global-set-key (kbd "C-c q") 'auto-fill-mode)
(auto-fill-mode 1)
(setq fill-paragraph 80)
(setq fill-column 80)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'c-mode-hook 'turn-on-auto-fill)
(add-hook 'c++-mode-hook 'turn-on-auto-fill)
(setq comment-auto-fill-only-comments t)
(setq comment-multi-line t)
(setq c-indent-comments-syntactically-p t)

;; Very wise setting: indent macro commands as regular!!
(c-set-offset (quote cpp-macro) 0 nil)



;; ------------------------------ Copy functions
(defun get-point (symbol &optional arg)
  "get the point"
  (funcall symbol arg)
  (point)
  )

(defun copy-thing (begin-of-thing end-of-thing &optional arg)
  "copy thing between beg & end into kill ring"
  (save-excursion
    (let ((beg (get-point begin-of-thing 1))
	  (end (get-point end-of-thing arg)))
      (copy-region-as-kill beg end)))
  )

(defun paste-to-mark(&optional arg)
  "Paste things to mark, or to the prompt in shell-mode"
  (let ((pasteMe 
     	 (lambda()
     	   (if (string= "shell-mode" major-mode)
	       (progn (comint-next-prompt 25535) (yank))
	     (progn (goto-char (mark)) (yank) )))))
    (if arg
	(if (= arg 1)
	    nil
	  (funcall pasteMe))
      (funcall pasteMe))
    ))
(defun copy-word (&optional arg)
  "Copy words at point into kill-ring"
  (interactive "P")
  (copy-thing 'backward-word 'forward-word arg)
  ;;(paste-to-mark arg)
  )
(global-set-key (kbd "C-c w")         (quote copy-word))
;;------------------------------ Annes functions for TRACE

; set the keybinding so that you can use f8 for goto line
(global-set-key (kbd "<f8>") 'goto-line)

;; Create regexp expression from string
 (defun reb-query-replace (to-string)
      "Replace current RE from point with `query-replace-regexp'."
      (interactive
       (progn (barf-if-buffer-read-only)
              (list (query-replace-read-to (reb-target-binding reb-regexp)
                                           "Query replace"  t))))
      (with-current-buffer reb-target-buffer
        (query-replace-regexp (reb-target-binding reb-regexp) to-string)))
(setq reb-re-syntx 'string)
(setq org-use-sub-superscripts "{}")


;; for other code, e.g. emacsclient in TRAMP ssh shells and automatically
;; closing completions buffers, see the links above.


;; Copy whole line 
(defun anne-copy-line ()
  "Copy the current line to the kill ring"
  (interactive)
  (setq anne-col (current-column))
  (call-interactively 'move-beginning-of-line)
  (push-mark)
  (call-interactively 'move-end-of-line)
  (call-interactively 'kill-ring-save)
  (move-to-column anne-col)
  )
(global-set-key  "\C-z" 'backward-delete-char-untabify)
(global-set-key (kbd "C-S-k") 'anne-copy-line)
(define-key isearch-mode-map "\C-z" 'isearch-delete-char)
;;  MY first emacs function!! yes!


(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))
(setq read-quoted-char-radix 16)

(load "~/.emacs.d/emacs_shell_config_anne.el")
(load "~/.emacs.d/compilation_settings_anne.el")
(global-set-key (kbd "\C-c \C-t") 'multi-term)

(when (display-graphic-p)
  (progn
  (if (file-exists-p "~/.emacs.d/emacscustom.el")
      (load "~/.emacs.d/emacscustom.el")
    )
  ;; Custom machine-dependent initialization
  (if (file-exists-p "~/.emacs_thismachine.el")
      (load "~/.emacs_thismachine.el")
    )
  )                                     ;progn
)
(set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))


