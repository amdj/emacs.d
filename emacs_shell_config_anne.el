(add-to-list 'load-path "~/.emacs.d/plugins_anne/emacs-bash-completion")
(require 'bash-completion)
(bash-completion-setup)


(add-hook 'term-mode-hook (lambda()
        (setq yas-dont-activate t)))

;;----------------- emacs shell COMPLETION

;; (autoload 'bash-completion-dynamic-complete 
;;   "bash-completion"
;;   "BASH completion hook")
;; (add-hook 'shell-dynamic-complete-functions
;;   'bash-completion-dynamic-complete)
;; (add-hook 'shell-command-complete-functions
;;   'bash-completion-dynamic-complete)


;; ;;------------------------------ create a second shell
;; (defun create-shell ()
;;     "creates a shell with a given name"
;;     (interactive);; "Prompt\n shell name:")
;;     ;; (let ((shell-name (read-string "shell name: " nil)))
;;     ;; (term (concat "*" shell-name "*"))))
;;     (term "/bin/bash"))


;; ;; multi-term
(require 'multi-term)
(setq multi-term-program "/bin/bash")

;; (setenv "PAGER" "cat")

;; ;; truncate buffers continuously
;; (add-hook 'comint-output-filter-functions 'comint-truncate-buffer)

;; (defun make-my-shell-output-read-only (text)
;;   "Add to comint-output-filter-functions to make stdout read only in my shells."
;;   (if (member (buffer-name) my-shells)
;;       (let ((inhibit-read-only t)
;;             (output-end (process-mark (get-buffer-process (current-buffer)))))
;;         (put-text-property comint-last-output-start output-end 'read-only t))))
;; (add-hook 'comint-output-filter-functions 'make-my-shell-output-read-only)

;; (defun my-dirtrack-mode ()
;;   "Add to shell-mode-hook to use dirtrack mode in my shell buffers."
;;   (when (member (buffer-name) my-shells)
;;     (shell-dirtrack-mode 0)
;;     (set-variable 'dirtrack-list '("^.*[^ ]+:\\(.*\\)>" 1 nil))
;;     (dirtrack-mode 1)))
;; (add-hook 'shell-mode-hook 'my-dirtrack-mode)

;; ; interpret and use ansi color codes in shell output windows
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; (defun set-scroll-conservatively ()
;;   "Add to shell-mode-hook to prevent jump-scrolling on newlines in shell buffers."
;;   (set (make-local-variable 'scroll-conservatively) 5))
;; (add-hook 'shell-mode-hook 'set-scroll-conservatively)

;; ;; i think this is wrong, and it buries the shell when you run emacsclient from
;; ;; it. temporarily removing.
;; ;; (defun unset-display-buffer-reuse-frames ()
;; ;;   "Add to shell-mode-hook to prevent switching away from the shell buffer
;; ;; when emacsclient opens a new buffer."
;; ;;   (set (make-local-variable 'display-buffer-reuse-frames) t))
;; ;; (add-hook 'shell-mode-hook 'unset-display-buffer-reuse-frames)


;; (defun make-comint-directory-tracking-work-remotely ()
;;   "Add this to comint-mode-hook to make directory tracking work
;; while sshed into a remote host, e.g. for remote shell buffers
;; started in tramp. (This is a bug fix backported from Emacs 24:
;; http://comments.gmane.org/gmane.emacs.bugs/39082"
;;   (set (make-local-variable 'comint-file-name-prefix)
;;        (or (file-remote-p default-directory) "")))
;; (add-hook 'comint-mode-hook 'make-comint-directory-tracking-work-remotely)

;; (defun enter-again-if-enter ()
;;   "Make the return key select the current item in minibuf and shell history isearch.
;; An alternate approach would be after-advice on isearch-other-meta-char."
;;   (when (and (not isearch-mode-end-hook-quit)
;;              (equal (this-command-keys-vector) [13])) ; == return
;;     (cond ((active-minibuffer-window) (minibuffer-complete-and-exit))
;;           ((member (buffer-name) my-shells) (comint-send-input)))))
;; (add-hook 'isearch-mode-end-hook 'enter-again-if-enter)

;; (defadvice comint-previous-matching-input
;;     (around suppress-history-item-messages activate)
;;   "Suppress the annoying 'History item : NNN' messages from shell history isearch.
;; If this isn't enough, try the same thing with
;; comint-replace-by-expanded-history-before-point."
;;   (let ((old-message (symbol-function 'message)))
;;     (unwind-protect
;;       (progn (fset 'message 'ignore) ad-do-it)
;;     (fset 'message old-message))))

;; (defadvice comint-send-input (around go-to-end-of-multiline activate)
;;   "When I press enter, jump to the end of the *buffer*, instead of the end of
;; the line, to capture multiline input. (This only has effect if
;; `comint-eol-on-send' is non-nil."
;;   (flet ((end-of-line () (end-of-buffer)))
;;     ad-do-it))

;; ;; not sure why, but comint needs to be reloaded from the source (*not*
;; ;; compiled) elisp to make the above advise stick.
;; (load "comint.el.gz")


