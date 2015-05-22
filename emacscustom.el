;; This file is only evaluated when emacs is run in graphical mode

;; Start a new server
(server-start)

(if (file-exists-p "~/wip/TAGS")
    (visit-tags-table "~/wip/TAGS"))

(require 'tempo)
(require 'cython-mode)
;; Swig mode
(require 'swig-mode)
(add-to-list 'auto-mode-alist '("\\.i\\'" . swig-mode))

;;-------------------- theme
;;(color-theme-solarized)
(add-to-list 'custom-theme-load-path "/home/anne/.emacs.d/solarized/")
(load-theme 'solarized t)

(require 'yasnippet) ;; not yasnippet-bundle
(yas-global-mode 1)
(add-hook 'term-mode-hook '(lambda () (yas-minor-mode -1)))

;; Remove Yasnippet's default tab key binding
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
;; Set Yasnippet's key binding to shift+tab
(define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand)

;;------------------------------ Auto-complete mode
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(setq ac-quick-help-delay 0.5)
(global-auto-complete-mode t)
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

;; auto-complete config stuff
;; (setq ac-auto-start nil)
;; (setq ac-expand-on-auto-complete nil)

;; From tutorial: auto complete c headers
(defun myac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/local/include")
  (add-to-list 'achead:include-directories '"/usr/include")
  (add-to-list 'achead:include-directories '"/usr/include/c++/4.9.2")
  )
(add-hook 'c-mode-common-hook 'myac-c-header-init)
  
;; Auto format code
  (if (file-exists-p "~/usr/share/clang/clang-format.el")
      (load "/usr/share/clang/clang-format.el")
    (global-set-key [C-M-tab] 'clang-format-region)
    )



(require 'auto-complete-clang)
(defun my:company-clang-init()
  (company-mode 1)
  (setq company-idle-delay .3)
  (add-to-list 'company-clang-arguments '"-I/usr/include/c++/4.9.2")
  (add-to-list 'company-clang-arguments '"-I/usr/local/include")
  (add-to-list 'company-clang-arguments '"-I/usr/include")
  (add-to-list 'company-clang-arguments '"-I."))
 
(add-hook 'c++-mode-hook 'my:company-clang-init)
(add-hook 'c-mode-hook 'my:company-clang-init)
 
;; Provides the function expand-member-functions, which automagically
;; generates Stubs for all functions defined in the header file
;; classes.
(require 'member-functions)

;; (add-hook 'c++-mode-hook 'irony-mode)
;; (add-hook 'c-mode-hook 'irony-mode)
;; (add-hook 'objc-mode-hook 'irony-mode)

;; (require 'irony)
; also enable ac plugin
;; (irony-enable 'ac)
; define a function to start irony mode for c/c++ modes
;; (defun my:irony-enable()
;;   (when (member major-mode irony-known-modes)
;;     (irony-mode 1)))
;; (add-hook 'c++-mode-hook 'my:irony-enable)
;; (add-hook 'c-mode-hook 'my:irony-enable)



;; (setq clang-completion-suppress-error 't)

;; start flymake-google-cpplint-load
;; let's define a function for flymake initialization

;; Advanced IDE tools:(ede)
(global-ede-mode 1)
;; (ede-enable-generic-projects)
;; (ede-cpp-root-project "tmtubes" :include-path '())


(require 'semantic/complete)
(require 'semantic/sb)

(semantic-mode 1)
;; For sysyem libraries
(require 'semantic/bovine/gcc)
;; (global-sem
(global-semanticdb-minor-mode 1)
;; (require 'semantic-tag-folding)
;; (global-semantic-tag-folding-mode t)
;; (global-cedet-m3-minor-mode 1)
(global-semantic-decoration-mode 1)
(global-semantic-idle-scheduler-mode 1)
(global-semantic-highlight-func-mode 1)
(global-semantic-highlight-edits-mode 1)
(global-semantic-show-unmatched-syntax-mode 1)
(global-semantic-mru-bookmark-mode)
(global-semantic-stickyfunc-mode)

(setq semantic-inhibit-functions
      (list (lambda () (not (and (featurep 'cc-defs)
                                 c-buffer-is-cc-mode)))))
(add-to-list 'semantic-inhibit-functions
             (lambda () (member major-mode '(swig-mode))))

;; (defun startsemantic()
;;   (semantic-decoration-mode 1)
;;   (add-to-list 'ac-sources 'ac-source-semantic)
;;   )
;; (add-hook 'c-mode-common-hook 'startsemantic)
;; (add-hook 'c++-mode-hook 'my:flymake-google-init)
;; ------------------------------ Fill column indicator
(require 'fill-column-indicator)
;; (define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode t)))
(add-hook 'text-mode-hook 'fci-mode)
(add-hook 'c-mode-common-hook 'fci-mode)


;; auto-complete-clang config stuff
;; (defun my-ac-cc-mode-setup ()
;;   (setq ac-sources (append '(ac-source-clang) ac-sources)))
;; (add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)

;; ;; (define-key c++-mode-map (kbd "C-S-<return>") 'ac-complete-clang)
;; (setq mf--source-file-extension "cpp")
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")

; Fix iedit bug in Mac
(define-key global-map (kbd "C-c ;") 'iedit-mode)

;; (setq ac-ignore-case nil)

;; (defun my-semantic-hook ()
;;   (imenu-add-to-menubar "TAGS"))
;; (add-hook 'semantic-init-hooks 'my-semantic-hook)




(load "~/.emacs.d/python_mode_config_anne.el")
(load "~/.emacs.d/auctex_config_anne.el")
;; (load "~/.emacs.d/org_latex_config_anne.el")      

;; ------------------------------ Speedbar  
;; (require 'sr-speedbar)
;; (sr-speedbar-open)

;; (global-set-key "\C-3" 'end-of-defun)


;; ---------------------------------------- GDB

;; EMACS DESKTOP SAVE
(desktop-save-mode 1)

(setq desktop-restore-eager 2)
(get-buffer-window "*compilation*" t)
(global-auto-revert-mode 1)

;; ---------------------------------------------------------
(setq desktop-buffers-not-to-save
      (concat "\\("
	      "^nn\\.a[0-9]+\\|\\.log\\|(ftp)\\|^tags\\|^TAGS"
	      "\\|\\.emacs.*\\|\\.diary\\|\\.newsrc-dribble\\|\\.bbdb"
	      "\\)$"))
(add-to-list 'desktop-modes-not-to-save 'dired-mode)
(add-to-list 'desktop-modes-not-to-save 'Info-mode)
(add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)
(add-to-list 'desktop-modes-not-to-save 'fundamental-mode)


;; ------------------------------ Replacetrace
(defun anne-replacetrace (trnr)
  "Replace each TRACE(x,...) with TRACE(yournr,...)"
  (interactive "nNumber for trace:")
  (save-excursion
   (query-replace-regexp "TRACE\(\[0-9\]*," (concat "TRACE(" (number-to-string trnr) ","))
    )
)
;; Add a new trace to a method/function


(fset 'trace
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([18 58 58 return 134217826 67108896 19 58 58 return 19 41 134217847 5 10 84 82 65 67 69 40 44 34 25 34 41 59 18 44 return] 0 "%d")) arg)))

(global-set-key (kbd "C-x t") 'trace)

 (defun save-macro (name)                  
    "save a macro. Take a name as argument
     and save the last defined macro under 
     this name at the end of your .emacs"
     (interactive "SName of the macro :")  ; ask for the name of the macro    
     (kmacro-name-last-macro name)         ; use this name for the macro    
     (find-file user-init-file)            ; open ~/.emacs or other user init file 
     (goto-char (point-max))               ; go to the end of the .emacs
     (newline)                             ; insert a newline
     (insert-kbd-macro name)               ; copy the macro 
     (newline)                             ; insert a newline
     (switch-to-buffer nil))               ; return to the initial buffer

    ;; autoinsert C/C++ header
(define-auto-insert
  (cons "\\.\\([Hh]\\|hh\\|hpp\\)\\'" "My C / C++ header")
  '(nil
    "// " (file-name-nondirectory buffer-file-name) "\n"
    "//\n"
    "// Author: J.A. de Jong \n"
    "//\n"
    "// Description:\n"
    "//\n"
    (make-string 70 ?/) "\n"
    (let* ((noext (substring buffer-file-name 0 (match-beginning 0)))
	   (nopath (file-name-nondirectory noext))
	   (ident (concat (upcase nopath) "_H")))
      (concat "#pragma once\n#ifndef " ident "\n"
	      "#define " ident  "\n\n\n"
	      "\n\n#endif // " ident "\n"))
    (make-string 70 ?/) "\n"
    ))

;; auto insert C/C++
(define-auto-insert
  (cons "\\.\\([Cc]\\|cc\\|cpp\\)\\'" "My C++ implementation")
  '(nil
    "// " (file-name-nondirectory buffer-file-name) "\n"
    "//\n"
    "// last-edit-by: J.A. de Jong \n"
    "// \n"
    "// Description:\n"
    "//\n"
    (make-string 70 ?/) "\n\n"
    (let* ((noext (substring buffer-file-name 0 (match-beginning 0)))
	   (nopath (file-name-nondirectory noext))
	   (ident (concat nopath ".h")))
      (if (file-exists-p ident)
	  (concat "#include \"" ident "\"\n")))
    (make-string 70 ?/) "\n"
    ))
