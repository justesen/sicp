#lang sicp

; Exercise 1.24
; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_thm_1.24
;
; Modify the timed-prime-test procedure of Exercise 1.22 to use fast-prime?
; (the Fermat method), and test each of the 12 primes you found in that
; exercise. Since the Fermat test has Θ(logn) growth, how would you expect the
; time to test primes near 1,000,000 to compare with the time needed to test
; primes near 1000? Do your data bear this out? Can you explain any discrepancy
; you find?

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime)
                       start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (square x) (* x x))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder
          (* base (expmod base (- exp 1) m))
          m))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n)
         (fast-prime? n (- times 1)))
        (else false)))

(define (prime? n)
  (fast-prime? n 10))

(define (search-for-primes start count)
  (define (iter x count)
    (cond ((= count 0) (newline))
          ((prime? x)  (timed-prime-test x)
                       (iter (+ x 2) (dec count)))
          (else        (iter (+ x 2) count))))
  (iter (if (= 0 (remainder start 2)) (inc start) start) count))

(search-for-primes 1000 3)
(search-for-primes 10000 3)
(search-for-primes 100000 3)
(search-for-primes 1000000 3)
(search-for-primes 10000000 3)
(search-for-primes 100000000 3)

; 1009 *** 24
; 1013 *** 10
; 1019 *** 10

; 10007 *** 12
; 10009 *** 12
; 10037 *** 14

; 100003 *** 17
; 100019 *** 17
; 100043 *** 19

; 1000003 *** 19
; 1000033 *** 20
; 1000037 *** 20

; 10000019 *** 24
; 10000079 *** 25
; 10000103 *** 26

; 100000007 *** 29
; 100000037 *** 28
; 100000039 *** 28

; It matches pretty well: Every time n increases by a factor 10, the runtime
; increases by a constant ~4ms.
