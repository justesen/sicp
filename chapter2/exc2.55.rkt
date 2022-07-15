#lang sicp

; Exercise 2.55
;
; Eva Lu Ator types to the interpreter the expression
; (car ''abracadabra)
; To her surprise, the interpreter prints back quote. Explain.

; ''abracadabra is the same as (quote (quote abracadabra)), hence, quote is the
; car of the list (quote abracadabra).
