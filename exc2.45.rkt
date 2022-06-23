#lang sicp

(#%require sicp-pict)

; Exercise 2.45
;
; Right-split and up-split can be expressed as instances of a general splitting
; operation. Define a procedure split with the property that evaluating
;
; (define right-split (split beside below))
; (define up-split (split below beside))
;
; produces procedures right-split and up-split with the same behaviors as the
; ones already defined.

(define (split outer inner)
  (define (rec painter n)
    (if (= n 0)
        painter
        (let ((smaller (rec painter (- n 1))))
          (outer painter
                 (inner smaller smaller)))))
  rec)

(define right-split (split beside below))
(define up-split (split below beside))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter
                                (- n 1))))
        (let ((top-left (beside up up))
              (bottom-right (below right
                                   right))
              (corner (corner-split painter
                                    (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right
                         corner))))))

; Test
(paint (corner-split einstein 5))
