#!/usr/bin/env racket
#lang racket

(require compiler/find-exe
         racket/runtime-path
         frog
         "files.rkt")

(define-runtime-path project-root-dir ".")
(define-runtime-path git (let ([f (find-executable-path "git")])
                           (or f (error "git could not be found"))))

(define deploy? (make-parameter #f))
(define force? (make-parameter #f))
(define watch? (make-parameter #f))
(define port (make-parameter 8080))

(define (build)
  (for ([f (in-list files)])
    (with-output-to-file (path-replace-suffix f ".html")
      #:exists 'replace
      (lambda ()
        (dynamic-require f 0)))))

(module+ main
  (define flags
    (command-line
     #:program "nanopass-website-make"
     #:once-each
     [("-w" "--watch")
      "(BETA) Automatically rebuild website when files are changed"
      (watch? #t)]
     [("-x" "--port")
      "Change the port of the server"
      (port port)]
     #:once-any
     [("-d" "--deploy")
      "Deploy blog to github"
      (deploy? #t)]
     [("-p" "--preview")
      "Preview in web browser"
      (serve #:launch-browser? #t
             #:watch? (watch?)
             #:watch-callback (lambda (path what)
                                (match (path->string path)
                                  ;; Output file
                                  [(pregexp "\\.(?:html|xml|txt)") (void)]
                                  ;; Source file
                                  [_ (build)
                                     (displayln #"\007")])) ;beep (hopefully)
             #:watch-path project-root-dir
             #:port (port)
             #:root project-root-dir)]
     #:once-each
     [("-f" "--force")
      "Force deply, even with unchecked changes"
      (force? #t)]))

  (parameterize ([current-directory project-root-dir])
    (define current-branch
      (make-parameter
       (string-normalize-spaces
        (with-output-to-string
          (lambda () (system* git "rev-parse" "--abbrev-ref" "HEAD"))))))

    ;; Error if repo is not in commitable state
    (when (deploy?)
      ; Uncommitted code
      (when (and (non-empty-string? (with-output-to-string
                                      (lambda () (system* git "status" "--porcelain"))))
                 (not (force?)))
        (raise-user-error 'nanopass.github.io "Please commit changes before deploying"))
      ; Cannot deploy in master branch
      (when (equal? (current-branch) "master")
        (raise-user-error 'nanopass.github.io "Cannot deploy in master branch"))
      ; Origin does not exist
      (unless (set-member? (string-split (with-output-to-string
                                           (lambda () (system* git "remote")))
                                         "\n")
                           "origin")
        (raise-user-error 'nanopass.github.io "Cannot find origin remote")))

    ;; If forcing, delete all files
    (when (force?)
      (system* git "clean" "-fxd"))

    ;; Generate html files
    (build)

    ;; Push html files to origin in master branch
    (when (deploy?)
      (system* git "checkout" "-B" "master")
      (for ([f (in-list (dict-values html-file-table))])
        (system* git "add" f))
      (for ([f (in-list (current-image-files))])
        (system* git "add" f))
      (system* git "commit" "-m" "\"Automatic commit\"")
      (system* git "push" "origin" "master" "-f")
      (system* git "clean" "-fxd")
      (system* git "checkout" (current-branch)))))
