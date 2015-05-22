;; Search for right makefile automatically
(require 'cl) ; If you don't have it already
(require 'compile)

(defun get-closest-makefile ()
  "Determine the pathname of the first instance of FILE starting from the current directory towards root.
This may not do the correct thing in presence of links. If it does not find FILE, then it shall return the name
of FILE in the current directory, suitable for creation"
  (locate-dominating-file default-directory "CMakeLists.txt"))

;; (defun my-compilation-mode-hook () (
;;                                     set(make-local-variable
;;                                          'compile-command)
;;                                         (format "make -C %s"
;;                                                 (get-closest-makefile))
;;                                         )
;;        )

;; (add-hook 'c-mode-common-hook 'my-compilation-mode-hook)

(defun compile-anne ()
  (interactive)
  (setq compile-command (format "make -j4 -C %s" (get-closest-makefile)))
  ;; (message compile-command)
  (call-interactively 'compile)
  )

(defun recompile-quietly ()
  "Re-compile without changing the window configuration."
  (interactive)
  (save-window-excursion
    (recompile)))

;; Compile shortcut 
(global-set-key (kbd "<f9>") 'compile-anne)
(global-set-key (kbd "<f10>") 'recompile-quietly)

(add-hook 'compilation-mode-hook
          (lambda () (visual-line-mode 1)))

