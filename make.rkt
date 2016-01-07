#!/usr/bin/env racket
#lang racket

(require compiler/find-exe
         racket/runtime-path
         "files.rkt")

(define-runtime-path project-root-dir ".")
(define-runtime-path git (let ([f (find-executable-path "git")])
                           (or f (error "git could not be found"))))

(define deploy? (make-parameter #f))

(define flags
  (command-line
   #:program "nanopass-website-make"
   #:once-any
   [("-d" "--deploy")
    "Deploy blog to github"
    (deploy? #t)]))

(parameterize ([current-directory project-root-dir])
  (define current-branch
    (make-parameter
     (string-normalize-spaces
      (with-output-to-string
        (lambda () (system* git "rev-parse" "--abbrev-ref" "HEAD"))))))

  ;; Error if repo is not in commitable state
  (when (deploy?)
    ; Uncommitted code
    (when (non-empty-string? (with-output-to-string
                               (lambda () (system* git "status" "--porcelain"))))
      (raise-user-error 'nanopass.github.io "Please commit changes before deploying"))
    ; Oaster does not exist
    (when (equal? (current-branch) "master")
      (raise-user-error 'nanopass.github.io "Cannot deploy in master branch"))
    ; Origin does not exist
    (unless (set-member? (string-split (with-output-to-string
                                         (lambda () (system* git "remote")))
                                       "\n")
                         "origin")
      (raise-user-error 'nanopass.github.io "Cannot find origin remote")))

  ;; Generate html files
  (for ([f (in-list files)])
    (with-output-to-file (path-replace-suffix f ".html")
      #:exists 'replace
      (lambda () (system* (find-exe) f))))

  ;; Push html files to origin in master branch
  (when (deploy?)
    (system* git "checkout" "-B" "master")
    (for ([f (in-list (dict-values html-file-table))])
      (system* git "add" f))
    (system* git "commit" "-m" "\"Automatic commit\"")
    (system* git "push" "origin" "master" "-f")
    (system* git "checkout" (current-branch))))
