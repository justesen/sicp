#lang sicp

; Exercise 3.15;
;
; Draw box-and-pointer diagrams to explain the effect of set-to-wow! on the
; structures z1 and z2 above.

; z1-->|+|+|
;       | |
;    +--+ |
;    |  +-+
;    |  |
;    |  v
;    +>|a|+|-->|wow|/|

; z2-->|+|+|-->|a|+|-->|wow|/|
;       |
;       v
;      |a|+|-->|wow|/|

; But where a and wow really are the same symbols, shared at the same memory
; location.
