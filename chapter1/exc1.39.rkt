#lang sicp

; Exercise 1.39
; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-12.html#%_thm_1.39
;
; A continued fraction representation of the tangent function was published in
; 1770 by the German mathematician J.H. Lambert:
;     tan x = x/(1−x^2/(3−x^2/5−…)),

; where x is in radians. Define a procedure (tan-cf x k) that computes an
; approximation to the tangent function based on Lambert’s formula. k specifies
; the number of terms to compute, as in Exercise 1.37.

(define (cont-frac n d k)
  (define (rec i)
    (if (> i k)
        0
        (/ (n i) (+ (d i) (rec (inc i))))))
  (rec 1))

(define (tan-cf x k)
  (cont-frac (lambda (i) (if (= i 1) x (- (* x x))))
             (lambda (i) (- (* 2 i) 1))
             k))

; Test
(define pi 3.14159265358979)
(tan-cf pi 100) ; ~0
(tan-cf (/ pi 4) 100); ~1
(tan-cf (/ pi 5) 100); ~0.73
