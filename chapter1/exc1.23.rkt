#lang sicp

; Exercise 1.23
; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_thm_1.23
;
; The smallest-divisor procedure shown at the start of this section does lots
; of needless testing: After it checks to see if the number is divisible by 2
; there is no point in checking to see if it is divisible by any larger even
; numbers. This suggests that the values used for test-divisor should not be 2,
; 3, 4, 5, 6, …, but rather 2, 3, 5, 7, 9, …. To implement this change, define
; a procedure next that returns 3 if its input is equal to 2 and otherwise
; returns its input plus 2. Modify the smallest-divisor procedure to use (next
; test-divisor) instead of (+ test-divisor 1). With timed-prime-test
; incorporating this modified version of smallest-divisor, run the test for
; each of the 12 primes found in Exercise 1.22. Since this modification halves
; the number of test steps, you should expect it to run about twice as fast. Is
; this expectation confirmed? If not, what is the observed ratio of the speeds
; of the two algorithms, and how do you explain the fact that it is different
; from 2?

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

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n)
         n)
        ((divides? test-divisor n)
         test-divisor)
        (else (find-divisor
               n
               (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (search-for-primes start count)
  (define (iter x count)
    (cond ((= count 0) (newline))
          ((prime? x)  (timed-prime-test x)
                       (iter (+ x 2) (dec count)))
          (else        (iter (+ x 2) count))))
  (iter (if (= 0 (remainder start 2)) (inc start) start) count))

(define (next n)
  (if (= n 2) 3 (+ n 2)))

(search-for-primes 1000 3)
(search-for-primes 10000 3)
(search-for-primes 100000 3)
(search-for-primes 1000000 3)
(search-for-primes 10000000 3)
(search-for-primes 100000000 3)

; 1009 *** 7 before 8
; 1013 *** 1 before 3
; 1019 *** 1 before 4
;
; 10007 *** 4 before 6
; 10009 *** 4 before 5
; 10037 *** 3 before 6
;
; 100003 *** 10 before 16
; 100019 *** 9 before 15
; 100043 *** 10 before 16
;
; 1000003 *** 26 before 42
; 1000033 *** 27 before 42
; 1000037 *** 30 before 43
;
; 10000019 *** 91 before 160
; 10000079 *** 88 before 147
; 10000103 *** 88 before 167
;
; 100000007 *** 222 before 511
; 100000037 *** 194 before 462
; 100000039 *** 228 before 485
;
; It matches pretty well. For smaller n it's less than a factor 2, and for the
; largest n it's a speedup of more than factor 2.
