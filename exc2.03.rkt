#lang sicp

; Exercise 2.3
;
; Implement a representation for rectangles in a plane. (Hint: You may want to
; make use of Exercise 2.2.) In terms of your constructors and selectors,
; create procedures that compute the perimeter and the area of a given
; rectangle. Now implement a different representation for rectangles. Can you
; design your system with suitable abstraction barriers, so that the same
; perimeter and area procedures will work using either representation?

(define (make-point x y)
  (cons x y))

(define (x-point point)
  (car point))

(define (y-point point)
  (cdr point))

; Okay, so one way to represent it is by two points, the opposite corners:

(define (make-rect lower-left upper-right)
  (cons lower-left upper-right))

(define (get-ll rect)
  (car rect))

(define (get-ur rect)
  (cdr rect))

(define (perimeter rect)
  (let ((x1 (x-point (get-ll rect)))
        (y1 (y-point (get-ll rect)))
        (x2 (x-point (get-ur rect)))
        (y2 (y-point (get-ur rect))))
    (* 2 (+ (- x2 x1)
            (- y2 y1)))))

(define (area rect)
  (let ((x1 (x-point (get-ll rect)))
        (y1 (y-point (get-ll rect)))
        (x2 (x-point (get-ur rect)))
        (y2 (y-point (get-ur rect))))
    (* (- x2 x1)
       (- y2 y1))))

; It can also be defined by a point, a width, and a height:

(define (make-rect-alt lower-left width height)
  (cons lower-left (add-point lower-left (make-point width height))))

(define (add-point a b)
  (make-point (+ (x-point a) (x-point b))
              (+ (y-point a) (y-point b))))

; This representation allows us to re-use the procedures for perimeter and
; area.

; Test
(define r1 (make-rect (make-point 1 1)
                      (make-point 6 3)))
(define r2 (make-rect-alt (make-point 1 1) 5 2))

(= (area r1) (area r2) (* 5 2))
(= (perimeter r1) (perimeter r2) (* 2 (+ 5 2)))
