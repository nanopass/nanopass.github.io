#lang racket

(provide html-file-table
         files
         current-image-files
         add-image-file!)

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

(define (current-image-files)
  (file->lines "image-files"))

(define (add-image-file! file)
  (with-output-to-file "image-files"
    #:exists 'append
    (lambda () (displayln file))))
