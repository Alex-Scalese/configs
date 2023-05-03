(setq user-mail-address "mail@alex-scalese.de")
(setq user-full-name "Alexandro Scalese")

(setq inhibit-startup-message t) ; set up blank start up screen

(scroll-bar-mode -1)  ; disable visible scrollbar

(tool-bar-mode -1) ; disable toolbar

(tooltip-mode -1)  ; disable tooltips

(set-fringe-mode 6)  ; space left and right

(menu-bar-mode -1)  ; disable the menu bar

(show-paren-mode 1) ; matching parenthese, braces, etc

(global-display-line-numbers-mode t) ; show line numbers

(setq auto-save-default nil) ; no auto save files

(setq create-lockfiles nil) ; no lock files

(setq make-backup-files nil) ; no backup files

(setq tab-width 4) ; Indent 4 spaces by default

(setq visible-bell t)  ; set up visible feedback

(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font" :height 110)

;; Custom key bindings

(global-set-key (kbd "<escape>") 'keyboard-escape-quit) ; make ESC quit prompts

(global-set-key (kbd "C-c C-c") 'kill-ring-save) ; additional copy option

(global-set-key (kbd "C-c C-v") 'yank) ; additional past option

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Installed packaes

(require 'use-package)
(setq use-package-always-ensure t)

(use-package evil
  :ensure t
  :config
  (evil-mode)
  (evil-set-undo-system 'undo-redo))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package powerline
  :ensure t
  :config
  (require 'powerline)
  (powerline-center-evil-theme))

(use-package git-gutter
  :ensure t
  :init
  (global-git-gutter-mode +1))

(use-package git-gutter-fringe
  :ensure t)

(use-package flycheck
  :ensure t)

(use-package rainbow-mode
  :ensure t)

(use-package vertico
  :ensure t
  :config
  (vertico-mode))

(use-package marginalia
  :ensure t
  :config 
  (marginalia-mode))

(use-package helm
  :ensure t
  :config
  (helm-mode 1))

(use-package treemacs
   :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package winum
  :ensure t
  :config
  (global-set-key (kbd "M-0") 'treemacs-select-window)
  (global-set-key (kbd "M-1") 'winum-select-window-1)
  (global-set-key (kbd "M-2") 'winum-select-window-2)
  (global-set-key (kbd "M-3") 'winum-select-window-3)
  (global-set-key (kbd "M-4") 'winum-select-window-4)
  (global-set-key (kbd "M-5") 'winum-select-window-5)
  (global-set-key (kbd "M-6") 'winum-select-window-6)
  (global-set-key (kbd "M-7") 'winum-select-window-7)
  (global-set-key (kbd "M-8") 'winum-select-window-8)
  (winum-mode))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless)))

(use-package projectile
  :diminish projectile-mode
  :config
  (projectile-mode)
  :custom
  ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (setq projectile-project-search-path '("~/projects/" "~/devel/golang")))

(use-package yaml-mode
  :ensure t
  :config
  (require 'yaml-mode)
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))

(use-package smartparens
  :ensure t
  :config
  (require 'smartparens-config))

(use-package undo-tree
  :ensure t
  :init (global-undo-tree-mode))

(use-package command-log-mode)

(use-package ivy
  :ensure t
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)	
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))


(use-package magit
  :commands (magit-status magit-get-current-branch))

;; (use-package nord-theme)

;; (use-package dracula-theme)

;; (use-package ayu-theme

;; (use-package gruvbox-theme)

(use-package cyberpunk-theme
  :ensure t
  :config
  (load-theme 'cyberpunk t))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package lsp-mode
  :ensure t
  :bind (:map lsp-mode-map
		 ("C-c d" . 'lsp-describe-thing-at-point)
		 ("C-c a" . 'lsp-execute-code-action))
  :config
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
  (lsp-enable-which-key-integration t))
 
(use-package company
  :ensure t
  :hook ((emacs-lisp-mode . (lambda ()
			      (setq-local company-backends '(company-elisp))))
	 (emacs-lisp-mode . company-mode))
  :config
  (company-keymap--unbind-quick-access company-active-map)
  (company-tng-configure-default)
  (setq company-idle-delay 0.1
	company-minimum-prefix-length 1))

;; Golang setup

(use-package go-mode
  :ensure t
  :hook ((go-mode . lsp-deferred)
	 (go-mode . company-mode))
  :bind (:map go-mode-map
	      ("<f6>" . gofmt))
  :config
  (require 'lsp-go)
  (setq lsp-go-analyses
	'((fieldaligment . t)
	  (nilness . t)
	  (unusedwrite . t)
	  (unusedparams . t)))
  (add-to-list 'exec-path "~/go/bin")
  (setq gofmt-command "goimports"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(yaml-mode yasnippet winum which-key visual-fill-column vertico use-package undo-tree treemacs-projectile treemacs-magit treemacs-icons-dired swiper rainbow-mode powerline org-bullets orderless nord-theme marginalia lsp-ui helm gruvbox-theme god-mode go-mode git-gutter-fringe flycheck evil-surround evil-smartparens evil-collection dracula-theme cyberpunk-theme company command-log-mode ayu-theme all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
