#lang racket

(require compiler/find-exe
         "files.rkt")

(for ([f (in-list files)])
  (with-output-to-file (path-replace-suffix f ".html")
    #:exists 'replace
    (lambda () (system* (find-exe) f))))
