#lang info

(define raco-commands '(("nwt" (submod "make.rkt" main) "run Nanopass Website Tools" #f)))
(define deps '("racket-lib"
               "scribble-lib"
               "frog"
               "markdown"))
