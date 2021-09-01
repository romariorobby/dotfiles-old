;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el
; (package! elcord)
; (package! live-py-mode)
; (package! js2-mode)
(package! org-super-agenda)
(package! org-clock-convenience)
(package! command-log-mode)
;; Org-Roam
;; (package! org-roam
;;   :recipe (:host github :repo "org-roam/org-roam"))

;; Org roam ui dependencies
(package! websocket)
(package! simple-httpd)
(package! org-roam-ui :recipe (:host github :repo "org-roam/org-roam-ui" :files ("*.el" "out")))
;; (package! org-roam-bibtex
;;   :recipe (:host github :repo "org-roam/org-roam-bibtex"))

; (package! skeewer-mode
;   :recipe (:host github :repo "skeeto/skewer-mode"))
; (package! md-roam
;   :recipe (:host github :repo "nobiot/md-roam"))
