;;; holyc-mode.el --- Major mode for HolyC programming language  -*- lexical-binding: t; -*-

;;; Commentary:

;; Copyright 2022-present Naheel Azawy.  All rights reserved.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; Author: Naheel Azawy
;; Version: 1.0.0
;; Keywords: templeos tos holyc languages
;; URL: https://github.com/Naheel-Azawy/holyc-mode.el
;;
;; This file is not part of GNU Emacs.
;;; Code:



(defvar holyc-font-lock-keywords
  (let* (
         ;; define several category of keywords
         (x-keywords '("include" "define" "union" "catch" "class" "try" "if"
                       "else" "for" "while" "extern" "_extern" "return" "sizeof"
                       "_intern" "do" "asm" "goto" "exe" "break" "switch" "start "
                       "end  " "case" "default" "public" "offset" "import"
                       "_import" "ifdef" "ifndef" "ifaot" "ifjit" "endif" "assert"
                       "reg" "noreg" "lastclass" "no_warn" "help_index" "help_file"
                       "static" "lock" "defined" "interrupt" "haserrcode" "argpop"
                       "noargpop"))
         (x-types '("ALIGN" "ORG" "I0" "I8" "I16" "I32" "I64" "U0" "U8" "U16"
                    "U32" "U64" "F64" "DU8" "DU16" "DU32" "DU64" "DUP" "USE16"
                    "USE32" "USE64" "IMPORT" "LIST" "NOLIST" "BINFILE" "Bool"))
         (x-constants '("TRUE" "FALSE" "NULL"))

         ;; generate regex string for each category of keywords
         (x-keywords-regexp  (regexp-opt x-keywords  'symbols))
         (x-types-regexp     (regexp-opt x-types     'symbols))
         (x-constants-regexp (regexp-opt x-constants 'symbols)))

    `(
      ("\\(\\#[_a-zA-Z][_a-zA-Z0-9]*\\)" 1 font-lock-preprocessor-face)

      (,x-keywords-regexp  . font-lock-keyword-face)
      (,x-types-regexp     . font-lock-type-face)
      (,x-constants-regexp . font-lock-constant-face)

      ("\\_<[0-9.]+\\_>"        . font-lock-constant-face)
      ("\\_<0x[0-9a-fA-F]+\\_>" . font-lock-constant-face)
      ("\\_<0o[0-7]+\\_>"       . font-lock-constant-face)
      ("\\_<0b[01]+\\_>"        . font-lock-constant-face)
      
      ("\\#define[\t\s]+\\([_a-zA-Z][_a-zA-Z0-9]*\\)[\t\s]*(?" 1 font-lock-variable-name-face)
      ("\\([_a-zA-Z][_a-zA-Z0-9]*\\)[\t\s]*("                  1 font-lock-function-name-face)
      ("class \\([_a-zA-Z][_a-zA-Z0-9]*\\)"                    1 font-lock-type-face)
      ("\\([_a-zA-Z][_a-zA-Z0-9]*\\)[\t\s]+\\*?[_a-zA-Z][_a-zA-Z0-9]*" 1 font-lock-type-face)
      ))
  "HolyC language keyword regexp for font-locking.")

;;;###autoload
(define-derived-mode holyc-mode c-mode "HolyC"
  "Major mode for editing HolyC files"
  (setq-local font-lock-defaults '((holyc-font-lock-keywords))))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.HC\\'" . holyc-mode))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.HH\\'" . holyc-mode))

(provide 'holyc-mode)

;; TODO:
;; - [ ] replace special symbols with unicode chars
;;   something like https://github.com/sabof/org-bullets/blob/master/org-bullets.el
;; - [ ] color DD parts
;; - [ ] auto decompress and compress .Z files
;; - [ ] connect with templeos-builder and/or 3days
;; - [ ] handle bitmaps and 3d meshes?

;;; holyc-mode.el ends here
