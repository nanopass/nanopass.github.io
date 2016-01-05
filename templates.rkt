#lang racket

(provide (all-defined-out))
(require web-server/templates)

(define (header title) (include-template "templates/header.html"))
(define (footer) (include-template "templates/footer.html"))
(define (navbar current-page) (include-template "templates/nav.html"))
