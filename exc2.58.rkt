#lang sicp

(#%require "ch2.rkt")

; Exercise 2.58
;
; Suppose we want to modify the differentiation program so that it works with
; ordinary mathematical notation, in which + and * are infix rather than prefix
; operators. Since the differentiation program is defined in terms of abstract
; data, we can modify it to work with different representations of expressions
; solely by changing the predicates, selectors, and constructors that define
; the representation of the algebraic expressions on which the differentiator
; is to operate.

; 1. Show how to do this in order to differentiate algebraic expressions
;    presented in infix form, such as (x + (3 * (x + (y + 2)))). To simplify
;    the task, assume that + and * always take two arguments and that
;    expressions are fully parenthesized.

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2))
         (+ a1 a2))
        (else (list a1 '+ a2)))) ; <== change here to infix

(define (make-product m1 m2)
  (cond ((or (=number? m1 0)
             (=number? m2 0))
         0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2))
         (* m1 m2))
        (else (list m1 '* m2)))) ; <== change here to infix

(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+))) ; <== check cadr instead of car

(define (addend s) (car s)) ; <== car instead of car

(define (product? x)
  (and (pair? x) (eq? (cadr x) '*))) ; <== check cadr instead of car

(define (multiplier p) (car p)) ; <== car instead of car

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
(display (deriv '((x * y) * (x + 3)) 'x))
(newline)
(display (deriv '(x + (2 * x)) 'x))

; 2. The problem becomes substantially harder if we allow standard algebraic
;    notation, such as (x + 3 * (x + y + 2)), which drops unnecessary
;    parentheses and assumes that multiplication is done before addition. Can
;    you design appropriate predicates, selectors, and constructors for this
;    notation such that our derivative program still works?

; This seems difficult. You have to look ahead and see if there's a * somewhere
; in the list. I won't attempt this. Otherwise, I'll never be done with this
; book :)
