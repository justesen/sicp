#lang sicp

; Exercise 2.40
;
; Define a procedure unique-pairs that, given an integer n, generates the
; sequence of pairs (i,j) with 1≤j<i≤n. Use unique-pairs to simplify the
; definition of prime-sum-pairs given above.

(#%require "ch2.rkt")

; This just requires us to extract the pair generating part of prime-sum-pairs,
; and then we can use that in prime-sum-pairs-alt.

(define (unique-pairs n)
  (flatmap
   (lambda (i)
     (map (lambda (j)
            (list i j))
          (enumerate-interval 1 (- i 1))))
   (enumerate-interval 1 n)))

(define (prime-sum-pairs-alt n)
  (map make-pair-sum
       (filter
        prime-sum?
        (unique-pairs n))))

; Test
(equal? (unique-pairs 4)
        (list (list 2 1) (list 3 1) (list 3 2) (list 4 1) (list 4 2) (list 4 3)))
(equal? (prime-sum-pairs-alt 10) (prime-sum-pairs 10))
