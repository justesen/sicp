#lang sicp

; Exercise 1.20
; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_thm_1.20
;
; The process that a procedure generates is of course dependent on the rules
; used by the interpreter. As an example, consider the iterative gcd procedure
; given above. Suppose we were to interpret this procedure using normal-order
; evaluation, as discussed in 1.1.5. (The normal-order-evaluation rule for if
; is described in Exercise 1.5.) Using the substitution method (for normal
; order), illustrate the process generated in evaluating (gcd 206 40) and
; indicate the remainder operations that are actually performed. How many
; remainder operations are actually performed in the normal-order evaluation of
; (gcd 206 40)? In the applicative-order evaluation?

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

; Normal-order evaluation:

(gcd 206
     40)
(gcd 40
     (remainder 206 40))
(gcd (remainder 206 40) ; 1
     (remainder 40 (remainder 206 40)))
(gcd (remainder 40 (remainder 206 40)) ; 2
     (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
(gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) ;  4
     (remainder (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder 40 (remainder 206 40))))
(gcd (remainder (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder 40 (remainder 206 40))) ; 7 (= 0) + 4 evaluations for a
     ...)

; b is evaluated at each step to figure out of we should stop, and then in the
; last step a is evaluated. These are noted above, in total:
;     1 + 2 + 4 + 7 + 4 = 18
; Note that the number of evalutions to compute b in invocation n is
;     inv(n) = inv(n-1) + inv(n - 2) + 1
;
; In applicative-order evalution, we only do four remainder evalutions:

(gcd 206 40)
(gcd 40 6) ; 1
(gcd 6 4) ; 1
(gcd 4 2) ; 1
(gcd 2 0) ; 1
2
