(package-initialize)

(add-to-list 'load-path "~/.emacs.local/")

(load "~/.emacs.rc/rc.el")

(load "~/.emacs.rc/misc-rc.el")
(load "~/.emacs.rc/org-mode-rc.el")
(load "~/.emacs.rc/autocommit-rc.el")

(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Активация Evil
(require 'evil)
(evil-mode 1)

;;; Appearance
(defun rc/get-default-font ()
  (cond
   ((eq system-type 'windows-nt) "Consolas-13")
   ((eq system-type 'gnu/linux) "Iosevka-20")))

(add-to-list 'default-frame-alist `(font . ,(rc/get-default-font)))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)

(rc/require-theme 'gruber-darker)
;; (rc/require-theme 'zenburn)
;; (load-theme 'adwaita t)

(eval-after-load 'zenburn
  (set-face-attribute 'line-number nil :inherit 'default))

;;; ido
(rc/require 'smex 'ido-completing-read+)

(require 'ido-completing-read+)

(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;; c-mode
(setq-default c-basic-offset 4
              c-default-style '((java-mode . "java")
                                (awk-mode . "awk")
                                (other . "bsd")))

(add-hook 'c-mode-hook (lambda ()
                         (interactive)
                         (c-toggle-comment-style -1)))

;;; Paredit
(rc/require 'paredit)

(defun rc/turn-on-paredit ()
  (interactive)
  (paredit-mode 1))

(add-hook 'emacs-lisp-mode-hook  'rc/turn-on-paredit)
(add-hook 'clojure-mode-hook     'rc/turn-on-paredit)
(add-hook 'lisp-mode-hook        'rc/turn-on-paredit)
(add-hook 'common-lisp-mode-hook 'rc/turn-on-paredit)
(add-hook 'scheme-mode-hook      'rc/turn-on-paredit)
(add-hook 'racket-mode-hook      'rc/turn-on-paredit)

;;; Emacs lisp
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-j")
                            (quote eval-print-last-sexp))))
(add-to-list 'auto-mode-alist '("Cask" . emacs-lisp-mode))

;;; Haskell mode
(rc/require 'haskell-mode)

(setq haskell-process-type 'cabal-new-repl)
(setq haskell-process-log t)

(add-hook 'haskell-mode-hook 'haskell-indent-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'haskell-doc-mode)
(add-hook 'haskell-mode-hook 'hindent-mode)


(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(require 'basm-mode)

(require 'fasm-mode)
(add-to-list 'auto-mode-alist '("\\.asm\\'" . fasm-mode))

(require 'porth-mode)

(require 'noq-mode)

(require 'jai-mode)

(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

;;; Whitespace mode
(defun rc/set-up-whitespace-handling ()
  (interactive)
  (whitespace-mode 1)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))

(add-hook 'tuareg-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'c++-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'c-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'simpc-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'emacs-lisp-mode 'rc/set-up-whitespace-handling)
(add-hook 'java-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'lua-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'rust-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'scala-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'markdown-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'haskell-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'python-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'erlang-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'asm-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'fasm-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'go-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'nim-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'yaml-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'porth-mode-hook 'rc/set-up-whitespace-handling)

;;; display-line-numbers-mode
(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))

;;; magit
;; magit requres this lib, but it is not installed automatically on
;; Windows.
(rc/require 'cl-lib)
(rc/require 'magit)

(setq magit-auto-revert-mode nil)

(global-set-key (kbd "C-c m s") 'magit-status)
(global-set-key (kbd "C-c m l") 'magit-log)

;;; multiple cursors
(rc/require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

;;; dired
(require 'dired-x)
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))
(setq-default dired-dwim-target t)
(setq dired-listing-switches "-alh")

;;; yasnippet
(rc/require 'yasnippet)

(require 'yasnippet)

(setq yas/triggers-in-field nil)
(setq yas-snippet-dirs '("~/.emacs.snippets/"))

(yas-global-mode 1)

(setq mouse-wheel-mode nil)

;;; word-wrap
(defun rc/enable-word-wrap ()
  (interactive)
  (toggle-word-wrap 1))

(add-hook 'markdown-mode-hook 'rc/enable-word-wrap)

;;; nxml
(add-to-list 'auto-mode-alist '("\\.html\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.xsd\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.ant\\'" . nxml-mode))

;;; tramp
;;; http://stackoverflow.com/questions/13794433/how-to-disable-autosave-for-tramp-buffers-in-emacs
(setq tramp-auto-save-directory "/tmp")

;;; powershell
(rc/require 'powershell)
(add-to-list 'auto-mode-alist '("\\.ps1\\'" . powershell-mode))
(add-to-list 'auto-mode-alist '("\\.psm1\\'" . powershell-mode))

;;; eldoc mode
(defun rc/turn-on-eldoc-mode ()
  (interactive)
  (eldoc-mode 1))

(add-hook 'emacs-lisp-mode-hook 'rc/turn-on-eldoc-mode)

;;; Company
(rc/require 'company)
(require 'company)

(global-company-mode)

(add-hook 'tuareg-mode-hook
          (lambda ()
            (interactive)
            (company-mode 0)))

;;; Tide
(rc/require 'tide)

(defun rc/turn-on-tide ()
  (interactive)
  (tide-setup))

(add-hook 'typescript-mode-hook 'rc/turn-on-tide)

;;; Proof general
(rc/require 'proof-general)
(add-hook 'coq-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-q C-n")
                            (quote proof-assert-until-point-interactive))))

;;; LaTeX mode
(add-hook 'tex-mode-hook
          (lambda ()
            (interactive)
            (add-to-list 'tex-verbatim-environments "code")))

(setq font-latex-fontify-sectioning 'color)

;;; Move Text
(rc/require 'move-text)
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

;;; Ebisp
(add-to-list 'auto-mode-alist '("\\.ebi\\'" . lisp-mode))

;;; Rust
(require 'lsp-mode)
(require 'lsp-ui)
(add-hook 'rust-mode-hook #'lsp)
(setq lsp-rust-server 'rust-analyzer)

(require 'company)
(add-hook 'rust-mode-hook 'company-mode)
(setq company-tooltip-align-annotations t)

(add-hook 'rust-mode-hook
 (lambda ()
   (local-set-key (kbd "<tab>") 'company-indent-or-complete-common)
   (local-set-key (kbd "S-<tab>") 'company-select-previous)
   ))
;
(defun my-company-select-previous (&optional arg)
 (interactive "p")
 (company-select-previous arg))

(define-key evil-normal-state-map (kbd "C-.") 'my-company-select-previous)
(electric-pair-mode 1)

;; Настраиваем, что будет вставляться
(setq electric-pair-pairs '(
                            (?\" . ?\")
                            (?\{ . ?\})
                            (?\( . ?\))
                            ))

(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (ansi-color-apply-on-region compilation-filter-start (point-max)))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(require 'evil)
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-insert-state-map (kbd "C-u")
  (lambda ()
    (interactive)
    (evil-delete (point-at-bol) (point))))
(define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
(define-key company-active-map (kbd "S-<tab>") 'company-select-previous)
(setq-default buffer-display-table (make-display-table))
(global-set-key (kbd "C-x 3") 'split-window-right)

(define-key evil-normal-state-map (kbd "C-.") 'evil-repeat)

(add-to-list 'auto-mode-alist '("\\.c\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c-mode))

(add-hook 'c-mode-common-hook
          (lambda ()
            (c-set-style "stroustrup")))
(add-hook 'c-mode-common-hook 'company-mode)
(add-hook 'c-mode-common-hook 'ggtags-mode)
(add-hook 'c-mode-common-hook 'flycheck-mode)

(use-package counsel-etags
  :ensure t
  :config
  (add-hook 'prog-mode-hook
            (lambda ()
              (add-hook 'after-save-hook
                        'counsel-etags-virtual-update-tags 'append)))
  :bind
  (:map evil-normal-state-map
        ("C-]" . counsel-etags-grep)))

(evil-define-key 'normal 'grep-find-mode-map
  (kbd "C-h") 'evil-window-left
  (kbd "C-j") 'evil-window-down
  (kbd "C-k") 'evil-window-up
  (kbd "C-l") 'evil-window-right)

(evil-define-key 'normal 'compilation-mode-map
  (kbd "C-h") 'evil-window-left
  (kbd "C-j") 'evil-window-down
  (kbd "C-k") 'evil-window-up
  (kbd "C-l") 'evil-window-right)

;;; Packages that don't require configuration
(rc/require
 'scala-mode
 'd-mode
 'yaml-mode
 'glsl-mode
 'tuareg
 'lua-mode
 'less-css-mode
 'graphviz-dot-mode
 'clojure-mode
 'cmake-mode
 'rust-mode
 'csharp-mode
 'nim-mode
 'jinja2-mode
 'markdown-mode
 'purescript-mode
 'nix-mode
 'dockerfile-mode
 'toml-mode
 'nginx-mode
 'kotlin-mode
 'go-mode
 'php-mode
 'racket-mode
 'qml-mode
 'ag
 'hindent
 'elpy
 'typescript-mode
 'rfc-mode
 'sml-mode
 )

(load "~/.emacs.shadow/shadow-rc.el" t)

(defun astyle-buffer (&optional justify)
  (interactive)
  (let ((saved-line-number (line-number-at-pos)))
    (shell-command-on-region
     (point-min)
     (point-max)
     "astyle --style=kr"
     nil
     t)
    (goto-line saved-line-number)))

(add-hook 'simpc-mode-hook
          (lambda ()
            (interactive)
            (setq-local fill-paragraph-function 'astyle-buffer)))

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1))

(global-set-key (kbd "M-s") 'shell-command)

(use-package ivy
  :ensure t
  :config
  (ivy-mode +1))

(global-set-key (kbd "C-c p") 'projectile-command-map)
(global-set-key (kbd "C-c p b") 'projectile-switch-to-buffer)

(evil-set-undo-system 'undo-redo)

(require 'compile)

;; pascalik.pas(24,44) Error: Can't evaluate constant expression

compilation-error-regexp-alist-alist

(add-to-list 'compilation-error-regexp-alist
             '("\\([a-zA-Z0-9\\.]+\\)(\\([0-9]+\\)\\(,\\([0-9]+\\)\\)?) \\(Warning:\\)?"
               1 2 (4) (5)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(display-line-numbers-type 'relative)
 '(org-agenda-dim-blocked-tasks nil)
 '(org-agenda-exporter-settings '((org-agenda-tag-filter-preset (list "+personal"))))
 '(org-cliplink-transport-implementation 'url-el)
 '(org-enforce-todo-dependencies nil)
 '(org-modules
   '(org-bbdb org-bibtex org-docview org-gnus org-habit org-info org-irc org-mhe org-rmail org-w3m))
 '(org-refile-use-outline-path 'file)
 '(package-selected-packages
   '(projectile ivy ryo-modal lsp-ui lsp-mode rainbow-mode proof-general elpy hindent ag qml-mode racket-mode php-mode go-mode kotlin-mode nginx-mode toml-mode dockerfile-mode nix-mode purescript-mode markdown-mode jinja2-mode nim-mode csharp-mode rust-mode cmake-mode clojure-mode graphviz-dot-mode lua-mode tuareg glsl-mode yaml-mode d-mode scala-mode move-text nasm-mode editorconfig tide company powershell js2-mode yasnippet multiple-cursors magit haskell-mode paredit ido-completing-read+ smex gruber-darker-theme org-cliplink dash-functional dash))
 '(safe-local-variable-values
   '((eval progn
           (auto-revert-mode 1)
           (rc/autopull-changes)
           (add-hook 'after-save-hook 'rc/autocommit-changes nil 'make-it-local))))
 '(whitespace-style
   '(face tabs spaces trailing space-before-tab newline indentation empty space-after-tab space-mark tab-mark)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )