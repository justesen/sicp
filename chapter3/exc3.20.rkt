#lang sicp

; Exercise 3.20
;
; Draw environment diagrams to illustrate the evaluation of the sequence of
; expressions

(define x (cons 1 2))
(define z (cons x x))

(set-car! (cdr z) 17)

(car x)
; 17

; using the procedural implementation of pairs given above. (Compare Exercise
; 3.11.)

; I just can't be bothered to do that with ASCII art. Sorry :/ I thought I
; could, but I can't.
