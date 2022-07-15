#lang sicp

; Exercise 2.47
; Here are two possible constructors for frames:

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (make-frame-alt origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

; For each constructor supply the appropriate selectors to produce an
; implementation for frames.

; Getting the origin and edge1 in both cases is the same

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

; But slightly different for edge2

(define (edge2-frame frame)
  (caddr frame))

(define (edge2-frame-alt frame)
  (cddr frame))

; Test (just with numbers instead of vectors for simplicity)
(define f (make-frame 1 2 3))
(define g (make-frame-alt 1 2 3))
(= (origin-frame f) 1)
(= (origin-frame g) 1)
(= (edge1-frame f) 2)
(= (edge1-frame g) 2)
(= (edge2-frame f) 3)
(= (edge2-frame-alt g) 3)
