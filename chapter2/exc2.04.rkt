#lang sicp

; Exercise 2.4
;
; Here is an alternative procedural representation of pairs. For this
; representation, verify that (car (cons x y)) yields x for any objects x and
; y.

(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

; What is the corresponding definition of cdr? (Hint: To verify that this
; works, make use of the substitution model of 1.1.5.)

(define (cdr z)
  (z (lambda (p q) q)))

; Let's fist define a pair
;     (cons x y)
;     (λ (m) (m x y))
; and then apply car to that
;     (car (λ (m) (m x y)))
;     ((λ (m) (m x y)) (λ (p q) p))
;     ((λ (p q) p) x y)
;     x
; It's trivial to see that cdr works too.

; Test
(car (cons 1 2))
(cdr (cons 1 2))
