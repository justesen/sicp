#lang sicp

; Exercise 2.43
;
; Louis Reasoner is having a terrible time doing Exercise 2.42. His queens
; procedure seems to work, but it runs extremely slowly. (Louis never does
; manage to wait long enough for it to solve even the 6×6 case.) When Louis
; asks Eva Lu Ator for help, she points out that he has interchanged the order
; of the nested mappings in the flatmap, writing it as
;
; (flatmap
;  (lambda (new-row)
;    (map (lambda (rest-of-queens)
;           (adjoin-position
;            new-row k rest-of-queens))
;         (queen-cols (- k 1))))
;  (enumerate-interval 1 board-size))
;
; Explain why this interchange makes the program run slowly. Estimate how long
; it will take Louis’s program to solve the eight-queens puzzle, assuming that
; the program in Exercise 2.42 solves the puzzle in time T.

; Instead of making the recursive call once, he does it board-size times. I'm
; not quite sure how to figure out how long it takes, but instead of having one
; recursive call, we have n-1 recursive calls. So the original has a runtime of
;     T(n) = f(n) + T(n-1)
; whereas Louis' program has a runtime of
;     T(n) = f(n) + n*T(n-1)
; which looks exponentially worse.
;
; Hmm looks like people on the internet agrees with the above reasoning, saying
; that the original is n! and Louis' n^n.
