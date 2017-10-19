;;; poly-bookdown.el
;;
;; Filename: poly-bookdown.el
;; Author: Spinu Vitalie
;; Maintainer: Spinu Vitalie
;; Copyright (C) 2013-2014, Spinu Vitalie, all rights reserved.
;; Version: 1.0
;; URL: https://github.com/vitoshka/polymode
;; Keywords: emacs
;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This file is *NOT* part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'polymode)
;; (require 'markdown-mode)

(defcustom pm-host/bookdown
  (pm-bchunkmode "Bookdown"
                 :mode 'bookdown-mode
                 :init-functions '(poly-bookdown-remove-bookdown-hooks))
  "Bookdown host chunkmode"
  :group 'hostmodes
  :type 'object)

(defcustom  pm-inner/bookdown
  (pm-hbtchunkmode-auto "bookdown"
                        :head-reg "^[ \t]*```[{ \t]*\\w.*$"
                        :tail-reg "^[ \t]*```[ \t]*$"
                        :retriever-regexp "```[ \t]*\\(?:{\\|lang=\\)?\\([^ \t\n,}]+\\)"
                        :font-lock-narrow t)
  "Bookdown typical chunk."
  :group 'innermodes
  :type 'object)

(defcustom pm-poly/bookdown
  (pm-polymode-multi-auto "bookdown"
                          :hostmode 'pm-host/bookdown
                          :auto-innermode 'pm-inner/bookdown)
  "Bookdown typical configuration"
  :group 'polymodes
  :type 'object)

;;;###autoload  (autoload 'poly-bookdown-mode "poly-bookdown")
(define-polymode poly-bookdown-mode pm-poly/bookdown)

;;; FIXES:
(defun poly-bookdown-remove-bookdown-hooks ()
  ;; get rid of awful hooks
  (remove-hook 'window-configuration-change-hook 'bookdown-fontify-buffer-wiki-links t)
  (remove-hook 'after-change-functions 'bookdown-check-change-for-wiki-link t))


(provide 'poly-bookdown)
