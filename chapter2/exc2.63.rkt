#lang sicp

(#%require "ch2.rkt")

; Exercise 2.63
;
; Each of the following two procedures converts a binary tree to a list.

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append
       (tree->list-1
        (left-branch tree))
       (cons (entry tree)
             (tree->list-1
              (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list
         (left-branch tree)
         (cons (entry tree)
               (copy-to-list
                (right-branch tree)
                result-list)))))
  (copy-to-list tree '()))

; 1. Do the two procedures produce the same result for every tree? If not, how
;    do the results differ? What lists do the two procedures produce for the
;    trees in Figure 2.16?

; Both procedures produce the same results. Here we test that:

(define t
  (make-tree 7
            (make-tree 3
                        (make-tree 1 '() '())
                        (make-tree 5 '() '()))
            (make-tree 9
                        '()
                        (make-tree 11 '() '()))))

(display (tree->list-1 t))
(newline)
(display (tree->list-2 t))
(newline)

; For the other trees we also get the result (1 3 5 7 9 11).

; 2. Do the two procedures have the same order of growth in the number of steps
;    required to convert a balanced tree with n elements to a list? If not,
;    which one grows more slowly?

; The first one uses O(n) time in each recursive step to make the append, i.e.,
;     T(n) = O(n) + 2*T(n/2)
; and we get log(n) recursive calls (since we do half the work), therefore
; O(n log n).

; The second one is iterative and takes time
;     T(n) = O(1) + 2*T(n/2),
; therefore O(n).
