#lang sicp

; Exercise 1.38
; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-12.html#%_thm_1.38
;
; In 1737, the Swiss mathematician Leonhard Euler published a memoir De
; Fractionibus Continuis, which included a continued fraction expansion for
; e−2, where e is the base of the natural logarithms. In this fraction, the N_i
; are all 1, and the D_i are successively 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, ….
; Write a program that uses your cont-frac procedure from Exercise 1.37 to
; approximate e, based on Euler’s expansion.

(define (cont-frac n d k)
  (define (rec i)
    (if (> i k)
        0
        (/ (n i) (+ (d i) (rec (inc i))))))
  (rec 1))

(define (approx-e k)
  (+ 2 (cont-frac (lambda (i) 1.0)
                  (lambda (i)
                    (let ((j (+ i 1)))
                      (if (= 0 (remainder j 3)) (* 2 (/ j 3)) 1)))
                  k)))

(approx-e 100)
