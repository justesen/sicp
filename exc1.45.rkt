#lang sicp

; Exercise 1.45
;
; We saw in 1.3.3 that attempting to compute square roots by naively finding a
; fixed point of y↦x/y does not converge, and that this can be fixed by average
; damping. The same method works for finding cube roots as fixed points of the
; average-damped y↦x/y2. Unfortunately, the process does not work for fourth
; roots—a single average damp is not enough to make a fixed-point search for
; y↦x/y3 converge. On the other hand, if we average damp twice (i.e., use the
; average damp of the average damp of y↦x/y3) the fixed-point search does
; converge. Do some experiments to determine how many average damps are
; required to compute nth roots as a fixed-point search based upon repeated
; average damping of y↦x/yn−1. Use this to implement a simple procedure for
; computing nth roots using fixed-point, average-damp, and the repeated
; procedure of Exercise 1.43. Assume that any arithmetic operations you need
; are available as primitives.

; First some pre-requisites:

(define (average a b)
  (/ (+ a b) 2))

(define (average-damp f)
  (lambda (x)
    (average x (f x))))

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (sqrt x)
  (fixed-point
   (average-damp
    (lambda (y) (/ x y)))
   1.0))

; Now let's try and nth-roots with m average dampenings:

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 0)
      identity
      (compose f (repeated f (- n 1)))))

(define (nth-root-avg-damp n m x)
  (fixed-point
   ((repeated average-damp m)
    (lambda (y)
      (/ x (expt y (- n 1)))))
   1.0))

; Let's see if we can find a pattern:
(nth-root-avg-damp 2 1 2)
(nth-root-avg-damp 3 1 2)
; (nth-root-avg-damp 4 1 2) ; doesn't finish as stated
(nth-root-avg-damp 4 2 2)
(nth-root-avg-damp 5 2 2)
(nth-root-avg-damp 6 2 2)
(nth-root-avg-damp 7 2 2)
; (nth-root-avg-damp 8 2 2) ; doesn't finish
(nth-root-avg-damp 8 3 2)
; Alright, I think I see a pattern. Let's try and confirm it:
(nth-root-avg-damp 15 3 2)
; (nth-root-avg-damp 16 3 2) ; doesn't finish
(nth-root-avg-damp 16 4 2) ; doesn't finish
; So it appears we have to do log2(n) average dampenings to compute the nth
; root.

(define (nth-root n x)
  (fixed-point
   ((repeated average-damp (log n 2))
    (lambda (y)
      (/ x (expt y (- n 1)))))
   1.0))
