---------------------------------------- Org Latex
(require 'org-mode)
(require 'ox-latex)

(add-to-list 'org-latex-classes
  '("djcb-org-article"
"\\documentclass[11pt,a4paper]{article}
\\usepackage[T1]{fontenc}
\\usepackage{fontspec}
\\usepackage{graphicx} 
\\defaultfontfeatures{Mapping=tex-text}
%\\setromanfont{Gentium}
%\\setromanfont [BoldFont={Gentium Basic Bold},
%                ItalicFont={Gentium Basic Italic}]{Gentium Basic}
%\\setsansfont{Charis SIL}
\\setmonofont[Scale=0.8]{DejaVu Sans Mono}
\\usepackage{geometry}
\\geometry{a4paper, textwidth=6.5in, textheight=10in,
            marginparsep=7pt, marginparwidth=.6in}
\\pagestyle{empty}
\\title{}
      [NO-DEFAULT-PACKAGES]
      [NO-PACKAGES]"
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
     )
  )

(setq org-latex-to-pdf-process 
  '("xelatex -interaction nonstopmode %f"
    "xelatex -interaction nonstopmode %f")) ;; for multiple passes

;; Tramp customization
;; Guard to ensure that TRAMP is available
(add-to-list 'load-path "~/.emacs.d/tramp/lisp/")
;; for Emacs
(add-to-list 'Info-default-directory-list "~/.emacs.d/tramp/info/")
;; for XEmacs
(add-to-list 'Info-directory-list "~/.emacs.d/tramp/info/")
(require 'tramp)
 (add-to-list 'tramp-default-proxies-alist
                   '(nil "\\`root\\'" "/ssh:%h:"))
      (add-to-list 'tramp-default-proxies-alist
                   '((regexp-quote (system-name)) nil nil))

(eval-after-load "rst" '(define-key rst-mode-map (kbd "C-c m") ":math:``\C-b"))
(eval-after-load "python" '(define-key python-mode-map (kbd "C-c m") ":math:``\C-b"))



-------------------------------- org2blog
(add-to-list 'load-path "/home/anne/.emacs.d/metaweblog")
(add-to-list 'load-path "/home/anne/.emacs.d/org2blog")
;; (require 'metaweblog)
(require 'org2blog-autoloads)
(setq org2blog/wp-blog-alist
      '(("wordpress"
	 :url "http://anne.amdj.nl/xmlrpc.php"
	 :username "anne"
	 :password "i@$rs%3vquoZ4@kz4$kl"
	 :default-title "Hello World"
	 :default-categories ("org2blog" "emacs")
	 :tags-as-categories nil)
	)
      )
(setq user-full-name "J.A. de Jong")

(setq org-export-html-style-extra
"<style type=\"text/css\">
 <!--/*--><![CDATA[/*><!--*/
  html { font-family: Times, serif; font-size: 12pt; }
  .title  { text-align: center; }
  .todo   { color: red; }
  .done   { color: green; }
  .tag    { background-color: #add8e6; font-weight:normal }
  .target { }
  .timestamp { color: blue; }
  .timestamp-kwd { color: #5f9ea0; }
  p.verse { margin-left: 3% }
  pre {
	border: 1pt solid #AEBDCC;
	background-color: #F3F5F7;
	padding: 5pt;
	font-family: courier, monospace;
        font-size: 90%;
        overflow:auto;
  }
  table { border-collapse: collapse; }
  td, th { vertical-align: top; }
  dt { font-weight: bold; }
  div.figure { padding: 0.5em; }
  div.figure p { text-align: center; }
  textarea { overflow-x: auto; }
  .linenr { font-size:smaller }
  .code-highlighted {background-color:#ffff00;}
  .org-info-js_info-navigation { border-style:none; }
  #org-info-js_console-label { font-size:10px; font-weight:bold;
                               white-space:nowrap; }
  .org-info-js_search-highlight {background-color:#ffff00; color:#000000;
                                 font-weight:bold; }
  /*]]>*/-->
</style>"
)
