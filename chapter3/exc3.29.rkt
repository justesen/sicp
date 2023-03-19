#lang sicp

; Exercise 3.29
;
; Another way to construct an or-gate is as a compound digital logic device,
; built from and-gates and inverters. Define a procedure or-gate that
; accomplishes this. What is the delay time of the or-gate in terms of
; and-gate-delay and inverter-delay?

; Using DeMorgan's rule we have
;  a v b = !(!a ^ !b)

(define (or-gate a b s)
  (let ((not-a (make-wire))
        (not-b (make-wire))
        (r (make-wire)))
    (inverter a not-a)
    (inverter b not-b)
    (and-gate not-a not-b r)
    (inverter r s)
    'ok))

; The first inverters can be parallel, so the delay is
;     inverter-delay + and-gate-delay + inverter-delay
