#lang sicp

; Exercise 1.32
; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-12.html#%_thm_1.32
;
; Show that sum and product (Exercise 1.31) are both special cases of a still
; more general notion called accumulate that combines a collection of terms,
; using some general accumulation function:
;
; (accumulate combiner null-value term a next b)
;
; Accumulate takes as arguments the same term and range specifications as sum
; and product, together with a combiner procedure (of two arguments) that
; specifies how the current term is to be combined with the accumulation of the
; preceding terms and a null-value that specifies what base value to use when
; the terms run out. Write accumulate and show how sum and product can both be
; defined as simple calls to accumulate.

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

(define (product term a next b)
  (accumulate * 1 term a next b))

(define (sum term a next b)
  (accumulate + 0 term a next b))

; Test
(sum identity 1 inc 100)
(product identity 1 inc 10)

; If your accumulate procedure generates a recursive process, write one that
; generates an iterative process. If it generates an iterative process, write
; one that generates a recursive process.

(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner result (term a)))))
  (iter a null-value))

; Test
(define (product-iter term a next b)
  (accumulate-iter * 1 term a next b))

(define (sum-iter term a next b)
  (accumulate-iter + 0 term a next b))

; Test
(sum-iter identity 1 inc 100)
(product-iter identity 1 inc 10)
