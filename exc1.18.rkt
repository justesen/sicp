#lang sicp

; Exercise 1.18
; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_thm_1.18
;
; Using the results of Exercise 1.16 and Exercise 1.17, devise a procedure that
; generates an iterative process for multiplying two integers in terms of
; adding, doubling, and halving and uses a logarithmic number of steps.

; We can use the invariant
;     ab + x = a(b - 1) + (x + a)  (for odd n)
;            = 2ab/2 + x           (for even n)

(define (double n) (* n 2))

(define (halve n) (/ n 2))

(define (mul-iter a b x)
  (cond ((= b 0)   x)
        ((even? b) (mul-iter (double a) (halve b) x))
        (else      (mul-iter a (- b 1) (+ x a)))))

(define (mul a b)
  (mul-iter a b 0))

; Test
(mul 0 4)
(mul 4 0)
(mul 1 4)
(mul 4 1)
(mul 4 3)
(mul 3 4)
(mul 2 10)