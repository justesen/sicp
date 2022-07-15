#lang sicp

; Exercise 1.13
; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_thm_1.13
;
; Prove that Fib(n) is the closest integer to φ^n/√5, where φ=(1+√5)/2.
; Hint: Let ψ=(1−√5)/2. Use induction and the definition of the Fibonacci
; numbers (see 1.2.2) to prove that Fib(n)=(φ^n − ψ^n)/√5.

; For the base case n = 0, we have
;     Fib(0) = 0
; by definition and
;     (φ^0 − ψ^0)/√5 = 0/√5 = 0
; by the induction hypothesis. Similarly for the base case n = 1,
;     Fib(1) = 1
;     (φ^1 − ψ^1)/√5 = √5/√5 = 1
; For the induction step we have
;     Fib(n) = Fib(n-1) + Fib(n-2)
;            = (φ^(n-1) − ψ^(n-1))/√5 + (φ^(n-2) − ψ^(n-2))/√5
;            = (φ^(n-1) − ψ^(n-1) + φ^(n-2) − ψ^(n-2))/√5
;            = (φ^(n-1) + φ^(n-2) − (ψ^(n-1) + ψ^(n-2)))/√5
; Now, the crucial insight is that
;       φ^(n-1) + φ^(n-2)
;     = φ^(n-1)φ^2/φ^2 + φ^(n-2)φ^2/φ^2
;     = φ^(n+1)/φ^2 + φ^n/φ^2
;     = φ^n((φ + 1)/φ^2)
; and through tedious manipulation (by expanding φ), we have
;     (φ + 1)/φ^2 = 1.
; Similarly, we have
;     ψ^(n-1) + ψ^(n-2) = ψ^n.
; Substituting back, we get
;     Fib(n) = (φ^n - ψ^n)/√5
; which completes the induction proof.
;
; We have prooven that
;     Fib(n) = (φ^n - ψ^n)/√5
;            = φ^n/√5 - ψ^n/√5
; and since ψ < 1, ψ goes towards 0 as n approaches infinity, it becomes more
; and more insignificant, hence, we can just find Fib(n) by rounding φ^n/√5
; off to the nearest integer.
