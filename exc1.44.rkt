#lang sicp

; Exercise 1.44
;
; The idea of smoothing a function is an important concept in signal
; processing. If f is a function and dx is some small number, then the smoothed
; version of f is the function whose value at a point x is the average of
; f(x−dx), f(x), and f(x+dx). Write a procedure smooth that takes as input a
; procedure that computes f and returns a procedure that computes the smoothed
; f. It is sometimes valuable to repeatedly smooth a function (that is, smooth
; the smoothed function, and so on) to obtain the n-fold smoothed function.
; Show how to generate the n-fold smoothed function of any given function using
; smooth and repeated from Exercise 1.43.

(define (smooth f dx)
  (lambda (x)
    (/ (+ (f (- x dx))
          (f x)
          (f (+ x dx)))
       3)))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 0)
      identity
      (compose f (repeated f (- n 1)))))

(define (n-fold-smooth f dx n)
  ((repeated (lambda (g) (smooth g dx)) n) f))

; If we don't insist on having dx as an argument to smooth, but just define it
; at top-level, then n-fold-smooth can be written more succinctly:
; (define (n-fold-smooth f dx n)
;   ((repeated smooth n) f))

; Test
(define (square x) (* x x))
((smooth square 0.1) 2)
((n-fold-smooth square 0.1 1) 2)
((n-fold-smooth square 0.1 10) 2)
