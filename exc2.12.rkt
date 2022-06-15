#lang sicp

; Exercise 2.12
;
; Define a constructor make-center-percent that takes a center and a percentage
; tolerance and produces the desired interval. You must also define a selector
; percent that produces the percentage tolerance for a given interval. The
; center selector is the same as the one shown above.

(define (make-interval a b) (cons a b))
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i)
        (upper-bound i))
     2))

(define (width i)
  (/ (- (upper-bound i)
        (lower-bound i))
     2))

(define (make-center-percent c p)
  (make-center-width c (- (* c (+ 1 (/ p 100))) c)))

(define (percent interval)
  (let ((c (center interval))
        (w (width interval)))
    (* 100 (/ w c) 1)))

; Test
(equal? (make-interval 8 12) (make-center-percent 10 20))
(= 20 (percent (make-center-percent 10 20)))
