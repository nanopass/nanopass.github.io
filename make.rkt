#lang racket

(require compiler/find-exe
         racket/runtime-path
         "files.rkt")

(define-runtime-path project-root-dir ".")
(define-runtime-path git (let ([f (find-executable-path "git")])
                           (or f (error "git could not be found"))))

;; Generate html files
(for ([f (in-list files)])
  (with-output-to-file (path-replace-suffix f ".html")
    #:exists 'replace
    (lambda () (system* (find-exe) f))))

;; Push html files to origin in master branch
(parameterize ([current-directory project-root-dir])
  (define current-branch
    (make-parameter
     (string-normalize-spaces
      (with-output-to-string
        (lambda () (system* git "rev-parse" "--abbrev-ref" "HEAD"))))))

  ;; Error if repo is not in commitable state
  (when (non-empty-string? (with-output-to-string
                                 (lambda () (system* git "status" "--porcelain"))))
    (error "Please commit changes before deploying"))
  (when (equal? (current-branch) "master")
    (error "Cannot deploy in master branch"))

  ;; Set current branch to be master
  (system* git "checkout" "-B" "master")

  (for ([f (in-list (dict-keys html-file-table))])
    (system* git "add" f))
  (system* git "commit" "-m" "\"Automatic commit\"")
  (system* git "push" "origin" "master" "-f")
  (system* git "branch" (current-branch)))
