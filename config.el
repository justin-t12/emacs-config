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
(setq doom-theme 'modus-operandi)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
;; (setq display-line-numbers-type 'visual)

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

;; TEMP: Fixes some issues with LaTeX and such, will be fixed in Emacs 30
(setq major-mode-remap-alist major-mode-remap-defaults)

;; set the warning level to error to stop unneeded warning messages
(setq warning-minimum-level :error)

;; disable compilation mode from being a popup and instead be a standard window
(set-popup-rule! "^\\*compilation\\*" :ignore t)

;; ;; respect visual lines (actually in init.el)
; (setq! evil-respect-visual-line-mode t)

(after! evil-mode
  ;; set the scope of f, t, and evil-snipe to everything below and including the
  ;; current line
  (setq evil-snipe-scope 'visible)
  ;; set insert cursor to box
  (setq evil-insert-state-cursor '(box))
  (define-key evil-insert-state-map (kbd "C-h") 'backward-delete-char))


;; turn on column numbers in modeline
(column-number-mode 1)

;; mouse support for vertico
(vertico-mouse-mode 1)

;; minions (reduces modes display on mode line)
(minions-mode 1)

;; Get nice scrolling
;; (pixel-scroll-mode 1)
;; (pixel-scroll-precision-mode 1)
;; (use-package! ultra-scroll
;;   :init
;;   (setq scroll-conservatively 101 ; important!
;;         scroll-margin 0)
;;   :config
;;   (ultra-scroll-mode 1))

(use-package! centered-cursor-mode
  :init
  (setq ccm-recenter-at-end-of-file t)
  (setq ccm-vpos-init '(- (round (ccm-visible-text-lines) 2) 4))
  :demand)

(map! :after centered-cursor-mode
      :map doom-leader-toggle-map
      "a" #'centered-cursor-mode
      "A" #'global-centered-cursor-mode)


;; (after! modus-themes
;;   ;; Make the Org agenda use alternative and varied colors.
;;   ;; Make the Org agenda use more blue instead of yellow and red.
;;   (setq modus-themes-common-palette-overrides
;;         '((date-common cyan) ; default value (for timestamps and more)
;;           (date-deadline blue-cooler)
;;           (date-event blue-faint)
;;           (date-holiday blue) ; for M-x calendar
;;           (date-now blue-faint)
;;           (date-scheduled blue)
;;           (date-weekday fg-main)
;;           (date-weekend fg-dim))))



;; pdfgrep setup
(require 'pdfgrep)
(pdfgrep-mode 1)

;; get clangd to stop inserting header files whenever it wants
(after! lsp-clangd
  (setq lsp-clients-clangd-args
        '("-j=3"
          "--background-index"
          "--clang-tidy"
          "--completion-style=detailed"
          "--header-insertion=never"
          "--header-insertion-decorators=0"))
  (set-lsp-priority! 'clangd 2))


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

;; Grammarly LSP mode stuff
;; (use-package! lsp-grammarly
;;   :ensure t
;;   :hook (text-mode . (lambda ()
;;                        (require 'lsp-grammarly)
;;                        (lsp-deferred))))  ; or lsp

;; Elixir IEx REPL
(map! :after elixir-mode
      :localleader
      :map elixir-mode-map
      :prefix ("i" . "inf-elixir")
      "i" 'inf-elixir
      "p" 'inf-elixir-project
      "l" 'inf-elixir-send-line
      "r" 'inf-elixir-send-region
      "b" 'inf-elixir-send-buffer
      "R" 'inf-elixir-reload-module)

;; Elixir DAP mode
(require 'dap-elixir)


;; verilog lsp-mode setup
;; (add-hook 'verilog-mode-local-vars-hook #'lsp!)
;; (setq verilog-linter "verible-verilog-lint")
;; (setq verilog-compiler "iverilog")
;; (setq verilog-tool 'verilog-compiler)
;; ;; (setq verilog-tool 'verilog-linter)
;; (setq verilog-simulator "vvp")

;;setting sentence interaction behavior
(setq sentence-end-double-space nil)

;; LaTeX
;; (setq TeX-command-default "laTeXMk")
;; (setq +latex-viewers '(pdf-tools))
(setq +latex-viewers '(okular))
(map! :map cdlatex-mode-map :i "TAB" #'cdlatex-tab)

;; Lua lsp stuff
(setq lsp-lua-workspace-preload-file-size 200)

;; disable lsp lenses
(setq lsp-lens-enable nil)

;; Python DAP debugger
(require 'dap-python)
(after! dap-mode
  (setq dap-python-debugger 'debugpy))

;; get writegood to shut up about passive voice
;; (setq writegood-passive-voice-irregulars nil)

;; org config options
(after! org
  ;; Remove unnessecary deadlines updates in agenda view
  (setq org-deadline-warning-days 5)
  ;; Auto close date for org todo items
  (setq org-log-done 'note)
  ;; Use minted for src block latex export
  (setq org-latex-src-block-backend 'minted)
  ;; capture templates
  (setq org-capture-templates
        '(("t" "Todo" entry
           (file+headline +org-capture-todo-file "Todo")
           "* TODO  %?\n%i" :prepend t)
          ("n" "Notes" entry
           (file+headline +org-capture-notes-file "Notes")
           "* %u %?\n%i" :prepend t)))
  (setq org-todo-keywords
      '((sequence "TODO" "REVIEW"  "|" "DONE"))))

(after! org-agenda
  (setq org-agenda-custom-commands
        '(("g" "Get Things Done (GTD)"
           ((agenda ""
                    ((org-agenda-format-date "%Y-%m-%d %a")
                     (org-agenda-skip-function
                      '(org-agenda-skip-entry-if 'regexp "\\* DONE"))
                     (org-deadline-warning-days 0)))
            (todo "TODO"
                  ((org-agenda-sorting-strategy '(scheduled-up deadline-up))
                   (org-agenda-overriding-header "\nTasks\n")))
            (todo "REVIEW"
                  ((org-agenda-sorting-strategy '(scheduled-up deadline-up))
                   (org-agenda-overriding-header "\nReview\n")))
            (agenda nil
                    ((org-agenda-entry-types '(:deadline))
                     (org-agenda-format-date "%Y-%m-%d %a")
                     (org-deadline-warning-days 5)
                     (org-agenda-skip-function
                      '(org-agenda-skip-entry-if 'regexp "\\* DONE"))
                     (org-agenda-sorting-strategy '(scheduled-up deadline-up))
                     (org-agenda-overriding-header "\nDeadlines")))
            (tags-todo "inbox"
                       ((org-agenda-prefix-format "  %?-12t% s")
                        (org-agenda-overriding-header "\nInbox\n")))
            (tags "CLOSED>=\"<today>\""
                  ((org-agenda-overriding-header "\nCompleted today\n"))))))))

;; add custom classes (idk if ox-latex is installed but this seems to work regardless)
(after! ox-latex
  (add-to-list 'org-latex-classes
               '("IEEEtran" "\\documentclass{IEEEtran}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  (add-to-list 'org-latex-packages-alist '("" "minted"))
  ;; enabling shell escape for org-mode latex, might break some Doom seettings
  (setq org-latex-pdf-process '("latexmk -shell-escape -f -pdf -%latex -interaction=nonstopmode -output-directory=%o %f")))


;; Setting up org-capture files
(setq +org-capture-todo-file "inbox.org")
(setq +org-capture-notes-file "inbox.org")


;; stop org-noter from auto narrowing to the wrong spot
(setq org-noter-disable-narrowing t)

;; set up tab behavior
(setq tab-always-indent t)


(defun my-open-calendar ()
  (interactive)
  (cfw:open-calendar-buffer
   :contents-sources
   (list
    ;; (cfw:org-create-source "Green")  ; org-agenda source
    (cfw:org-create-file-source "cal" "~/Sync/school.org" "Blue")  ; other org source
    ;; (cfw:howm-create-source "Blue")  ; howm source
    ;; (cfw:cal-create-source "Orange") ; diary source
    ;; (cfw:ical-create-source "Moon" "~/moon.ics" "Gray")  ; ICS source1
    ;; (cfw:ical-create-source "gcal" "https://..../basic.ics" "IndianRed") ; google calendar ICS
   )))
