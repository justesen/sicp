#lang sicp

; Exercise 1.4
; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-10.html#%_thm_1.4
;
; Observe that our model of evaluation allows for combinations whose operators
; are compound expressions. Use this observation to describe the behavior of
; the following procedure:

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; The above procedure calculates
;   a + |b|
; since b is added to a if b is positive and subtracted if it's negative.
