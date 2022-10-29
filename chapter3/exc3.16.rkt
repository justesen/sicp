#lang sicp

; Exercise 3.16
;
; Ben Bitdiddle decides to write a procedure to count the number of pairs in
; any list structure. “It’s easy,” he reasons. “The number of pairs in any
; structure is the number in the car plus the number in the cdr plus one more
; to count the current pair.” So Ben writes the following procedure:

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

; Show that this procedure is not correct. In particular, draw box-and-pointer
; diagrams representing list structures made up of exactly three pairs for
; which Ben’s procedure would return 3; return 4; return 7; never return at
; all.

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
