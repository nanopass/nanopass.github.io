#lang info

(define raco-commands '(("nwt" (submod "make.rkt" main) "run Nanopass Website Tools" #f)))
(define deps '("base"
               "scribble-lib"
               "pict-lib"
               "image-lib"
               "frog"
               "markdown"))
