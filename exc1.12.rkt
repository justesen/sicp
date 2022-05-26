#lang sicp

; Exercise 1.12
; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_thm_1.12
;
; The following pattern of numbers is called Pascal’s triangle.
;
;          1
;        1   1
;      1   2   1
;    1   3   3   1
;  1   4   6   4   1
;        . . .
;
; The numbers at the edge of the triangle are all 1, and each number inside
; the triangle is the sum of the two numbers above it. Write a procedure that
; computes elements of Pascal’s triangle by means of a recursive process.

(define (pascal row col)
  (cond ((= row 0)   1)
        ((= col 0)   1)
        ((= row col) 1)
        (else      (+ (pascal (dec row) (dec col))
                      (pascal (dec row) col)))))
