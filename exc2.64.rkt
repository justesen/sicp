#lang sicp

(#%require "ch2.rkt")

; Exercise 2.64
;
; The following procedure list->tree converts an ordered list to a balanced
; binary tree. The helper procedure partial-tree takes as arguments an integer
; n and list of at least n elements and constructs a balanced tree containing
; the first n elements of the list. The result returned by partial-tree is a
; pair (formed with cons) whose car is the constructed tree and whose cdr is
; the list of elements not included in the tree.

(define (list->tree elements)
  (car (partial-tree
        elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size
             (quotient (- n 1) 2)))
        (let ((left-result
               (partial-tree
                elts left-size)))
          (let ((left-tree
                 (car left-result))
                (non-left-elts
                 (cdr left-result))
                (right-size
                 (- n (+ left-size 1))))
            (let ((this-entry
                   (car non-left-elts))
                  (right-result
                   (partial-tree
                    (cdr non-left-elts)
                    right-size)))
              (let ((right-tree
                     (car right-result))
                    (remaining-elts
                     (cdr right-result)))
                (cons (make-tree this-entry
                                 left-tree
                                 right-tree)
                      remaining-elts))))))))

; 1. Write a short paragraph explaining as clearly as you can how partial-tree
;    works. Draw the tree produced by list->tree for the list (1 3 5 7 9 11).

; It takes (one less than) the first half of elts and creates a partial tree
;    from those. Now of the remaining elements not in left-tree, the first is
;    the root, and from the remaining elements we create the right partial
;    tree. Then we can simply construct the tree from left-tree, entry, and
;    right-tree. Note that the tree "leans right" due to the way the elements
;    are partitioned in left and right; the left half is rounded down.

;    5
;  /   \
; 3     9
;  \   /  \
;   1 7    11

; 2. What is the order of growth in the number of steps required by list->tree
;    to convert a list of n elements?

; T(n) = 2*T(n/2) + O(1), i.e., O(n) time.
