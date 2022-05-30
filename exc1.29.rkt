#lang sicp

; Exercise 1.29
; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-12.html#%_thm_1.29
;
; Simpson’s Rule is a more accurate method of numerical integration than the
; method illustrated above. Using Simpson’s Rule, the integral of a function f
; between a and b is approximated as
;     h/3(y_0+4y_1+2y_2+4y_3+2y_4+ ⋯ +2y_{n−2}+4y{n−1}+y_n),
; where h=(b−a)/n, for some even integer n, and y_k=f(a+kh). (Increasing n
; increases the accuracy of the approximation.) Define a procedure that takes
; as arguments f, a, b, and n and returns the value of the integral, computed
; using Simpson’s Rule. Use your procedure to integrate cube between 0 and 1
; (with n=100 and n=1000), and compare the results to those of the integral
; procedure shown above.

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (integral f a b n)
  (define h (/ (- b a) n))
  (define (term k)
    (define y (f (+ a (* k h))))
    (cond ((or (= k 0) (= k n))  y)
          ((= 0 (remainder k 2)) (* 2 y))
          (else                  (* 4 y))))
  (* (/ h 3)
     (sum term 0 inc n)))

; Test
(define (cube x) (* x x x))

(integral cube 0.0 1.0 100)
; 0.24999999999999992
(integral cube 0.0 1.0 1000)
; 0.2500000000000003

; This gives much better precision than the version of integral in the text.
; With that we got n decimals of precision with n summation terms. Here we get
; close to as-good-as-can-be (in terms of floating point precision) with just
; 100 iterations.
