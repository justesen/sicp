#lang sicp

(#%require "ch3.rkt")

; Floyd's tortoise and hare algorithm:
; See: https://en.wikipedia.org/wiki/Cycle_detection

(define (cycle? xs)
  (define (iter tortoise hare)
    (cond ((eq? tortoise hare)
           #t)
          ((not (pair? tortoise))
           #f)
          ((or (not (pair? hare))
               (not (pair? (cdr hare))))
           #f)
          (else
           (iter (cdr tortoise) (cddr hare)))))
  (if (pair? xs)
      (iter xs (cdr xs))
      #f))

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