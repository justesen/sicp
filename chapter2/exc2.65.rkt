#lang sicp

(#%require "ch2.rkt")

; Exercise 2.65

; Use the results of Exercise 2.63 and Exercise 2.64 to give Θ(n)
; implementations of union-set and intersection-set for sets implemented as
; (balanced) binary trees.

; For union we can convert each set to a list in linear time, merge them in
; linear time, and convert them back to a tree in linear time.

(define (merge-union xs ys)
  (cond ((null? xs)
         ys)
        ((null? ys)
         xs)
        ((> (car xs) (car ys))
         (cons (car ys) (merge-union xs (cdr ys))))
        ((< (car xs) (car ys))
         (cons (car xs) (merge-union (cdr xs) ys)))
        (else
         (cons (car xs) (merge-union (cdr xs) (cdr ys))))))

(define (union-set set1 set2)
  (list->tree
   (merge-union
    (tree->list-2 set1)
    (tree->list-2 set2))))

; Intersection is basically the same, except we need a slightly different merge
; procedure.

(define (merge-intersection xs ys)
  (cond ((null? xs)
         '())
        ((null? ys)
         '())
        ((> (car xs) (car ys))
         (merge-intersection xs (cdr ys)))
        ((< (car xs) (car ys))
         (merge-intersection (cdr xs) ys))
        (else
         (cons (car xs) (merge-intersection (cdr xs) (cdr ys))))))

(define (intersection-set set1 set2)
  (list->tree
   (merge-intersection
    (tree->list-2 set1)
    (tree->list-2 set2))))

; Test
(define s1 (list->tree '(1 2 3 4)))
(define s2 (list->tree '(3 4 5 6 7)))
(equal? (tree->list-2 (union-set s1 s2))
        '(1 2 3 4 5 6 7))
(tree->list-2 (intersection-set s1 s2))
(equal? (tree->list-2 (intersection-set s1 s2))
        '(3 4))
