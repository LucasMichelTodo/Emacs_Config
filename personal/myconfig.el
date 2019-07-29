;; GLOBAL

;; Agenda
;; The following lines are always needed.  Choose your own keys.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)

;; ESS CONFIG

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)  ;load and activate packages, including auto-complete
(ac-config-default)
;;if not working, use the following instead of (setq ess-use-auto-complete 'script-only)
(global-auto-complete-mode t)(setq ess-use-auto-complete t)

;; Fxing the fact that pathnames do not autocomplete.
(require 'auto-complete-config)
(ac-config-default)
(define-key ac-completing-map (kbd "M-h") 'ac-quick-help)
;; Get tab completion in R script files
;; See this page here
;; https://stat.ethz.ch/pipermail/ess-help/2013-March/008719.html
;; Make sure that this is after the auto-complete package initialization
(setq  ess-tab-complete-in-script t)

;; Make underscore behave normally
(setq ess-toggle-underscore nil)


;; ORG MODE CONFIG

(add-hook 'org-mode-hook 'org-indent-mode)
(setq ess-eval-visibly-p nil)
(require 'ob-async)
(require 'package)
(require 'ob-ipython)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(require 'org-tempo)
(require 'ess-site)
(add-to-list 'org-src-lang-modes '("dot" . "graphviz-dot"))
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (emacs-lisp . t)
   (org . t)
   (shell . t)
   (C . t)
   (python . t)
   (ipython . t)
   (gnuplot . t)
   (octave . t)
   (R . t)
   (dot . t)
   (awk . t)
   ))

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
(setq org-export-babel-evaluate nil)
(setq org-confirm-babel-evaluate nil)
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

;; ADD LINENUMBERS

(global-linum-mode t)
(set-face-foreground 'linum "gainsboro")

;; PYTHON IDE
;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    ein
    elpy
    flycheck
    material-theme
    py-autopep8))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)


;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")

(add-to-list 'company-backends 'company-ob-ipython)

;; CONFIGURE WINDMOVE ;;

(windmove-default-keybindings 'super)

;; HELM
;;------------------

(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)


;; Parenthesis Pairing
;;-------------------

(require 'smartparens-config)
(add-hook 'python-mode-hook #'smartparens-mode)
(add-hook 'R-mode-hook #'smartparens-mode)
