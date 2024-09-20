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
;; (setq org-directory "/mnt/c/Users/apoll/Sync/")
(setq org-directory "~/Sync/")


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

(setq evil-snipe-scope 'visible)

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

;; verilog lsp-mode setup
(add-hook 'verilog-mode-local-vars-hook #'lsp!)
(setq verilog-linter "verible-verilog-lint")
(setq verilog-compiler "iverilog")
(setq verilog-tool 'verilog-compiler)
;; (setq verilog-tool 'verilog-linter)
(setq verilog-simulator "vvp")
(setq verilog-indent 2)
(setq verilog-indent-level-module 2)


;;setting spell check program
;;(setq ispell-program-name "aspell")

;;setting sentence interaction behavior
(setq sentence-end-double-space nil)

;; LaTeX
;; (setq TeX-command-default "laTeXMk")
(setq +latex-viewers '(pdf-tools))
(map! :map cdlatex-mode-map :i "TAB" #'cdlatex-tab)

;; Lua lsp stuff
(setq lsp-lua-workspace-preload-file-size 200)

;; disable lsp lenses
(setq lsp-lens-enable nil)

;; Auto close date for org todo items
;; (setq org-log-done 'time)
(after! org
  (setq org-log-done 'note)
  (setq org-capture-templates
    '(("t" "Todo" entry
     (file+headline +org-capture-todo-file "Todo")
     "* TODO  %?\n%i" :prepend t)
    ("n" "Notes" entry
     (file+headline +org-capture-notes-file "Notes")
     "* %u %?\n%i" :prepend t))))
;; Setting up org-capture files
(setq +org-capture-todo-file "inbox.org")
(setq +org-capture-notes-file "inbox.org")

