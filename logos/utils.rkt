#lang racket

(provide make-ball
         define-bitmap)

(require pict
         images/icons/style
         "../files.rkt"
         (for-syntax syntax/parse
                     racket/syntax))

(define-syntax (define-bitmap stx)
  (syntax-parse stx
    [(_ name:id p)
     #:with name-bitmap (format-id stx "~a-bitmap" #'name)
     #`(begin
         (define name-bitmap p)
         (define path (format "~a.png" '#,#'name))
         (unless (and (file-exists? path)
                      ((file-or-directory-modify-seconds #,(syntax-source stx))
                       . < .
                       (file-or-directory-modify-seconds path)))
           (add-image-file! path)
           (void (send name-bitmap save-file path 'png)))
         (define name path))]))

(define (make-ball letter color [size 100])
  (bitmap
   (bitmap-render-icon
    (pict->bitmap (cc-superimpose (disk size #:color color)
                                  (text letter (cons 'bold "Helvetica") (- size 5)))))))
