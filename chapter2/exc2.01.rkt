#lang sicp

; Exercise 2.1
;
; Define a better version of make-rat that handles both positive and negative
; arguments. Make-rat should normalize the sign so that if the rational number
; is positive, both the numerator and denominator are positive, and if the
; rational number is negative, only the numerator is negative.

(define (sign x)
  (if (< x 0) -1 1))

(define (make-rat n d)
  (let ((g (gcd n d))
        (s (sign (* n d))))
    (cons (* s (/ (abs n) g))
          (/ (abs d) g))))

; Test
(make-rat 5 15)
(make-rat -5 15)
(make-rat 5 -15)
(make-rat -5 -15)
