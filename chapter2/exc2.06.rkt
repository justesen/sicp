#lang sicp

; Exercise 2.6
;
; In case representing pairs as procedures wasn’t mind-boggling enough,
; consider that, in a language that can manipulate procedures, we can get by
; without numbers (at least insofar as nonnegative integers are concerned) by
; implementing 0 and the operation of adding 1 as

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

; This representation is known as Church numerals, after its inventor, Alonzo
; Church, the logician who invented the λ-calculus.
;
; Define one and two directly (not in terms of zero and add-1). (Hint: Use
; substitution to evaluate (add-1 zero)). Give a direct definition of the
; addition procedure + (not in terms of repeated application of add-1).

; Let's try one by substitution:
(add-1 (lambda (f) (lambda (x) x)))
(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x))))
(lambda (f) (lambda (x) (f ((lambda (x) x) x))))
(lambda (f) (lambda (x) (f x)))
(define one (lambda (f) (lambda (x) (f x))))

; And two:
(add-1 (lambda (f) (lambda (x) (f x))))
(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f x))) f) x))))
(lambda (f) (lambda (x) (f ((lambda (x) (f x)) x))))
(lambda (f) (lambda (x) (f (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))

; Before giving addition a shot, I need some way of printing numbers to test
; out what I'm doing.

(define (church->int n)
  ((n inc) 0))

; Test
(church->int zero)
(church->int one)
(church->int two)

; Okay, for (add n m) we want to replace the innermost x in n by m (without the
; two lambdas). We can remove the lambdas by applying f and x - then we just
; have to add them again - sort of like in add-1.

(define (add n m)
  (lambda (f) (lambda (x) ((n f) ((m f) x)))))

; Test
(define three (add one two))
(define five (add three two))
(church->int five)
