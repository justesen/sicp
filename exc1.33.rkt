#lang sicp

; Exercise 1.33
; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-12.html#%_thm_1.33
;
; You can obtain an even more general version of accumulate (Exercise 1.32) by
; introducing the notion of a filter on the terms to be combined. That is,
; combine only those terms derived from values in the range that satisfy a
; specified condition. The resulting filtered-accumulate abstraction takes the
; same arguments as accumulate, together with an additional predicate of one
; argument that specifies the filter. Write filtered-accumulate as a procedure.

(define (filtered-accumulate combiner null-value pred term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a)
              (if (pred a)
                  (combiner result (term a))
                  result))))
  (iter a null-value))

; Show how to express the following using filtered-accumulate:
;
; 1. the sum of the squares of the prime numbers in the interval a to b
;    (assuming that you have a prime? predicate already written)
; 2. the product of all the positive integers less than n that are relatively
;    prime to n (i.e., all positive integers i<n such that GCD(i,n)=1).

(define (sum-of-squares-of-primes a b)
  (filtered-accumulate + 0 prime? square a inc b))

(define (product-of-relative-primes n)
  (define (relative-prime? i)
    (= (gcd i n) 1))
  (filtered-accumulate * 1 relative-prime? identity 1 inc (dec n)))

; Auxiliary procedures
(define (square x) (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n)
         n)
        ((divides? test-divisor n)
         test-divisor)
        (else (find-divisor
               n
               (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (if (< n 2)
      #f
      (= n (smallest-divisor n))))

; Test sum-of-squares-of-primes
(= (sum-of-squares-of-primes 0 10) (+ 4 9 25 49))

; Test product-of-relative-primes
(product-of-relative-primes 10)
