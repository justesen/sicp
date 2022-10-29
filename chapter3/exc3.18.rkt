#lang sicp

(#%require "ch3.rkt")

; Exercise 3.18
;
; Write a procedure that examines a list and determines whether it contains a
; cycle, that is, whether a program that tried to find the end of the list by
; taking successive cdrs would go into an infinite loop. Exercise 3.13
; constructed such lists.

(define (cycle? xs)
  (define (iter xs prev)
    (cond ((not (pair? xs))
           #f)
          ((memq (cdr xs) prev)
           #t)
          (else
           (iter (cdr xs) (cons xs prev)))))
  (iter xs '()))

; The car of a references itself, but that's fine.
(define a '(a b))
(set-car! a a)
a
(if (cycle? a) "cycle!" (last-pair a))

; v references itself, but it's not a cycle.
(define w '(c))
(define v (cons w w))
v
(if (cycle? v) "cycle!" (last-pair v))

; z references itself
(define z '(a b c))
(set-cdr! (cdr (cdr z)) z)
z
(if (cycle? z) "cycle!" (last-pair z))

; u references itself, but more succinctly.
(define v1 '(a b))
(define v2 '(a b))
(set-cdr! v1 v2)
(set-cdr! v2 v1)
(define u (cons v1 v2))
(if (cycle? u) "cycle!" (last-pair u))
