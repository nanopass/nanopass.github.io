#lang racket

(provide (all-defined-out))

(require pict
         images/icons/style
         "utils.rkt")

(define-bitmap icon
  (pict->bitmap
   (vc-append
    5
    (hc-append
     5
     (make-ball "N" "DeepPink" 100)
     (make-ball "A" "Gold" 100))
    (hc-append
     5
     (make-ball "N" "Gold" 100)
     (make-ball "O" "DeepPink" 100)))))

(define-bitmap banner
  (pict->bitmap
   (vc-append
    5
    (hc-append
     5
     (make-ball "N" "DeepPink" 100)
     (make-ball "A" "Gold" 100)
     (make-ball "N" "DeepPink" 100)
     (make-ball "O" "Gold" 100))
    (hc-append
     5
     (make-ball "P" "LightSkyBlue" 100)
     (make-ball "A" "LimeGreen" 100)
     (make-ball "S" "LightSkyBlue" 100)
     (make-ball "S" "LimeGreen" 100)))))
