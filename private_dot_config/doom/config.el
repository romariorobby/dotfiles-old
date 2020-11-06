;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(load! "org-gtd.el")

(defun find-in-dotfiles ()
  "Open a file somewhere in ~/.dotfiles via a fuzzy filename search."
  (interactive)
  (doom-project-find-file (expand-file-name "~/.config/")))

(defun browse-dotfiles () "Browse the files in ~/.dotfiles."
  (interactive)
  (doom-project-browse (expand-file-name "~/.config/")))

(defun mario/projects ()
  "Goto my projects"
  (interactive)
  (find-file "~/Dropbox/org/gtd/projects.org")
  (widen)
  (beginning-of-buffer)
  (re-search-forward "* 1.PROJECTS")
  (org-sort-entries t ?o)
  (beginning-of-line))

(defun mario/project-deadline ()
  "Project Deadline."
  (interactive)
  (mario/projects)
  (org-narrow-to-subtree)
  (org-sort-entries t ?d)
  (org-sort-entries t ?o)
  (org-columns))
(defun mario/project-deadline ()
  "Project Deadline."
  (interactive)
  (mario/projects)
  (org-narrow-to-subtree)
  (org-sort-entries t ?d)
  (org-sort-entries t ?o)
  (org-columns))

; Func auto create new file project
(defun mario/project-todos-new-file ()
  "Crate new file for project todos"
  (interactive)
  (let ((name (read-string "Filename: ")))
    (expand-file-name (format "P_%s.org"
                              name) "~/Dropbox/org/gtd/projects/")))
;; USER CONFIGURATION
(setq user-full-name "Romario"
      user-mail-address "me@romariorobby")

