#lang sicp

; Exercise 2.5
;
; Show that we can represent pairs of nonnegative integers using only numbers
; and arithmetic operations if we represent the pair a and b as the integer
; that is the product 2^a3^b. Give the corresponding definitions of the
; procedures cons, car, and cdr.

(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (car n)
  (if (= (remainder n 2) 0)
      (+ 1 (car (/ n 2)))
      0))

(define (cdr n)
  (if (= (remainder n 3) 0)
      (+ 1 (car (/ n 3)))
      0))

; Test
(= (car (cons 4 5)) 4)
(= (cdr (cons 4 5)) 5)
(= (car (cons 0 5)) 0)
(= (cdr (cons 4 0)) 0)
