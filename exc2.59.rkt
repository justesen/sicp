#lang sicp

(#%require "ch2.rkt")

; Exercise 2.59
;
; Implement the union-set operation for the unordered-list representation of
; sets.

(define (union-set set1 set2)
  (if (null? set1)
      set2
      (adjoin-set (car set1) (union-set (cdr set1) set2))))

; Test
(equal? (union-set '() '(3 4 5)) '(3 4 5))
(equal? (union-set '(3 4 5) '()) '(3 4 5))
(equal? (union-set '(1 2 3) '(3 4 5)) '(1 2 3 4 5))
