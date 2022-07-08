#lang sicp

(#%require sicp-pict)

; Exercise 2.50
;
; Define the transformation flip-horiz, which flips painters horizontally, and
; transformations that rotate painters counterclockwise by 180 degrees and 270
; degrees.

(define (flip-horizo painter)
  (transform-painter
   painter
   (make-vect 1.0 0.0)
   (make-vect 0.0 0.0)
   (make-vect 1.0 1.0)))

(define (rotate-180 painter)
  (transform-painter
   painter
   (make-vect 1.0 1.0)
   (make-vect 0.0 1.0)
   (make-vect 1.0 0.0)))

(define (rotate-270 painter)
  (transform-painter
   painter
   (make-vect 0.0 1.0)
   (make-vect 0.0 0.0)
   (make-vect 1.0 1.0)))


; Test
(paint (flip-horizo einstein))
(paint (flip-horiz einstein))
(paint (rotate-180 einstein))
(paint (rotate180 einstein))
(paint (rotate-270 einstein))
(paint (rotate270 einstein))
