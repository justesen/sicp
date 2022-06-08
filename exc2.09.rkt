#lang sicp

; Exercise 2.9
;
; The width of an interval is half of the difference between its upper and
; lower bounds. The width is a measure of the uncertainty of the number
; specified by the interval. For some arithmetic operations the width of the
; result of combining two intervals is a function only of the widths of the
; argument intervals, whereas for others the width of the combination is not a
; function of the widths of the argument intervals. Show that the width of the
; sum (or difference) of two intervals is a function only of the widths of the
; intervals being added (or subtracted). Give examples to show that this is not
; true for multiplication or division.

; By the definition of add-interval, we have that
;     x±w + y±v = [(x - w) + (y - v), (x + w) + (y + v)]
;               = [(x + y) - (w + v), (x + y) + (w + v)]
;               = (x + y)±(w + v)
; The argument is similar for sub-interval.

; For mul-interval, let's try an example:

(define (make-interval a b) (cons a b))
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x)
               (lower-bound y)))
        (p2 (* (lower-bound x)
               (upper-bound y)))
        (p3 (* (upper-bound x)
               (lower-bound y)))
        (p4 (* (upper-bound x)
               (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define 5±2 (make-interval 3 7))
(define 2±1 (make-interval 1 3))
(mul-interval 5±2 2±1)

; This gives [3, 21] or 12±9. If it is a function only of the widths, we should
; get the same resulting width for two intervals with the same widths:

(define 6±2 (make-interval 4 8))
(define 3±1 (make-interval 2 4))
(mul-interval 6±2 3±1)

; But this gives [8, 32] or 20±12, i.e., another width, so for multiplication,
; the resulting width is not a function only of the widths.
