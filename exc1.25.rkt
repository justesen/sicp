#lang sicp

; Exercise 1.25
; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_thm_1.25
;
; Alyssa P. Hacker complains that we went to a lot of extra work in writing
; expmod. After all, she says, since we already know how to compute
; exponentials, we could have simply written

(define (expmod base exp m)
  (remainder (fast-expt base exp) m))

; Is she correct? Would this procedure serve as well for our fast prime tester?
; Explain.

; No. It's explained in footnote 46. The original expmod function never have to
; deal with numbers larger than m. Let's time for comparison:

(define (fast-expt b n)
  (cond ((= n 0)
         1)
        ((even? n)
         (square (fast-expt b (/ n 2))))
        (else
         (* b (fast-expt b (- n 1))))))

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

; 1009 *** 422
; 1013 *** 806
; 1019 *** 804

; It's obviously much slower.
