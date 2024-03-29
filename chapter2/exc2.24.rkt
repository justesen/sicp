#lang sicp

; Exercise 2.24
;
; Suppose we evaluate the expression (list 1 (list 2 (list 3 4))). Give the
; result printed by the interpreter, the corresponding box-and-pointer
; structure, and the interpretation of this as a tree (as in Figure 2.6).

; I'm just gonna try and draw the tree for (1 (2 (3 4)))
; 1
;  \
;   2
;   |\
;   | 3
;    \
;     4

; Test
(equal? (list 1 (list 2 (list 3 4))) '(1 (2 (3 4))))
