#lang racket

(provide html-file-table
         files)

(require racket/runtime-path
         (for-syntax racket))

(module files-mod racket
  (provide file-table)
  (define file-table
    '(
      ("index.rkt"         . "Home")
      ("download.rkt"      . "Download")
      ("documentation.rkt" . "Documentation")
      )))
(require 'files-mod
         (for-syntax 'files-mod))

(define-runtime-path-list files
  (dict-keys file-table))

(define html-file-table
  (for/list ([f (in-list (dict-keys file-table))]
             [v (in-list (dict-values file-table))])
    (cons (path-replace-suffix f ".html") v)))
