#lang sicp

; Exercise 1.34
; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-12.html#%_thm_1.34
;
; Suppose we define the procedure

(define (f g) (g 2))

; Then we have

(define (square x) (* x x))
(f square)
; 4

(f (lambda (z) (* z (+ z 1))))
; 6

; What happens if we (perversely) ask the interpreter to evaluate the
; combination (f f)? Explain.

; By substitution we get
; (f f)
; (f 2)
; (2 2)
; which results in an error, since 2 is not a procedure that can be applied to
; arguments.
