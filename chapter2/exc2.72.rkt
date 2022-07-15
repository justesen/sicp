#lang sicp

; Exercise 2.72
;
; Consider the encoding procedure that you designed in Exercise 2.68. What is
; the order of growth in the number of steps needed to encode a symbol? Be sure
; to include the number of steps needed to search the symbol list at each node
; encountered. To answer this question in general is difficult. Consider the
; special case where the relative frequencies of the n symbols are as described
; in Exercise 2.71, and give the order of growth (as a function of n) of the
; number of steps needed to encode the most frequent and least frequent symbols
; in the alphabet.

; In the worst case it takes
;     T(n) = O(n) + T(n-1),
; i.e., O(n^2). But we shouldn't need to go all the way to the bottom of the
; tree very often, since we should find the most frequently used symbols higher
; in the tree.
