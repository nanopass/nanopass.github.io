#lang scribble/html

@(provide (all-defined-out))
@(require scribble/html/html
          scribble/html/xml
          racket/dict
          "files.rkt"
          "logos/icon.rkt")

@(define (header . v)
   @head{
     @meta[charset: "utf-8"]
     @meta[http-equiv: "X-UA-Compatible" content: "IE=edge"]
     @meta[name: "viewport" 'content: "width=device-width, initial-scale=1"]
     @link[href: "css/bootstrap.min.css" rel: "stylesheet"]
     @link[href: "css/custom.css" rel: "stylesheet"]
     @title[v]{ - Nanopass Frameowrk}})

@(define (navbar . current-page)
   @div[class: "navbar navbar-inverse"]{
     @div[class: "container-fluid"]{
       @div[class: "row"]{
         @div[class: "navbar-header"]{
           @button[type: "button"
                   class: "navbar-toggle collapsed"
                   data-toggle: "collapse"
                   data-target: "#navbar"
                   aria-expanded: "false"
                   aria-controls: "navbar"]{
             @span[class: "sr-only"]{Toggle navigation}
             @span[class: "icon-bar"]
             @span[class: "icon-bar"]
             @span[class: "icon-bar"]}
           @a[class: "navbar-brand" href: (dict-ref html-file-table "Home")]{
             @img[src: banner alt: "Nanopass logo" height: "75" width: "150"]}}
         @div[id: "navbar" class: "navbar-collapse collapse"]{
           @ul[class: "nav navbar-nav"]{
             @(for/list ([title-pair (in-list html-file-table)])
                (if (equal? (car title-pair) (car current-page))
                    @li[role: "presentation" class: "active"]{@a[href: "#" (car title-pair)]}
                    @li[role: "presentation"]{@a[href: (cdr title-pair) (car title-pair)]}))}}}}})

@(define (footer . v)
   (list
    @element/not-empty["footer" class: "footer"]{@p{Nanopass}}
    @script[src: "https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"]
    @script[src: "js/bootstrap.min.js"]))

@(define (page #:title title . content)
  (list
    @doctype{html}
    @html[lang: "en"]{
      @header{title}
      @body[id: "pn-top"]{
        @navbar{title}
        @content
        @footer{}}}))
