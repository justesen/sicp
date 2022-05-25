#lang sicp

; Exercise 1.11
;
;
; A function f is defined by the rule that f(n) = n if n < 3 and
;     f(n) = f(n−1) + 2f(n−2) + 3f(n−3) if n≥3.
; Write a procedure that computes f by means of a recursive process. Write a
; procedure that computes f by means of an iterative process.

; The recursive definition is straightforward:

(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1))
         (* 2 (f (- n 2)))
         (* 3 (f (- n 3))))))

; Let's try some values to get a feeling for the sequence:

(f 1); 1
(f 2); 2
(f 3); 4
(f 4); 11
(f 5); 25
(f 6); 59
(f 7); 142

; Okay, I think I see an iterative pattern:
;     *3  *2  *1
;      1   2   4  =>  11
;      2   4  11  =>  25
;      4  11  25  =>  59
; So we'll need three state variables and a counter...

(define (iter n3 n2 n1 counter)
  (if (= counter 1)
      n3
      (iter n2
            n1
            (+ (* 3 n3) (* 2 n2) n1)
            (- counter 1))))

(define (f-iter n)
  (iter 1 2 4 n))

; Test:
(= (f 1) (f-iter 1))
(= (f 2) (f-iter 2))
(= (f 3) (f-iter 3))
(= (f 4) (f-iter 4))
(= (f 5) (f-iter 5))
(= (f 6) (f-iter 6))
(= (f 7) (f-iter 7))
(= (f 8) (f-iter 8))
(= (f 9) (f-iter 9))
