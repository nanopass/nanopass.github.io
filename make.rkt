#lang racket

(require racket/runtime-path
         xml
         glob
         (for-syntax glob))

(define (build-template-file template-file)
  (define template (dynamic-require template-file 'template))
  (with-output-to-file (path-replace-suffix template-file ".html")
    #:exists 'replace
    (lambda () (map (compose displayln xexpr->string) template))))

(define (build-page-file page-file)
  (define page (dynamic-require page-file 'page))
  ;; TODO: This is very broken if we ever want to use a folder called src.
  (define output-file (path-replace-suffix
                       (apply build-path (reverse
                                          (remove (string->path "src")
                                                  (reverse (explode-path page-file)))))
                       ".html"))
  (with-output-to-file output-file
    #:exists 'replace
    (lambda () (map (compose displayln xexpr->string) page))))

(define-runtime-path-list templates
  (glob "templates/*.rkt"))

(define-runtime-path-list pages
  (glob "src/*.rkt"))

(for ([f (in-list templates)])
  (build-template-file f))

(for ([f (in-list pages)])
  (build-page-file f))