;(use-package org-gtd
;  :config

;  (setq org-gtd-directory '"~/Dropbox/org/gtd/")
;  (setq org-projects-folder '"~/Dropbox/org/projtodos.org")
;  (setq org-gtd-task-files '("someday.org" "next.org" "recurringtask.org" "waiting.org" "personal.org"))
;  (setq org-gtd-refile-properties '("CATEGORY")))

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-theme 'my-doom-gruvbox
      doom-scratch-initial-major-mode 'lisp-interaction-mode
      doom-font (font-spec :family "Iosevka" :size 15)
      doom-variable-pitch-font (font-spec :family "Libre Baskerville")
      doom-serif-font (font-spec :family "Libre Baskerville")
      fancy-splash-image (concat doom-private-dir "splash.png")
      display-line-numbers-type nil
      evil-split-window-below t     ; Switch to            after splitting
      evil-vsplit-window-right t)   ;           new window
(map! "<backtab>" #'doom/toggle-line-numbers)
;; remove dashboard shortmenu
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

;=================
;REMAP SOME BINDING KEY
;=============
;(map! :leader
;      :nv "x" nil

;(map! :leader
      ;(:prefix-map ("B" . "buffer"))
      ;(:prefix-map ("C" . "code"))
      ;(:prefix-map ("I" . "insert"))
      ;(:prefix-map ("F" . "file"))
      ;(:prefix-map ("G" . "git"))
      ;(:prefix-map ("P" . "project")))
      ;(:prefix-map ("O" . "open"))
      ;(:prefix-map ("S" . "search"))
      ;(:prefix-map ("R" . "prefix"))
      ;(:remote-map ("T" . "toggle"))
      ;(:prefix-map ("Q" . "quit/session")))
(map! "M-h" help-map
      (:prefix-map ("M-c" . "code"))
      (:prefix-map ("M-i" . "insert"))
      (:prefix-map ("M-p" . "project")))
;;;
(defun mario/copy-idlink-to-clipboard()
       (interactive)
       (when (eq major-mode 'org-agenda-mode) ;switch to orgmode
     (org-agenda-show)
     (org-agenda-goto))
       (when (eq major-mode 'org-mode) ; do this only in org-mode buffers
     (setq mytmphead (nth 4 (org-heading-components)))
         (setq mytmpid (funcall 'org-id-get-create))
     (setq mytmplink (format "[[id:%s][%s]]" mytmpid mytmphead))
     (kill-new mytmplink)
     (message "Copied %s to killring (clipboard)" mytmplink)))

(map! :leader
       "h" #'evil-window-left
       "j" #'evil-window-down
       "l" #'evil-window-right
       "k" #'evil-window-up
       "v" #'evil-window-vsplit
       "s" #'evil-window-split
;       "c" #'evil-window-delete
       "d" #'evil-window-delete
       "=" #'balance-windows
       "/" #'evil-window-set-width
       "w e" #'evil-save-and-close
       "w w" #'evil-write
       "\\" #'+vterm/toggle
       "f T" #'browse-dotfiles
       "f ." #'browse-dotfiless
       "f t" #'find-in-dotfiles
;       "R" #'doom/restart
;       "r" #'doom/restart-and-restore)
;      (:prefix ("TAB" . "workspace")
;;        :desc "Workspace move left" "h" #'+workspace/switch-left
;        :desc "Workspace move right" "l" #'+workspace/switch-right
;        :desc "Delete current workspace" "q" #'+workspace/delete
;        :desc "Open/load workspace from file" "o" #'+workspace/load)
      (:prefix ("y" . "yank/copy")
        :desc "org-store-link" "o" #'org-store-link
        :desc "copy-id-from-agenda" "a" #'mario/copy-idlink-to-clipboard ))

;(map! "M-g" #'+workspace/switch-left
;      "M-;" #'+workspace/switch-right)

;(map! "C-g" #'+workspace/switch-left
      ;"C-;" #'+workspace/switch-right)
(map! "C-l" #'evil-window-increase-width
      "C-h" #'evil-window-decrease-width
      "C-k" #'evil-window-increase-height
      "C-j" #'evil-window-decrease-height)


; ORG
(setq org-directory "~/Dropbox/org/"
      org-archive-location (concat org-directory ".archive/%s::")
      org-ellipsis " ▼ ")
(after! org
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "HOLD(h)" "|" "DONE(d)" "KILL(k)")))
  (setq org-todo-keyword-faces
        '(("TODO" :foreground "#fb4934" :weight normal)
          ("PROJ" :foreground "#00ffff" :weight normal :italic t)
          ("DONE" :foreground "#404040" :weight normal :strike-through t))))
; MD-ROAM (suppot md for org-roam)
(use-package! md-roam
  :config
  (setq md-roam-file-extension-single "md")
  (setq md-roam-use-markdown-file-links t ))
; ORG ROAM
(use-package! org-roam
  :commands (org-roam-insert org-roam-find-file org-roam-switch-to-buffer org-roam)
  :hook
  (after-init . org-roam-mode)
  :init
  (map! :leader
        :prefix "n"
        :desc "org store link" "L" #'org-store-link
        :desc "Find File in Notes" "F" #'+default/find-in-notes
        :desc "Toggle last org-clock" "O" #'+org/toggle-last-clock
        :desc "Find Notes" "f" #'org-roam-find-file
        :desc "Roam Capture" "c" #'org-roam-capture
        :desc "Org Capture" "C" #'org-capture
        :desc "Buffer Notes" "b" #'org-roam-switch-to-buffer
        :desc "Linked Reference" "r" #'org-roam
        :desc "Unlinked Reference" "u" #'org-roam-unlinked-references
        :desc "Show Graph" "g" #'org-roam-show-graph
        :desc "Random Notes" "z" #'org-roam-random-note
        :desc "Insert" "i" #'org-roam-insert
        :desc "Insert Immediate" "I" #'org-roam-insert-immediate
        :desc "Date Picker" "k" #'org-roam-dailies-date
        :desc "Today" "j" #'org-roam-dailies-today
        :desc "Yesterday" "h" #'org-roam-dailies-yesterday
        :desc "Tomorrow" "l" #'org-roam-dailies-tomorrow
        (:prefix (";" . "journal")
         :desc "New Entry" "j" #'org-journal-new-entry
         :desc "Previous Entry" "h" #'org-journal-previous-entry
         :desc "Next Entry" "l" #'org-journal-next-entry))
  (setq org-roam-directory (file-truename "~/Dropbox/org/")
        org-roam-db-location "~/org-roam.db"
; FIXME UPDATE 1.2.2 enable this!
;        org-roam-dailies-directory "private/"
        org-roam-graph-viewer "/usr/bin/brave"
        org-roam-tag-sources '(prop last-directory)
        org-roam-tag-sources '(prop md-frontmatter)
        org-id-link-to-org-use-id t)
  :config
  (setq org-roam-file-extensions '("org" "md"))
  (setq org-roam-dailies-capture-templates '(("d" "daily" plain (function org-roam-capture--get-point) ""
                                            :immediate-finish t
                                            :file-name "private/%<%Y-%m-%d>"
                                            :head "#+TITLE: %<%A, %d %B %Y>
- [ ]
- [ ]
- [ ]
* Time Tracking ")))
  (setq org-roam-capture-ref-templates
        '(("r" "ref" plain (function org-roam-capture--get-point)
           "%?"
           :file-name "resonance/${slug}"
           :head "#+TITLE:${title}
#+roam_key: ${ref}
#+roam_tags: bpmcinbox
#+title: ${title}

- source :: ${ref}
- tags :: [[file:../../org/bpmc.org][BPMC]]"
           :unnarrowed t)))
  (set-company-backend! 'org-mode '(company-capf)))

(use-package! org-roam-protocol
  :after org-protocol)

; DEFT
; FIXME idk what i commenting this !
(setq deft-directory "~/Dropbox/org/"
      deft-use-filter-string-for-filename t
      deft-default-extension "org"
      deft-recursive t)

; ORG AGENDA
; automatically change to next state when clock-in
;(defun mario/set-todo-state-next()
;  (org-todo "NEXT"))
;(add-hook 'org-clock-in-hook 'mario/set-todo-state-next 'append)
;(setq org-gtd-directory "~/Dropbox/org/gtd/")

(after! org
  (require 'find-lisp)
  (setq mario/org-agenda-directory (file-truename "~/Dropbox/org/gtd/"))
  (setq org-agenda-files ;(append (file-expand-wildcards (concat org-gtd-folder "*.org")))))
        (find-lisp-find-files mario/org-agenda-directory "\.org$")))

(org-super-agenda-mode t)
(use-package! org-agenda
  :init
  (require 'evil-org-agenda)
  (map! "<f1>" #'mario/switch-to-agenda)
  (setq org-agenda-block-separator nil
        org-agenda-start-with-log-mode t)
  (defun mario/switch-to-agenda ()
    (interactive)
    (org-agenda nil " "))
  :config
  (setq org-super-agenda-header-map (copy-keymap evil-org-agenda-mode-map)
        org-agenda-custom-commands `((" " "Agenda"
                                      ((agenda ""
                                               ((org-agenda-span 'week)
                                                (org-deadline-warning-days 365)))
                                       (todo "TODO"
                                             ((org-agenda-overriding-header "Weekly Goal")
                                              (org-agenda-files '(,(concat mario/org-agenda-directory "north.org")
                                                                  ,(concat mario/org-agenda-directory "northstar.org")))
                                              (org-super-agenda-groups
                                              '((:auto-parent t)))))
                                       (todo "TODO"
                                             ((org-agenda-overriding-header "To Refile")
                                              (org-agenda-files '(,(concat mario/org-agenda-directory "inbox.org")))))
                                       (todo "NEXT"
                                             ((org-agenda-overriding-header "In Progress ")
                                              (org-agenda-files  (append (file-expand-wildcards (concat mario/org-agenda-directory "/projects/*.org"))
                                                                         (file-expand-wildcards (concat mario/org-agenda-directory "north.org"))
                                                                         (file-expand-wildcards (concat mario/org-agenda-directory "next.org"))))
                                              (org-super-agenda-groups
                                               '((:auto-parent t)))))
;              (todo "TODO"
;                    ((org-agenda-overriding-header "PROJECT TASK")
;                     (org-agenda-skip-function #'jethro/skip-projects)
;                     (org-agenda-files (append (file-expand-wildcards (concat mario/org-agenda-directory "/projects/*.org"))))
;                     (org-super-agenda-groups
;                      '((:auto-category t)))))
;                                      (todo "TODO"
;                                            ((org-agenda-overriding-header "PROJECT TODO")
;                                             (org-agenda-files '(,(concat mario/org-agenda-directory "projtodos.org")))
;                                             (org-super-agenda-groups
;                                              '((:auto-parent t)))))
                                       (todo "TODO"
                                             ((org-agenda-overriding-header "PROJECTS TODO")
                                              (org-agenda-files (append (file-expand-wildcards (concat mario/org-agenda-directory "projects/*.org"))))
                                              (org-super-agenda-groups
                                               '((:auto-parent t)))))
;                                       (todo "TODO"
;                                             ((org-agenda-overriding-header "Waiting")
;                                              (org-agenda-files '(,(concat mario/org-agenda-directory "waiting.org")))
;                                              (org-super-agenda-groups
;                                               '((:auto-parent t)))))
                                       (todo "TODO"
                                             ((org-agenda-overriding-header "ONE-OFF TASKS")
                                              (org-agenda-files '(,(concat mario/org-agenda-directory "next.org")))))))
                                     ("n" "NORTH STAR"
                                      ((todo '("STM" "PROJ")
                                             ((org-agenda-overriding-header "NORTH STAR")
                                              (org-agenda-files '(,(concat mario/org-agenda-directory "north.org")
                                                                  ,(concat mario/org-agenda-directory "projects.org")))
                                              (org-super-agenda-groups
                                               '((:auto-parent t))))))))))
;            ("p" "PROJECT STAR"
;            ((todo "PROJ"
;                   ((org-agenda-overriding-header "PROJECT STAR")
;                    (org-agenda-file (list (concat mario/org-agenda-directory "projects.org")))
;                    (org-super-agenda-groups
;                     '((:auto-parent t))))))))))

;; ORG CAPTURE
(setq org-capture-templates
      `(("i" "inbox" entry (file ,(concat mario/org-agenda-directory "inbox.org"))
         "* TODO %?")
        ("c" "org-protocol-capture" entry (file ,(concat mario/org-agenda-directory "inbox.org"))
         "* TODO [[%:link][%:description]]\n\n %i"
         :immediate-finish t)
        ("p" "New Project" entry (file ,(concat mario/org-agenda-directory "projects.org"))
         "* PROJ %?\n CREATED: %T")
        ("P" "New Project TODOs" entry (file mario/project-todos-new-file)
         (file , "~/Dropbox/org/templates/newprojtodos_template.org"))
        ("h" "Habit Entry" entry (file+olp+datetree ,(concat mario/org-agenda-directory "habit.org"))
         (file , "~/Dropbox/org/templates/habittracker_template.org") :immediate-finish t)
        ("w" "Weekly Template" entry (file+olp+datetree ,"~/Dropbox/org/private/weekly.org")
         (file , "~/Dropbox/org/templates/weeklyreview_template.org"))))

(defun mario/org-inbox-capture ()
  (interactive)
  (org-capture nil "i"))

(map! :map evil-org-agenda-mode-map
      "c i" #'org-agenda-clock-in
      "c o" #'org-agenda-clock-out
      :desc "clock conve fill gap both" "c n" #'org-clock-convenience-fill-gap-both
      :desc "clock conve fill gap" "c v" #'org-clock-convenience-fill-gap
      (:leader
       :map evil-org-agenda-mode-map
       :prefix "m"
       "r" #'org-agenda-refile
       :desc "Quick Inbox" "c" #'mario/org-inbox-capture))

;; FIXME fillgap and fill-gap-both doesn't work
(use-package! org-clock-convenience
  :bind (:map evil-org-agenda-mode-map
         ("<S-up>" . org-clock-convenience-timestamp-up)
         ("<S-down>" . org-clock-convenience-timestamp-down)
         ("o" . org-clock-convenience-fill-gap)
         ("e" . org-clock-convenience-fill-gap-both)))

; Elcord
(setq elcord-display-buffer-details nil)
(elcord-mode t)

(after! org-journal
  (setq org-journal-date-prefix "#+TITLE: "
        org-journal-file-format "%Y-%m-%d.org"
        org-journal-time-format "%I:%M%p"
        org-journal-date-format "%A, %d %B %Y"
        org-journal-dir  "~/Dropbox/org/private/"
        org-journal-enable-agenda-integration t))

(use-package! ledger-mode
  :mode "\\.dat\\'")
