#lang sicp

; Exercise 3.17
;
; Devise a correct version of the count-pairs procedure of Exercise 3.16 that
; returns the number of distinct pairs in any structure. (Hint: Traverse the
; structure, maintaining an auxiliary data structure that is used to keep track
; of which pairs have already been counted.)

(define (count-pairs x)
  (define seen '())
  (define (iter x)
    (if (or (not (pair? x)) (memq x seen))
        0
        (begin
          (set! seen (cons x seen))
          (+ (iter (car x))
             (iter (cdr x))
             1))))
  (iter x))

(define x '(a b c))
x
(count-pairs x)

(define u '(b c))
(define y (cons u (cdr u)))
y
(count-pairs y)

(define w '(c))
(define v (cons w w))
(define z (cons v v))
z
(count-pairs z)

(define a '(a b c))
(set-cdr! (cdr (cdr a)) a)
a
(count-pairs a)
