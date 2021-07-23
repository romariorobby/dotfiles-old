(setq-default major-mode 'org-mode) ;; default major mode org-mode
(setq inhibit-startup-message t)
(scroll-bar-mode -1) ;; Disable Visual Scrolbar
(tool-bar-mode -1) ;; Disable toolbar
(tooltip-mode -1) ;; Disable tooltips
(menu-bar-mode -1) ;; Disable Menubar
(column-number-mode)
(global-display-line-numbers-mode t) ;; Line number
(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda() (display-line-numbers-mode 0))))
(setq scroll-conservatively 101) ;; value greater than 100 gets rid of half page jumping
(setq mouse-wheel-scroll-amount '(3 ((shift) . 3))) ;; how many lines at a time
(setq mouse-wheel-progressive-speed t) ;; accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
   (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)
;; Make esc quit prompt
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Variables Directory
(setq mario/org-agenda-dir (file-truename "~/documents")
      mario/org-dir (file-truename "~/documents")
      mario/org-journal-dir (file-truename "~/documents")
      mario/org-roam-dir (file-truename "~/documents"))

(add-to-list 'custom-theme-load-path "~/.config/emacs/themes")
(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  :init (load-theme 'mario-gruvbox t)
  ;;(load-theme 'doom-one t)
 ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font Mono" :height 100)

(use-package undo-tree)
(use-package general
  :config
  (general-evil-setup t)
  (general-create-definer leader
    ;; operator,motion,replace,global
    :keymaps '(normal visual emacs)
    :prefix "SPC")
  (general-create-definer localleader
    :keymaps '(normal insert visual emacs)
    :prefix "C-SPC"))

(leader
  ";"     '(eval-expression :which-key "Eval Expression")
  "C-u"   '(universal-argument :which-key "C-u (Universal Arg)")
  "SPC"   '(counsel-M-x :which-key "M-x")
  "h"     '(evil-window-left :which-key "Window Left")
  "j"     '(evil-window-down :which-key "Window down")
  "k"     '(evil-window-up :which-key "Window up")
  "l"     '(evil-window-right :which-key "Window right")
  "s"     '(evil-window-split :which-key "Split")
  "v"     '(evil-window-vsplit :which-key "Vertical Split")
  "H r"   '((lambda() (interactive) (load-file "~/.config/emacs/init.el")) :which-key "Reload Config")
  "b"     '(:ignore t :which-key "Buffer")
  "b b"   '(ivy-switch-buffer :which-key "Ivy Buffer")
  "b B"   '(ibuffer :which-key "Ibuffer")
  "b d"   '(kill-current-buffer :which-key "Kill current Buffer")
  "b h"   '(previous-buffer :which-key "Previous Buffer")
  "b l"   '(next-buffer :which-key "Next Buffer")
  "b c"   '(kill-current-buffer :which-key "Kill current Buffer")
  "B"     '(:ignore t :which-key "Bookmark")
  "B l"   '(bookmark-jump :which-key "Jump to bookmark")
  "B RET" '(bookmark-jump :which-key "Jump to bookmark")
  "B d"   '(bookmark-delete :which-key "Delete Bookmark")
  "B a"   '(bookmark-set :which-key "Set Bookmark")
  ;; Code 
  "c"     '(:ignore t :which-key "Code")
  "c e"   '(eval-last-sexp :which-key "evaluate lisp") ;; TODO: Move to Spesific Lisp mode
  "t k"   '(clm/toggle-command-log-buffer :which-key "Toggle Key log")
;; (nvmap :states '(normal visual) :keymaps 'override :prefix "SPC"
  "//"    '(evilnc-comment-or-uncomment-lines :which-key "Toggle Comment")
  "."     '(find-file :which-key "Find file")
  ;;
  "f"     '(:ignore t :which-key "Files")
  "f f"   '(find-file :which-key "Find file")
  "f r"   '(counsel-recentf :which-key "Recent files")
  "f s"   '(save-buffer :which-key "Save file")
  "f u"   '(sudo-edit-find-file :which-key "Sudo find file")
  "f y"   '(dt/show-and-copy-buffer-path :which-key "Yank file path")
  "f C"   '(copy-file :which-key "Copy file")
  "f D"   '(delete-file :which-key "Delete file")
  "f R"   '(rename-file :which-key "Rename file")
  "f S"   '(write-file :which-key "Save file as...")
  "f U"   '(sudo-edit :which-key "Sudo edit file")
  "f e"   '(find-file "~/.config/doom/config.org" :which-key "Edit emacs config")
  ;; TODO: Load only orgmode
  "n"     '(:ignore t :which-key "Notes")
  "n a"   '(org-agenda :which-key "Org Agenda")
  "n f"   '(org-roam-node-find :which-key "Roam Find")
  "n l"   '(org-roam-buffer-toggle :which-key "Roam Buffer")
  "n c"   '(org-roam-capture :which-key "Roam Capture")
  "n j"   '(org-roam-dailies-capture-today :which-key "Roam Capture")
  "p"    '(:ignore t :which-key "Project")
  "p a"    '(projectile-add-known-project :which-key "Add Proj")
  "p s"    '(projectile-switch-project :which-key "Switch Proj")
  "p c"    '(projectile-kill-buffers :which-key "Kill Proj Buf")
  "p f"    '(projectile-find-file :which-key "Proj Find File"))

  (use-package evil
   :init
   (setq evil-want-integration t)
   (setq evil-want-C-u-scroll t) ;; default C-u is Universal Argument change to scroll
   (setq evil-want-keybinding nil)
   (setq evil-vsplit-window-right t)
   (setq evil-split-window-below t)
   :config
   (evil-mode))
  (use-package evil-collection
   :after evil
   :config
   (evil-collection-init))

(use-package command-log-mode)

(use-package ivy
  :diminish
  :init
  (setq ivy-initial-inputs-alist nil) ;; Remove ^ when pressed SPC-SPC
  :bind (("C-/" . swiper)
	 :map ivy-minibuffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-j" . ivy-next-line)
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package all-the-icons) ;; requirement
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package counsel)
(use-package which-key
 :init (which-key-mode)
 :config
 (which-key-setup-side-window-bottom)
 (setq which-key-idle-delay 0.2
;;       which-key-sort-order #'which-key-key-order-alpha ;; sort alphabetically
       which-key-add-column-padding 2
       which-key-max-display-columns nil
       which-key-min-display-lines 6))

;; GENERATING CONIFG
(defun mario/generate-config()
 "Generate README.org"
        (interactive)
    (evil-split-buffer (generate-new-buffer "Untitled"))
    (find-file "~/.config/emacs/config.org")
    (save-buffer)
    (evil-goto-first-line)
    (re-search-forward "+PROPERTY:")
    (org-ctrl-c-ctrl-c)
    (org-babel-tangle)
    (find-file "~/.config/emacs/init.el"))

(use-package dashboard
  :init      ;; tweak dashboard config before loading it
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
  (setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 3)
                          (projects . 3)
                          (registers . 3)))
  :config
  (dashboard-setup-startup-hook)
  (dashboard-modify-heading-icons '((recents . "file-text")
			      (bookmarks . "book"))))

(use-package all-the-icons-dired
    :hook (dired-mode . all-the-icons-dired-mode))
  (use-package dired
     :ensure nil
     :commands (dired dired-jump)
     :bind (("C-x C-j" . dired-jump))
     :custom ((dired-listing-switches "-agho --group-directories-first"))
     :config
     (evil-collection-define-key 'normal 'dired-mode-map
       "h" 'dired-single-up-directory
       "l" 'dired-single-buffer))
  (use-package dired-single
    :commands (dired dired-jump))

(setq org-directory mario/org-dir)
(setq org-src-preserve-indentation nil
      org-src-tab-acts-natively t
      org-edit-src-content-indentation 0)

(use-package org-roam
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory mario/org-roam-dir)
  :config
  (org-roam-setup)
  (define-key evil-normal-state-map (kbd "TAB") 'next-buffer)
  (define-key evil-normal-state-map (kbd "<backtab>") 'previous-buffer)

;;  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
;;  (evil-global-set-key 'motion "k" 'evil-next-visual-line)
;;  (evil-global-set-key 'motion "j" 'evil-previous-visual-line)
  (evil-set-initial-state 'message-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state))

(use-package org-tempo
  :ensure nil)

(use-package projectile
  :config
  (projectile-global-mode 1))

(use-package nav-flash)
(nav-flash-show)

;; rainbow-delimeter
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))
(use-package helpful 
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))
(use-package evil-nerd-commenter)
(evilnc-default-hotkeys)

(use-package projectile
  :config (projectile-mode)
  :init
  (when (file-directory-p "~/code/")
    (setq projectile-project-search-path '("~/code/")))
  (setq projectile-swith-project-action #'projectile-dired))

;; Magit
(use-package magit)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(evil-magit which-key use-package undo-tree rainbow-delimiters projectile org-roam nav-flash magit ivy-rich helpful general evil-nerd-commenter evil-collection doom-themes doom-modeline dired-single dashboard counsel command-log-mode all-the-icons-dired)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
