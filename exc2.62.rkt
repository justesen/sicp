#lang sicp

; Exercise 2.62
;
; Give a Θ(n) implementation of union-set for sets represented as ordered
; lists.

(define (union-set set1 set2)
  (cond ((null? set1)
         set2)
        ((null? set2)
         set1)
        ((= (car set1) (car set2))
         (cons (car set1) (union-set (cdr set1) (cdr set2))))
        ((< (car set1) (car set2))
         (cons (car set1) (union-set (cdr set1) set2)))
        (else
         (cons (car set2) (union-set set1 (cdr set2))))))

; Test
(equal? (union-set '() '(3 4 5)) '(3 4 5))
(equal? (union-set '(3 4 5) '()) '(3 4 5))
(equal? (union-set '(1 2 3) '(3 4 5)) '(1 2 3 4 5))
(equal? (union-set '(1 2 3) '(2 3 4 5)) '(1 2 3 4 5))
