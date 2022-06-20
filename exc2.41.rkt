#lang sicp

; Exercise 2.41
;
; Write a procedure to find all ordered triples of distinct positive integers
; i, j, and k less than or equal to a given integer n that sum to a given
; integer s.

(#%require "ch2.rkt")

; We try and extend unique-pairs to do one more "loop":

(define (make-triples n)
  (flatmap
    (lambda (i)
      (flatmap
        (lambda (j)
          (map
            (lambda (k)
              (list i j k))
            (enumerate-interval 1 (- j 1))))
        (enumerate-interval 1 (- i 1))))
    (enumerate-interval 1 n)))

; There should be a nice way to generalize the above... Anyway, let's filter
; the triples:

(define (ordered-sum-triples n s)
  (filter (lambda (triple)
            (= (+ (car triple)
                  (cadr triple)
                  (caddr triple))
               s))
          (make-triples n)))

; Test
(display (ordered-sum-triples 6 10))
