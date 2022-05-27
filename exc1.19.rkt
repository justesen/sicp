#lang sicp

; Exercise 1.19
; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_thm_1.19
;
; There is a clever algorithm for computing the Fibonacci numbers in a
; logarithmic number of steps. Recall the transformation of the state variables
; a and b in the fib-iter process of 1.2.2: a←a+b and b←a. Call this
; transformation T, and observe that applying T over and over again n times,
; starting with 1 and 0, produces the pair Fib(n+1) and Fib(n). In other words,
; the Fibonacci numbers are produced by applying T^n, the nth power of the
; transformation T, starting with the pair (1, 0). Now consider T to be the
; special case of p=0 and q=1 in a family of transformations T_pq, where T_pq
; transforms the pair (a,b) according to a←bq+aq+ap and b←bp+aq. Show that if
; we apply such a transformation T_pq twice, the effect is the same as using a
; single transformation T_p′q′ of the same form, and compute p′ and q′ in terms
; of p and q. This gives us an explicit way to square these transformations,
; and thus we can compute T^n using successive squaring, as in the fast-expt
; procedure. Put this all together to complete the following procedure, which
; runs in a logarithmic number of steps:

; One tranformation gives us
;     a' = bq + aq + ap
;     b' = bp + aq
; A second transformation gives us
;    a'' = b'q + a'q + a'p
;        = (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p
;        = bpq + aqq + bpqq + aqq + apq + bpq + apq + app
;        = b(2pq + qq) + a(2pq + qq) + a(pp + qq)
;    b'' = b'p + a'q
;        = (bp + aq)p + (bq + aq + ap)q
;        = bpp + apq + bqq + aqq + apq
;        = b(pp + qq) + a(2pq + qq)
; Hence after to iterations we have
;     p' = pp + qq
;     q' = 2pq + qq
; which we insert the procedure below.

(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0)
         b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* p p) (* q q))   ; compute p'
                   (+ (* 2 p q) (* q q)) ; compute q'
                   (/ count 2)))
        (else
         (fib-iter (+ (* b q)
                      (* a q)
                      (* a p))
                   (+ (* b p)
                      (* a q))
                   p
                   q
                   (- count 1)))))

; Test
(define (display-fib n)
  (cond ((= n 0) (display (fib n))
                 (newline))
        (else    (display (fib n))
                 (newline)
                 (display-fib (dec n)))))

(display-fib 10)

(fib 1000)
(round (/ (expt (/ (+ 1 (sqrt 5)) 2) 1000) (sqrt 5)))
