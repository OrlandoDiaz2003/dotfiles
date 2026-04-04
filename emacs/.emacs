(setq custom-file "~/.emacs.custom.el")

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'use-package)
(setq use-package-always-ensure t)

(setq-default inhibit-splash-screen t
	          make-backup-files nil
	          tab-width 4
	          indent-tabs-mode nil
	          compilation-scroll-output t
	          )

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(ido-mode 1)
(ido-everywhere 1)
(global-display-line-numbers-mode 1)

(require 'whitespace)

(setq whitespace-style
      '(face
        tabs
        spaces
        trailing
        space-mark
        tab-mark))

(global-whitespace-mode 1)
(setq whitespace-display-mappings
      '(
        (tab-mark ?\t [?\u2192 ?\s])
        (space-mark ?\s [?\u00B7])
        ))

(add-to-list 'load-path "~/.emacs.local/")

(add-to-list 'default-frame-alist
             '(font . "Iosevka 18"))

(use-package gruber-darker-theme
  :config
  (load-theme 'gruber-darker t))

(use-package rust-mode)

(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

(use-package smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(global-set-key (kbd "C-,") 'duplicate-line)

(load-file custom-file)
