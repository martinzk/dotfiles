;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
        (auto-completion :variables
                         auto-completion-enable-snippets-in-popup t
                         auto-completion-enable-sort-by-usage t)
        helm
        csv
        git
        markdown
        org
        (shell :variables
              shell-default-height 30
              shell-default-position 'bottom)
        (ranger :variables
                ranger-show-preview t
                ranger-enter-with-minus t
                ranger-cleanup-eagerly t)
        (spell-checking :variables
                        spell-checking-enable-auto-dictionary nil)
        pdf-tools
        syntax-checking
        evil-cleverparens
        (version-control :variables
                        version-control-diff-tool 'diff-hl
                        version-control-diff-side 'left
                        version-control-global-margin t)
        emacs-lisp
        python
        ipython-notebook
        bibtex
        (c-c++ :variables
              c-c++-default-mode-for-headers 'c++-mode
              c-c++-enable-clang-support t
              c-c++-enable-clang-format-on-save nil)
        (latex :variables
               latex-enable-folding t
               latex-enable-auto-fill nil))
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages
   '(
        ;; all-the-icons-ivy
        ;; ob-async
        pretty-mode
        (prettify-utils
          :location (recipe :fetcher github
                            :repo "Ilazki/prettify-utils.el"))
        solarized-theme)
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non-nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(solarized-light
                         solarized-dark)
   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 16
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non-nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, `J' and `K' move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non-nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands.
   dotspacemacs-auto-generate-layout-names nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non-nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non-nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non-nil the paste micro-state is enabled. When enabled pressing `p'
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil
   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non-nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   dotspacemacs-frame-title-format "%I@%S"
   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil
   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  ;; (require 'package)
  ;; (add-to-list 'package-directory-list "/run/current-system/sw/share/emacs/site-lisp/elpa")
  ;; (package-initialize)
  ;; (require 'pdf-tools)
  ;; (setq pdf-info-epdfinfo-program "/run/current-system/sw/share/emacs/site-lisp/elpa/pdf-tools-20170417.150/build/server/epdfinfo")
  )

(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."

  (setq eclim-eclipse-dirs '("/usr/lib/eclipse")
        eclim-executable "/usr/lib/eclipse/eclim")
  (module/display/fontsets)
  (module/display/font-locks)
  (module/display/prettify-magit)
  (module/display/prettify-symbols)
  (module/display/theme-updates)

  (spacemacs/toggle-highlight-long-lines-globally-on)

  (hungry-delete-mode 1)                                ; cut contiguous space
  (spacemacs/toggle-aggressive-indent-globally-on)      ; auto-indentation
  (add-hook 'org-mode-hook (lambda () (auto-fill-mode 1)))  ; SPC splits past 80

  (fringe-mode '(1 . 1))                         ; Minimal left padding
  (rainbow-delimiters-mode-enable)               ; Paren color based on depth
  (global-highlight-parentheses-mode 1)          ; Highlight containing parens
  (spacemacs/toggle-mode-line-minor-modes-off)  ; no uni symbs next to major

  (with-eval-after-load 'org
    ;; here goes your Org config :)
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((python . t)
       (C . t)
       ))
    (setq org-babel-C++-compiler '"clang++") ; replace g++ with clang++
    (setq org-babel-C-compiler '"clang") ; replace gcc with clang
    (setq org-confirm-babel-evaluate nil
          org-src-fontify-natively t
          org-src-tab-acts-natively t
          org-src-preserve-indentation t  ; Otherwise python is painful
          org-src-window-setup 'current-window)  ; `, ,` opens in same window
    ;; Enables interactive plotting
    (setq org-babel-default-header-args:python
          (cons '(:results . "output file replace")
                (assq-delete-all :results org-babel-default-header-args)))
    )
  )

;;;; Fontsets

(defun module/display/fontsets ()
  "Set right fonts for missing and all-the-icons unicode points."

  ;; Fira code ligatures. Fira Code Symbol is a different font than Fira Code!
  ;; You can use any font you wish with just the ligatures, I use Hack.
  (add-hook 'after-make-frame-functions (lambda (frame) (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol")))

  (defun set-icon-fonts (CODE-FONT-ALIST)
    "Utility to associate unicode points with a chosen font.
CODE-FONT-ALIST is an alist of a font and unicode points to force to use it."
    (mapc (lambda (x)
            (let ((font (car x))
                  (codes (cdr x)))
              (mapc (lambda (code)
                      (set-fontset-font t `(,code . ,code) font))
                    codes)))
          CODE-FONT-ALIST))

  ;; NOTE The icons you see are not the correct icons until this is evaluated
  (set-icon-fonts
   '(("fontawesome"
      ;;              
      #xf07c #xf0c9 #xf0c4 #xf0cb)

     ("all-the-icons"
      ;;    
      #xe907 #xe928)

     ("material"
      ;; 
      #xe192)

     ("github-octicons"
      ;;              
      #xf091 #xf059 #xf076 #xf075)

     ("fileicons"
      ;; 
      #xf016)

     ("Symbola"
      ;; 𝕊    ⨂      ∅      ⟻    ⟼     ⊙      𝕋       𝔽
      #x1d54a #x2a02 #x2205 #x27fb #x27fc #x2299 #x1d54b #x1d53d
      ;; 𝔹    𝔇       𝔗
      #x1d539 #x1d507 #x1d517))))

;;;; Font-locks

(defun module/display/font-locks ()
  "Enable following font-locks for appropriate modes."

  (defun -add-font-lock-kwds (FONT-LOCK-ALIST)
    "Add unicode font lock replacements.
FONT-LOCK-ALIST is an alist of a regexp and the unicode point to replace with.
Used as: (add-hook 'a-mode-hook (-partial '-add-font-lock-kwds the-alist))"
    (defun -build-font-lock-alist (REGEX-CHAR-PAIR)
      "Compose region for each REGEX-CHAR-PAIR in FONT-LOCK-ALIST."
      `(,(car REGEX-CHAR-PAIR)
        (0 (prog1 ()
             (compose-region
              (match-beginning 1)
              (match-end 1)
              ,(concat "	"
                       (list (cadr REGEX-CHAR-PAIR))))))))
    (font-lock-add-keywords nil (mapcar '-build-font-lock-alist FONT-LOCK-ALIST)))

  (defun add-font-locks (FONT-LOCK-HOOKS-ALIST)
    "Utility to add font lock alist to many hooks.
FONT-LOCK-HOOKS-ALIST is an alist of a font-lock-alist and its desired hooks."
    (mapc (lambda (x)
            (lexical-let ((font-lock-alist (car x))
                          (mode-hooks (cdr x)))
              (mapc (lambda (mode-hook)
                      (add-hook mode-hook
                                (-partial '-add-font-lock-kwds font-lock-alist)))
                    mode-hooks)))
          FONT-LOCK-HOOKS-ALIST))

  (add-font-locks
   `((,fira-font-lock-alist        prog-mode-hook  org-mode-hook)
     (,python-font-lock-alist      python-mode-hook)
     (,emacs-lisp-font-lock-alist  emacs-lisp-mode-hook)
     )))

;;;;; Fira-font-locks

(defconst fira-font-lock-alist
  '(;;;; OPERATORS
    ;;;;; Pipes
    ("\\(<|\\)" #Xe14d) ("\\(<>\\)" #Xe15b) ("\\(<|>\\)" #Xe14e) ("\\(|>\\)" #Xe135)

    ;;;;; Brackets
    ("\\(<\\*\\)" #Xe14b) ("\\(<\\*>\\)" #Xe14c) ("\\(\\*>\\)" #Xe104)
    ("\\(<\\$\\)" #Xe14f) ("\\(<\\$>\\)" #Xe150) ("\\(\\$>\\)" #Xe137)
    ("\\(<\\+\\)" #Xe155) ("\\(<\\+>\\)" #Xe156) ("\\(\\+>\\)" #Xe13a)

    ;;;;; Equality
    ("\\(!=\\)" #Xe10e) ("\\(!==\\)"         #Xe10f) ("\\(=/=\\)" #Xe143)
    ("\\(/=\\)" #Xe12c) ("\\(/==\\)"         #Xe12d)
    ("\\(===\\)"#Xe13d) ("[^!/]\\(==\\)[^>]" #Xe13c)

    ;;;;; Equality Special
    ("\\(||=\\)"  #Xe133) ("[^|]\\(|=\\)" #Xe134)
    ("\\(~=\\)"   #Xe166)
    ("\\(\\^=\\)" #Xe136)
    ("\\(=:=\\)"  #Xe13b)

    ;;;;; Comparisons
    ("\\(<=\\)" #Xe141) ("\\(>=\\)" #Xe145)
    ("\\(</\\)" #Xe162) ("\\(</>\\)" #Xe163)

    ;;;;; Shifts
    ("[^-=]\\(>>\\)" #Xe147) ("\\(>>>\\)" #Xe14a)
    ("[^-=]\\(<<\\)" #Xe15c) ("\\(<<<\\)" #Xe15f)

    ;;;;; Dots
    ("\\(\\.-\\)"    #Xe122) ("\\(\\.=\\)" #Xe123)
    ("\\(\\.\\.<\\)" #Xe125)

    ;;;;; Hashes
    ("\\(#{\\)"  #Xe119) ("\\(#(\\)"   #Xe11e) ("\\(#_\\)"   #Xe120)
    ("\\(#_(\\)" #Xe121) ("\\(#\\?\\)" #Xe11f) ("\\(#\\[\\)" #Xe11a)

    ;;;; REPEATED CHARACTERS
    ;;;;; 2-Repeats
    ("\\(||\\)" #Xe132)
    ("\\(!!\\)" #Xe10d)
    ("\\(%%\\)" #Xe16a)
    ("\\(&&\\)" #Xe131)

    ;;;;; 2+3-Repeats
    ("\\(##\\)"       #Xe11b) ("\\(###\\)"         #Xe11c) ("\\(####\\)" #Xe11d)
    ("\\(--\\)"       #Xe111) ("\\(---\\)"         #Xe112)
    ("\\({-\\)"       #Xe108) ("\\(-}\\)"          #Xe110)
    ("\\(\\\\\\\\\\)" #Xe106) ("\\(\\\\\\\\\\\\\\)" #Xe107)
    ("\\(\\.\\.\\)"   #Xe124) ("\\(\\.\\.\\.\\)"   #Xe126)
    ("\\(\\+\\+\\)"   #Xe138) ("\\(\\+\\+\\+\\)"   #Xe139)
    ("\\(//\\)"       #Xe12f) ("\\(///\\)"         #Xe130)
    ("\\(::\\)"       #Xe10a) ("\\(:::\\)"         #Xe10b)

    ;;;; ARROWS
    ;;;;; Direct
    ("[^-]\\(->\\)" #Xe114) ("[^=]\\(=>\\)" #Xe13f)
    ("\\(<-\\)"     #Xe152)
    ("\\(-->\\)"    #Xe113) ("\\(->>\\)"    #Xe115)
    ("\\(==>\\)"    #Xe13e) ("\\(=>>\\)"    #Xe140)
    ("\\(<--\\)"    #Xe153) ("\\(<<-\\)"    #Xe15d)
    ("\\(<==\\)"    #Xe158) ("\\(<<=\\)"    #Xe15e)
    ("\\(<->\\)"    #Xe154) ("\\(<=>\\)"    #Xe159)

    ;;;;; Branches
    ("\\(-<\\)"  #Xe116) ("\\(-<<\\)" #Xe117)
    ("\\(>-\\)"  #Xe144) ("\\(>>-\\)" #Xe148)
    ("\\(=<<\\)" #Xe142) ("\\(>>=\\)" #Xe149)
    ("\\(>=>\\)" #Xe146) ("\\(<=<\\)" #Xe15a)

    ;;;;; Squiggly
    ("\\(<~\\)" #Xe160) ("\\(<~~\\)" #Xe161)
    ("\\(~>\\)" #Xe167) ("\\(~~>\\)" #Xe169)
    ("\\(-~\\)" #Xe118) ("\\(~-\\)"  #Xe165)

    ;;;; MISC
    ("\\(www\\)"                   #Xe100)
    ("\\(<!--\\)"                  #Xe151)
    ("\\(~@\\)"                    #Xe164)
    ("[^<]\\(~~\\)"                #Xe168)
    ("\\(\\?=\\)"                  #Xe127)
    ("[^=]\\(:=\\)"                #Xe10c)
    ("\\(/>\\)"                    #Xe12e)
    ("[^\\+<>]\\(\\+\\)[^\\+<>]"   #Xe16d)
    ("[^:=]\\(:\\)[^:=]"           #Xe16c)
    ("\\(<=\\)"                    #Xe157)
  ))

;;;;; Language-font-locks

(defconst emacs-lisp-font-lock-alist
  ;; Outlines not using * so better overlap with in-the-wild packages.
  ;; Intentionally not requiring BOL for eg. fira config modularization
  '(("\\(^;;;\\)"                   ?■)
    ("\\(^;;;;\\)"                  ?○)
    ("\\(^;;;;;\\)"                 ?✸)
    ("\\(^;;;;;;\\)"                ?✿)))

(defconst python-font-lock-alist
  ;; Outlines
  '(("\\(^# \\*\\)[ \t\n]"          ?■)
    ("\\(^# \\*\\*\\)[ \t\n]"       ?○)
    ("\\(^# \\*\\*\\*\\)[ \t\n]"    ?✸)
    ("\\(^# \\*\\*\\*\\*\\)[^\\*]"  ?✿)))

(defun module/display/prettify-magit ()
  "Add faces to Magit manually for things like commit headers eg. (Add: ...).

Adding faces to Magit is non-trivial since any use of font-lock will break
fontification of the buffer. This is due to Magit doing all styling with
`propertize' and black magic. So we apply the faces the manual way.

Adds Ivy integration so a prompt of (Add, Docs, ...) appears when commiting.
Can explore icons by evaluating eg.: (all-the-icons-insert-icons-for 'material)
"

  (setq my-magit-colors '(:feature "silver"
                          :fix "#FB6542"    ; sunset
                          :add "#375E97"    ; sky
                          :clean "#FFBB00"  ; sunflower
                          :docs "#3F681C"   ; grass
                          ))

  (defface my-magit-base-face
    `((t :weight bold  :height 1.2))
    "Base face for magit commit headers."
    :group 'magit-faces)

  (defface my-magit-feature-face
    `((t :foreground ,(plist-get my-magit-colors :feature)
         :inherit my-magit-base-face))
    "Feature commit header face.")

  (defface my-magit-fix-face
    `((t :foreground ,(plist-get my-magit-colors :fix)
         :inherit my-magit-base-face))
    "Fix commit header face.")

  (defface my-magit-add-face
    `((t :foreground ,(plist-get my-magit-colors :add)
         :inherit my-magit-base-face))
    "Add commit header face.")

  (defface my-magit-clean-face
    `((t :foreground ,(plist-get my-magit-colors :clean)
         :inherit my-magit-base-face))
    "Clean commit header face.")

  (defface my-magit-docs-face
    `((t :foreground ,(plist-get my-magit-colors :docs)
         :inherit my-magit-base-face))
    "Docs commit header face.")

  (defface my-magit-master-face
    `((t :box t
         :inherit my-magit-base-face))
    "Docs commit header face.")

  (defface my-magit-origin-face
    `((t :box t
         :inherit my-magit-base-face))
    "Docs commit header face.")

  (setq pretty-magit-faces '(("\\<\\(Feature:\\)"         'my-magit-feature-face)
                             ("\\<\\(Add:\\)"             'my-magit-add-face)
                             ("\\<\\(Fix:\\)"             'my-magit-fix-face)
                             ("\\<\\(Clean:\\)"           'my-magit-clean-face)
                             ("\\<\\(Docs:\\)"            'my-magit-docs-face)
                             ("\\<\\(master\\)\\>"        'my-magit-master-face)
                             ("\\<\\(origin/master\\)\\>" 'my-magit-origin-face))

        pretty-magit-symbols '(("\\<\\(Feature:\\)"      ?)
                               ("\\<\\(Add:\\)"          ?)
                               ("\\<\\(Fix:\\)"          ?)
                               ("\\<\\(Clean:\\)"        ?)
                               ("\\<\\(Docs:\\)"         ?)
                               ("\\<\\(master\\)\\>"     ?)
                               ("\\<\\(origin/master\\)" ?)))

  (defun add-magit-faces ()
    "Apply `pretty-magit-faces' and `pretty-magit-symbols' to magit buffers."
    (interactive)
    (with-silent-modifications
      (--each pretty-magit-faces
        (save-excursion
          (evil-goto-first-line)
          (while (search-forward-regexp (car it) nil t)
            (add-face-text-property
             (match-beginning 1) (match-end 1) (cdr it)))))
      (--each pretty-magit-symbols
        (save-excursion
          (evil-goto-first-line)
          (while (search-forward-regexp (car it) nil t)
            (compose-region
             (match-beginning 1) (match-end 1) (cdr it)))))))

  (setq use-magit-commit-prompt-p nil)
  (defun use-magit-commit-prompt (&rest args)
    (setq use-magit-commit-prompt-p t))

  ;; (defun magit-commit-prompt ()
  ;;   "Magit prompt and insert commit header with faces."
  ;;   (interactive)
  ;;   (when use-magit-commit-prompt-p
  ;;     (setq use-magit-commit-prompt-p nil)
  ;;     (insert (helm-read "Commit Type "
  ;;                       '("Feature: " "Add: " "Fix: " "Clean: " "Docs: ")
  ;;                       :require-match t
  ;;                       :sort t
  ;;                       :preselect "Add: "))
  ;;     (add-magit-faces)
  ;;     (evil-insert 1)))

  ;; Now due to the delayed use of minibuffer in commit buffers, we cannot
  ;; use add-advice and instead use `git-commit-setup-hook' to run the prompt.
  ;; However, we only want the prompt for c-c `magit-commit' and not its
  ;; variants. The only way to distinguish the calling commit mode is through
  ;; the caller, so we use advice add on `magit-commit' for a prompt predicate.

  ;; (remove-hook 'git-commit-setup-hook 'with-editor-usage-message)
  ;; (add-hook 'git-commit-setup-hook 'magit-commit-prompt)

  (advice-add 'magit-status :after 'add-magit-faces)
  (advice-add 'magit-refresh-buffer :after 'add-magit-faces)
  (advice-add 'magit-commit :after 'use-magit-commit-prompt))

(defun module/display/prettify-symbols ()
  "Visually replace text with unicode.
Ivy keybinding has 'SPC i u' for consel-unicode-char for exploring options."

  (setq pretty-options
        (-flatten
         (prettify-utils-generate
          ;;;;; Functional
          (:lambda      "λ") (:def         "ƒ")
          (:composition "∘")

          ;;;;; Types
          (:null        "∅") (:true        "𝕋") (:false       "𝔽")
          (:int         "ℤ") (:float       "ℝ")
          (:str         "𝕊") (:bool        "𝔹")

          ;;;;; Flow
          (:in          "∈") (:not-in      "∉")
          (:return     "⟼") (:yield      "⟻")
          (:not         "￢")
          (:for         "∀")

          ;;;;; Other
          (:tuple       "⨂")
          (:pipe        "")
          )))

  (defun get-pretty-pairs (KWDS)
    "Utility to build an alist for prettify-symbols-alist from components.
KWDS is a plist of pretty option and the text to be replaced for it."
    (-non-nil
     (--map (when-let (major-mode-sym (plist-get KWDS it))
             `(,major-mode-sym
               ,(plist-get pretty-options it)))
           pretty-options)))

  (setq python-pretty-pairs
        (append
         (get-pretty-pairs
          '(:lambda "lambda" :def "def"
                    :null "None" :true "True" :false "False"
                    :int "int" :float "float" :str "str" :bool "bool"
                    :not "not" :for "for" :in "in" :not-in "not in"
                    :return "return" :yield "yield"
                    :tuple "Tuple"
                    :pipe "tz-pipe"
                    ))
         (prettify-utils-generate
          ;; Mypy Stuff
          ("Dict"     "𝔇") ("List"     "ℒ")
          ("Callable" "ℱ") ("Mapping"  "ℳ") ("Iterable" "𝔗")
          ("Union"    "⋃") ("Any"      "❔")))
        )

  (defun set-pretty-pairs (HOOK-PAIRS-ALIST)
    "Utility to set pretty pairs for many modes.
MODE-HOOK-PAIRS-ALIST is an alist of the mode hoook and its pretty pairs."
    (mapc (lambda (x)
            (lexical-let ((pretty-pairs (cadr x)))
              (add-hook (car x)
                        (lambda ()
                          (setq prettify-symbols-alist pretty-pairs)))))
          HOOK-PAIRS-ALIST))

  (set-pretty-pairs `((python-mode-hook ,python-pretty-pairs)))

  (global-prettify-symbols-mode 1)
  (global-pretty-mode t)

  ;; Activate pretty groups
  (pretty-activate-groups
   '(:arithmetic-nary :greek))

  ;; Deactivate pretty groups conflicting with Fira Code ligatures
  (pretty-deactivate-groups  ; Replaced by Fira Code
   '(:equality :ordering :ordering-double :ordering-triple
               :arrows :arrows-twoheaded :punctuation
               :logic :sets :sub-and-superscripts)))

(defun module/display/theme-updates ()
  "Face configuration for themes, atm solarized-light."

  (defun update-solarize-dark ()
    (setq org-src-block-faces `(("python" (:background "#073642"))))

    (custom-theme-set-faces
     'solarized-dark

     ;; Makes matching parens obvious
     `(sp-show-pair-match-face ((t (:inherit sp-show-pair-match-face
                                             :background "#586e75"))))

     ;; active modeline has no colors
     `(mode-line ((t (:inherit mode-line :background "#002b36"))))
     `(mode-line-inactive ((t (:inherit mode-line :background "#002b36"))))
     `(spaceline-highlight-face ((t (:inherit mode-line :background "#002b36"))))
     `(powerline-active1 ((t (:inherit mode-line :background "#002b36"))))
     `(powerline-active2 ((t (:inherit mode-line :background "#002b36"))))

     ;; Inactive modeline has tint
     `(powerline-inactive2 ((t (:inherit powerline-inactive1))))

     ;; Org and outline header updates
     `(outline-1 ((t (:height 1.25 :foreground ,my-black
                              :background "#268bd2"
                              :weight bold))))
     `(outline-2 ((t (:height 1.15 :foreground ,my-black
                              :background "#2aa198"
                              :weight bold))))
     `(outline-3 ((t (:height 1.05 :foreground ,my-black
                              :background "#b58900"
                              :weight bold))))

     `(org-level-1 ((t (:height 1.25 :foreground "#268bd2"
                                :underline t
                                :weight ultra-bold))))
     `(org-level-2 ((t (:height 1.15 :foreground "#2aa198"
                                :underline t
                                :weight ultra-bold))))
     `(org-level-3 ((t (:height 1.05 :foreground "#b58900"
                                :underline t
                                :weight ultra-bold))))

     ;; #586e75
     `(org-block-begin-line ((t (:height 1.05 :foreground "#576e75"
                                         :box t :weight bold))))
     ))

  (setq my-black "#1b1b1e")

  (defun update-solarize-light ()
    (custom-theme-set-faces
     'solarized-light

     ;; Makes matching parens obvious
     `(sp-show-pair-match-face ((t (:inherit sp-show-pair-match-face
                                             :background "light gray"))))

     ;; active modeline has no colors
     `(mode-line ((t (:inherit mode-line :background "#fdf6e3"))))
     `(mode-line-inactive ((t (:inherit mode-line :background "#fdf6e3"))))
     `(spaceline-highlight-face ((t (:inherit mode-line :background "#fdf6e3"))))
     `(powerline-active1 ((t (:inherit mode-line :background "#fdf6e3"))))
     `(powerline-active2 ((t (:inherit mode-line :background "#fdf6e3"))))

     ;; Inactive modeline has tint
     `(powerline-inactive2 ((t (:inherit powerline-inactive1))))

     ;; Org and outline header updates
     `(org-level-1 ((t (:height 1.25 :foreground ,my-black
                                :background "#C9DAEA"
                                :weight bold))))
     `(org-level-2 ((t (:height 1.15 :foreground ,my-black
                                :background "#7CDF64"
                                :weight bold))))
     `(org-level-3 ((t (:height 1.05 :foreground ,my-black
                                :background "#F8DE7E"
                                :weight bold))))

     '(outline-1 ((t (:inherit org-level-1))))
     '(outline-2 ((t (:inherit org-level-2))))
     '(outline-3 ((t (:inherit org-level-3))))
     '(outline-4 ((t (:inherit org-level-4))))

     `(org-todo ((t (:foreground ,my-black :weight extra-bold
                                 :background "light gray"))))
     `(org-priority ((t (:foreground ,my-black :weight bold
                                     :background "light gray"))))
     ))
  ;; syntax-propertize-function
  ;; (eval-after-load 're-builder '(setq reb-re-syntax 'rx))
  ;; rx macro
  ;; http://www.lunaryorn.com/posts/search-based-fontification-with-keywords
  ;; http://www.lunaryorn.com/posts/advanced-syntactic-fontification
  (if (string= 'solarized-dark (car custom-enabled-themes))
      (update-solarize-dark)
    (update-solarize-light)))
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-want-Y-yank-to-eol nil)
 '(package-selected-packages
   (quote
    (meghanada groovy-mode groovy-imports pcache gradle-mode ensime sbt-mode scala-mode company-emacs-eclim eclim ivy org-brain evil-org yapfify xterm-color ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org symon string-inflection spaceline powerline solarized-theme smeargle shell-pop restart-emacs realgud test-simple loc-changes load-relative ranger rainbow-delimiters pyvenv pytest pyenv-mode py-isort pretty-mode prettify-utils popwin pip-requirements persp-mode pcre2el password-generator paradox spinner orgit org-ref pdf-tools key-chord tablist org-projectile org-present org-pomodoro alert log4e gntp org-download org-bullets open-junk-file nix-mode neotree multi-term move-text mmm-mode markdown-toc markdown-mode magit-gitflow macrostep lorem-ipsum live-py-mode linum-relative link-hint info+ indent-guide hydra hy-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-pydoc helm-purpose window-purpose imenu-list helm-projectile helm-nixos-options helm-mode-manager helm-make projectile helm-gitignore helm-flx helm-descbinds helm-company helm-c-yasnippet helm-bibtex parsebib helm-ag google-translate golden-ratio gnuplot gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter gh-md fuzzy flyspell-correct-helm flyspell-correct flycheck-pos-tip pos-tip flycheck pkg-info epl flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist org-plus-contrib evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit magit magit-popup git-commit with-editor evil-lisp-state evil-lion evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-cleverparens smartparens paredit evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu highlight eshell-z eshell-prompt-extras esh-help elisp-slime-nav ein skewer-mode deferred request websocket js2-mode simple-httpd editorconfig dumb-jump disaster diminish diff-hl define-word cython-mode csv-mode company-statistics company-nixos-options nixos-options company-c-headers company-auctex company-anaconda company column-enforce-mode cmake-mode clean-aindent-mode clang-format browse-at-remote bind-map bind-key biblio biblio-core auto-yasnippet yasnippet auto-highlight-symbol auto-dictionary auto-compile packed auctex-latexmk auctex anaconda-mode pythonic f dash s aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core async ac-ispell auto-complete popup)))
 '(pdf-misc-print-programm "/usr/bin/lpr"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
