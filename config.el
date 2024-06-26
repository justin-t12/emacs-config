;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "BlexMono Nerd Font Mono" :size 16 :weight 'Medium)
      doom-variable-pitch-font (font-spec :family "BlexMono Nerd Font Propo " :size 16))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'nothing)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; (use-package! stimmung-themes
;;   :demand   t
;;   :custom
;;   (stimmung-themes-comment 'none)
;;   (stimmung-themes-type 'none :italic? t)

;; (use-package! acme-theme
;;   :ensure t
;;   :defer t
;;   :init
;;   ;; variables to configure
;;   (setq acme-theme-gray-rainbow-delimiters nil)
;;   (setq acme-theme-more-syntax-hl nil))


;; minions (reduces modes display on mode line)
(minions-mode 1)

;; (global-whitespace-mode 1)

;; Enable ccls for all c++ files, and platformio-mode only
;; when needed (platformio.ini present in project root).
;; pio project init --ide emacs --board (board name)
;; pio run -t compiledb
;; Add lines to .ccls to make sure header file are parsed as hpp/hh
;; %h -x
;; %h c++-header
(require 'platformio-mode)
(add-hook 'c++-mode-hook (lambda ()
                           (lsp-deferred)
                           (platformio-conditionally-enable)))

;;setting spell check program
;;(setq ispell-program-name "aspell")

;;setting sentence interaction behavior
(setq sentence-end-double-space nil)

;;email
;; (set-email-account! "outlook"
;;                     '((mu4e-sent-folder       . "/outlook/Sent")
;;                       (mu4e-drafts-folder     . "/outlook/Drafts")
;;                       (mu4e-trash-folder      . "/outlook/Deleted")
;;                       (mu4e-refile-folder     . "/outlook/Archive")
;;                       (user-mail-address      . "justin.t12@outlook.com")
;;                       (smtpmail-smtp-user     . "justin.t12@outlook.com")
;;                       (mu4e-compose-signature . "---\nJustin Tussey"))
;;                     t)



;; (after! mu4e
;;   (setq sendmail-program (executable-find "msmtp")
;; 	send-mail-function #'smtpmail-send-it
;; 	message-sendmail-f-is-evil t
;; 	message-sendmail-extra-arguments '("--read-envelope-from")
;; 	message-send-mail-function #'message-send-mail-with-sendmail))

;; LaTex
(setq +latex-viewers '(pdf-tools))
(map! :map cdlatex-mode-map :i "TAB" #'cdlatex-tab)

;; Lua lsp stuff
(setq lsp-lua-workspace-preload-file-size 200)

