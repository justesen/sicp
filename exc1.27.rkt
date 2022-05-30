#lang sicp

; Exercise 1.27
; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_thm_1.27
;
; Demonstrate that the Carmichael numbers listed in Footnote 47 really do fool
; the Fermat test. That is, write a procedure that takes an integer n and tests
; whether an is congruent to a modulo n for every a<n, and try your procedure
; on the given Carmichael numbers.

(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder
          (* base (expmod base (- exp 1) m))
          m))))

(define (prime-or-carmichael? n)
  (define (iter a)
    (cond ((>= a n)              #t)
          ((= a (expmod a n n)) (iter (inc a)))
          (else                  #f)))
  (iter 1))

; Test Carmichel numbers
(prime-or-carmichael? 561)
(prime-or-carmichael? 1105)
(prime-or-carmichael? 1729)
(prime-or-carmichael? 2465)
(prime-or-carmichael? 2821)
(prime-or-carmichael? 6601)

; Test non-Carmichael (and non-prime) numbers
(prime-or-carmichael? 4)
(prime-or-carmichael? 222)
(prime-or-carmichael? 231)
(prime-or-carmichael? 501)
