#lang racket

(provide html-file-table
         files)

(require racket/runtime-path
         (for-syntax racket))

(module files-mod racket
  (provide file-table)
  (define file-table
    '(
      ("Home"              . "index.rkt")
      ("Download"          . "download.rkt")
      ("Documentation"     . "documentation.rkt")
      )))
(require 'files-mod
         (for-syntax 'files-mod))

(define-runtime-path-list files
  (dict-values file-table))

(define html-file-table
  (for/list ([f (in-list (dict-keys file-table))]
             [v (in-list (dict-values file-table))])
    (cons f (path-replace-suffix v ".html"))))
