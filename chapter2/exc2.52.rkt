#lang sicp

(#%require sicp-pict)

; Exercise 2.52
;
; Make changes to the square limit of wave shown in Figure 2.9 by working at
; each of the levels described above. In particular:

; 1. Add some segments to the primitive wave painter of Exercise 2.49 (to add a
;    smile, for example).

; Didn't make the painter, but we can make a fancy diamond instead.

(define fancy-diamond
  (segments->painter
   (list (make-segment (make-vect 0.5 0) (make-vect 0.5 1))
         (make-segment (make-vect 0.5 0) (make-vect 0 0.5))
         (make-segment (make-vect 0 0.5) (make-vect 0.5 1))
         (make-segment (make-vect 0.5 1) (make-vect 1 0.5))
         (make-segment (make-vect 1 0.5) (make-vect 0.5 0)))))

; 2. Change the pattern constructed by corner-split (for example, by using only
;    one copy of the up-split and right-split images instead of two).

(define (corner-split painter n)
  (if (= n 0)
      painter
      (beside (below painter painter)
              (below painter
                     (corner-split painter (- n 1))))))

; 3. Modify the version of square-limit that uses square-of-four so as to
;    assemble the corners in a different pattern. (For example, you might make
;    the big Mr. Rogers look outward from each corner of the square.)

(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter)
                       (tr painter)))
          (bottom (beside (bl painter)
                          (br painter))))
      (below bottom top))))

(define (square-limit painter n)
  (let ((combine4
         (square-of-four flip-vert
                         rotate180
                         identity
                         flip-horiz)))
    (combine4 (corner-split painter n))))

; Test
(paint fancy-diamond)
(paint (corner-split einstein 5))
(paint (square-limit einstein 5))
