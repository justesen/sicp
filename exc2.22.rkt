#lang sicp

; Exercise 2.22
;
; Louis Reasoner tries to rewrite the first square-list procedure of Exercise
; 2.21 so that it evolves an iterative process:

(define (square x) (* x x))

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items nil))

; Unfortunately, defining square-list this way produces the answer list in the
; reverse order of the one desired. Why?

; Because the new elements are cons'ed to the front of the list, as the list is
; iterated over.

; Louis then tries to fix his bug by interchanging the arguments to cons:

(define (iter things answer)
  (if (null? things)
      answer
      (iter (cdr things)
            (cons answer
                  (square
                    (car things))))))

(define (square-list-alt items)
  (iter items nil))

; This doesn’t work either. Explain.

; The list is cons'ed up the opposite way:

(iter '(1 2 3 4) nil)
(iter '(2 3 4) (cons nil 1))
(iter '(3 4) (cons (cons nil 1) 2))
(iter '(4) (cons (cons (cons nil 1) 2) 4))
(iter '() (cons (cons (cons (cons nil 1) 4) 9) 16))

; Where we want a list with the structure

(cons 1 (cons 4 (cons 9 (cons 16 nil))))
