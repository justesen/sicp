#lang sicp

; Exercise 1.3
; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-10.html#%_thm_1.3
;
; Define a procedure that takes three numbers as arguments and returns the sum
; of the squares of the two larger numbers.

(define (square x)
  (* x x))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (f x y z)
  (cond ((and (<= x y) (<= x z)) (sum-of-squares y z))
        ((and (<= y x) (<= y z)) (sum-of-squares x z))
        (else                    (sum-of-squares x y))))

; Test
(= (+ (* 2 2) (* 3 3))
   (f 1 2 3)
   (f 2 1 3)
   (f 2 3 1))
