#lang sicp

(#%require "ch2.rkt")

; Exercise 2.57
;
; Extend the differentiation program to handle sums and products of arbitrary
; numbers of (two or more) terms. Then the last example above could be
; expressed as
; (deriv '(* x y (+ x 3)) 'x)
; Try to do this by changing only the representation for sums and products,
; without changing the deriv procedure at all. For example, the addend of a sum
; would be the first term, and the augend would be the sum of the rest of the
; terms.

; This is actually pretty straightforward and only requires us to change augend
; og multiplicand as described above.

(define (augend s)
  (if (null? (cddr s))
      0
      (cons '+ (cddr s))))

(define (multiplicand s)
  (if (null? (cddr s))
      1
      (cons '* (cddr s))))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product
           (multiplier exp)
           (deriv (multiplicand exp) var))
          (make-product
           (deriv (multiplier exp) var)
           (multiplicand exp))))
        (else (error "unknown expression
                      type: DERIV" exp))))

; Test
(display (deriv '(+ x 3 x y) 'x))
(newline)
(display (deriv '(* x y (+ x 3)) 'x))
(newline)
(display (deriv '(+ 4 x (* 2 x)) 'x))
