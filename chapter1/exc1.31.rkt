#lang sicp

; Exercise 1.31
; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-12.html#%_thm_1.31
;
; The sum procedure is only the simplest of a vast number of similar
; abstractions that can be captured as higher-order procedures. Write an
; analogous procedure called product that returns the product of the values of
; a function at points over a given range. Show how to define factorial in
; terms of product. Also use product to compute approximations to π using the
; formula
;     π/4=(2⋅4⋅4⋅6⋅6⋅8⋅⋯)/(3⋅3⋅5⋅5⋅7⋅7⋅⋯).

(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

; Test
(define (pi terms product)
  (define (next x)
    (+ x 2))
  (define (numerator)
    (define (term x)
      (* x (+ x 2)))
    (product term 2 next terms))
  (define (denominator)
    (define (term x)
      (* x x))
    (product term 3 next (+ terms 1)))
  (* 4.0 (/ (numerator) (denominator))))

; Test
(pi 7 product)
; 3.3436734693877552
(pi 1000 product)
; 3.1431607055322663

; If your product procedure generates a recursive process, write one that
; generates an iterative process. If it generates an iterative process, write
; one that generates a recursive process.

(define (prod term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

; For testing, we extended the procedure pi above, so we can pass it a method
; for making products
(= (pi 7 prod) (pi 7 product))
; 3.3436734693877552
(= (pi 1000 prod) (pi 1000 product))
; 3.1431607055322663
