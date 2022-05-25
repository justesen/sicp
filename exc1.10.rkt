#lang sicp

; Exercise 1.10
; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_thm_1.10
;
; The following procedure computes a mathematical function called Ackermann’s function.

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

; What are the values of the following expressions?

(A 1 10)
; 1024
(A 2 4)
; 65536
(A 3 3)
; 65536

; Consider the following procedures, where A is the procedure defined above:

(define (f n) (A 0 n))
(define (g n) (A 1 n))
(define (h n) (A 2 n))
(define (k n) (* 5 n n))

; Give concise mathematical definitions for the functions computed by the
; procedures f, g, and h for positive integer values of n. For example, (k n)
; computes 5n^2.

; We see directly that (f n) computes 2n

; For (g n) let's try an example:
; (A 1 4)
; (A 0 (A 1 3))
; (A 0 (A 0 (A 1 2)))
; (A 0 (A 0 (A 0 (A 1 1))))
; (A 0 (A 0 (A 0 2)))
; (A 0 (A 0 4))
; (A 0 8)
; 16
; We see that 2 is doubled n-1 times, i.e., (f n) computes 2^2

; For (h n) let's try an example:
; (A 2 4)
; (A 1 (A 2 3))
; (A 1 (A 1 (A 2 2)))
; (A 1 (A 1 (A 1 (A 2 1))))
; (A 1 (A 1 (A 1 2)))
; Which we know from (g n) is 2^2^2^2, hence, (h n) computes 2↑↑n.
