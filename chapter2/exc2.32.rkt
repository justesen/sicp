#lang sicp

; Exercise 2.32
;
; We can represent a set as a list of distinct elements, and we can represent
; the set of all subsets of the set as a list of lists. For example, if the set
; is (1 2 3), then the set of all subsets is (() (3) (2) (2 3) (1) (1 3) (1 2)
; (1 2 3)). Complete the following definition of a procedure that generates the
; set of subsets of a set and give a clear explanation of why it works:

(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (subset) (cons (car s) subset)) rest)))))

(equal? '(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))
        (subsets '(1 2 3)))

; Once we have computed the subsets of the remainder of s, i.e.,
;   (() (3) (2) (2 3))
; we're missing all the subsets that 1 is a part of, hence, we add 1 to all the
; subsets.
