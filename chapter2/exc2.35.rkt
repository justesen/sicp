#lang sicp

; Exercise 2.35
;
; Redefine count-leaves from 2.2.2 as an accumulation:

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op
                      initial
                      (cdr sequence)))))

(define (fringe x)
  (cond ((null? x) nil)
        ((not (pair? x)) (list x))
        (else (append (fringe (car x))
                      (fringe (cdr x))))))

(define (count-leaves t)
  (accumulate (lambda (x acc) (+ (length x) acc))
              0
              (map fringe t)))

; If we want to do it without fringe/length, we can use recursion:

(define (count-leaves-rec t)
  (accumulate +
              0
              (map (lambda (x)
                     (if (pair? x)
                         (count-leaves-rec x)
                         1))
                   t)))

; Test
(define tree (list 1 2 3 (list 8 9) (list 4 5 (list 6 7))))
(= (count-leaves tree) 9)
(= (count-leaves-rec tree) 9)
