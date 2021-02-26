;;(defun mario/org-mode-visual()
;;  (setq visual-fill-column-width 100
;;        visual-fill-column-center-text t
;;        display-fill-column-indicator nil
;;        display-line-numbers nil)
;;  (visual-fill-column-mode 1))

;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-theme 'mario-gruvbox
      doom-scratch-initial-major-mode 'org-mode
      doom-font (font-spec :family "SF Mono" :size 15)
      doom-variable-pitch-font (font-spec :family "ETbb" :size 24)
      doom-serif-font (font-spec :family "ETbb" :size 24)
      fancy-splash-image (concat doom-private-dir "splash.png")
      display-line-numbers-type nil
      evil-split-window-below t     ; Switch to            after splitting
      evil-vsplit-window-right t)
(setq-default major-mode 'org-mode)
(map! "<backtab>" #'doom/toggle-line-numbers)
(setq user-full-name "Romario"
      user-mail-address "romario@com")
;; Show battery mode if on laptop
(unless (equal "Battery Status not available"
               (battery))
  (display-battery-mode 1))
;; hide dashboard shortmenu
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
;; hide highlight line
(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode)
(if (eq initial-window-system 'x) ;; if started by emacs command or desktop file
    (toggle-frame-maximized)
  (toggle-frame-fullscreen))

(setq org-directory "~/Dropbox/org/"
      org-hide-emphasis-markers t
      org-ellipsis "  " ;; folding symbol
      ;; org-bullets-bullet-list '(" ") ;; no bullets, needs org-bullets package
      org-archive-location (concat org-directory ".archive/%s::"))

(after! org
  (require 'org-habit)
  (map! :leader
        "c" #'org-capture)
  (map! :map org-mode-map
        "M-n" #'outline-next-visible-heading
        "M-p" #'outline-previous-visible-heading)
  (custom-set-faces!
    '(org-document-title
      :weight normal
      :foreground "#fabd2f"
      :height 1.5
      :family "ETbb")
    '(org-link
      :weight normal
      :foreground "#83a598"
      :underline t
      :height 1.0)
    '(org-ellipsis
      :weight extra-bold
      :foreground "#8ec07c"
      :height 1.0)
    '(org-document-info
      :weight normal
      :foreground "#fabd2f"
      :height 1.5
      :family "ETbb")
    '(org-level-1
      :inherit outline-1
      :family "ETbb"
      :foreground "#d79921"
      :weight extra-bold
      :height 1.35)
    '(org-level-2
      :inherit outline-2
      :family "ETbb"
      :foreground "#d79921"
      :weight extra-bold
      :height 1.3)
    '(org-level-3
      :inherit outline-3
      :foreground "#d79921"
      :family "ETbb"
      :weight semi-bold
      :height 1.25)
    '(org-level-4
      :inherit outline-4
      :family "ETbb"
      :foreground "#d79921"
      :weight semi-bold
      :height 1.20)
    '(org-level-5
      :inherit outline-5
      :family "ETbb"
      :foreground "#d79921"
      :weight bold
      :height 1.15)
    '(org-level-6
      :inherit outline-6
      :family "ETbb"
      :foreground "#d79921"
      :weight bold
      :height 1.1)
    '(org-level-7
      :inherit outline-7
      :weight bold)
    '(org-level-8
      :inherit outline-8
      :weight bold
      :foreground "#ebdbb2")
    '(org-default
      :foreground "#ebdbb2")
    ;; :PROPERTIES: COLOr
    '(org-property-value
      :foreground "#b8bb26")
    ;; ensure that anything should be fixed-pitch in org buffers that way
    '(org-block nil :foreground nil :inherit 'fixed-pitch)
    ;; for meta line starting with #+
    '(org-meta-line
      :inherit font-lock-comment-face
      :foreground "#b8bb26")
    '(org-code nil :inherit '(shadow fixed-pitch))
    '(org-table nil :inherit '(shadow fixed-pitch))
    '(org-verbatim nil :inherit '(shadow fixed-pitch))
    '(org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
    '(org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
    '(org-checkbox nil :inherit 'fixed-pitch)))

(map! :leader
       "h h" #'evil-window-left
       "j j" #'evil-window-down
       "l l" #'evil-window-right
       "v" #'evil-window-vsplit
       "s s" #'evil-window-split
       "k k" #'evil-window-up)

(setq deft-directory "~/Dropbox/org/"
      deft-use-filter-string-for-filename t
      deft-default-extension "org"
      deft-recursive t)

(use-package! org-roam
  ;; :commands (org-roam-insert ))
  :hook
  (after-init . org-roam-mode)
  :init
  (map! :leader
        :prefix "n"
        :desc "org-roam" "l" #'org-roam
        :desc "org-roam-find-file" "f" #'org-roam-find-file
        :desc "org-roam-insert" "i" #'org-roam-insert
        :desc "org-roam-server-mode" "z" #'org-roam-server-mode
        :desc "org-roam-switch-to-buffer" "b" #'org-roam-switch-to-buffer
        :desc "org-roam-graph" "g" #'org-roam-graph
        :desc "org-roam-capture" "c" #'org-roam-capture
        :desc "org-roam-dailies-capture-today" "j" #'org-roam-dailies-capture-today)
  (setq org-roam-directory (file-truename "~/Dropbox/org/")
        org-roam-graph-viewer "/usr/bin/brave"
        org-roam-db-gc-threshold most-positive-fixnum
        ;; org-roam-graph-exclude-matcher "private"
        org-roam-tag '(prop last-directory)
        org-id-link-to-org-use-id t)
  :config
  (setq org-roam-dailies-directory "private/")
  (setq org-roam-capture-templates
        '(("d" "default" plain (function org-roam-capture--get-point)
           "%?"
           :file-name "${slug}"
           :head "#+TITLE: ${title}
#+title: ${title}\n"
           :immediate-finish t
           :unnarrowed t)
          ("p" "private" plain (function org-roam-capture--get-point)
           "%?"
           :file-name "private/${slug}"
           :head "#+TITLE: ${title}
#+title: ${title}\n"
           :immediate-finish t
           :unnarrowed t)))
  (setq org-roam-capture-ref-templates
        '(("r" "ref" plain (function org-roam-capture--get-point)
           "%?"
           :file-name "resonance/${slug}"
           :head "#+TITLE:${title}
#+title: ${title}
#+roam_key: ${ref}
#+roam_tags: bpmcinbox

- source :: ${ref}
- tags :: [[file:../../org/bpmc.org][BPMC]]"
           :unnarrowed t)))
  (setq org-roam-dailies-capture-templates
        '(("d" "daily" plain (function org-roam-capture--get-point)
           ""
           :file-name "private/%<%Y-%m-%d>"
           :head "#+TITLE: %<%A, %d %B %Y>
- [ ]
- [ ]
- [ ]\n* Time Tracking\n"
           :immediate-finish t)))
  (set-company-backend! 'org-mode '(company-capf)))

(use-package! org-roam-protocol
  :after org-protocol)

;; (setq elcord-display-buffer-details nil)
;; (elcord-mode t)

(after! org-journal
  (setq org-journal-date-prefix "#+TITLE: "
        org-journal-file-format "%Y-%m-%d.org"
        org-journal-time-format "%I:%M%p"
        org-journal-date-format "%A, %d %B %Y"
        org-journal-dir  "~/Dropbox/org/private/"
        org-journal-enable-agenda-integration t))
