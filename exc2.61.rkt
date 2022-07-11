#lang sicp

; Exercise 2.61
;
; Give an implementation of adjoin-set using the ordered representation. By
; analogy with element-of-set? show how to take advantage of the ordering to
; produce a procedure that requires on the average about half as many steps as
; with the unordered representation.

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((= x (car set)) set)
        ((< x (car set)) (cons x set))
        (else (cons (car set) (adjoin-set x (cdr set))))))

; Test
(equal? (adjoin-set 4 '(1 2 3)) '(1 2 3 4))
(equal? (adjoin-set 3 '(1 2 3)) '(1 2 3))
(equal? (adjoin-set 2 '(1 2 3)) '(1 2 3))
(equal? (adjoin-set 0 '(1 2 3)) '(0 1 2 3))
(equal? (adjoin-set 2.5 '(1 2 3)) '(1 2 2.5 3))
