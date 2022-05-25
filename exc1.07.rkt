#lang sicp

; Exercise 1.7
; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-10.html#%_thm_1.7
;
; The good-enough? test used in computing square roots will not be very
; effective for finding the square roots of very small numbers. Also, in real
; computers, arithmetic operations are almost always performed with limited
; precision. This makes our test inadequate for very large numbers. Explain
; these statements, with examples showing how the test fails for small and
; large numbers. An alternative strategy for implementing good-enough? is to
; watch how guess changes from one iteration to the next and to stop when the
; change is a very small fraction of the guess. Design a square-root procedure
; that uses this kind of end test. Does this work better for small and large
; numbers?

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (square x)
  (* x x))

(define (sqrt x)
  (sqrt-iter 1.0 x))

; We can see that good-enough? works poorly for numbers less than the
; tolerance, e.g.,

(sqrt 0.0001)
; 0.03230844833048122

(square (sqrt 0.0001))
; 0.0010438358335233748

; For large numbers we lose precision, so improve won't change the guess, so
; good-enough? will never be true. This is the case, for example, with
; (sqrt 1e50) on my computer.

; Let's try and remedy those flaws:

(define (new-sqrt-iter guess old-guess x)
  (if (new-good-enough? guess old-guess)
      guess
      (new-sqrt-iter (improve guess x) guess x)))

(define (new-good-enough? guess old-guess)
  (< (/ (abs (- guess old-guess)) guess) 0.001))

(define (new-sqrt x)
  (new-sqrt-iter 1 0 x))

; Using the suggested way of improving good-enough? we see that we get better
; results for small numbers

(square (new-sqrt 0.0001))
; 0.00010000000050981486

; For large numbers we now don't run into precision problems, since the
; quotient will eventually be small enough.

(square (new-sqrt 1e50))
; 1.0000007615151658e+50
