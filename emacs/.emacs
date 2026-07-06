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

;; --- Tema y Parches Visuales para Rosé Pine (Clásico) ---
(load-theme 'base16-rose-pine t)

(custom-theme-set-faces
 'base16-rose-pine
 '(whitespace-space ((t (:background nil :foreground "#26233a"))))
 '(whitespace-newline ((t (:background nil :foreground "#26233a"))))
 '(whitespace-tab ((t (:background nil :foreground "#1f1d2e"))))
 '(whitespace-trailing ((t (:background "#26233a" :foreground "#eb6f92"))))
 '(line-number ((t (:inherit default :height 1.0 :foreground "#6e6a86" :background "#191724"))))
 '(line-number-current-line ((t (:inherit default :height 1.0 :bold t :foreground "#e0def4" :background "#1f1d2e")))))


(add-to-list 'load-path "~/.emacs.local/")

(add-to-list 'default-frame-alist
             '(font . "Hack 17"))

(use-package company)
(add-hook 'prog-mode-hook 'company-mode)

(use-package gruber-darker-theme)

(use-package rust-mode)
(require 'holyc-mode)
(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

(use-package smex)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(global-set-key (kbd "C-,") 'duplicate-line)

(load-file custom-file)
