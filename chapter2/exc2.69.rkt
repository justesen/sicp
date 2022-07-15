#lang sicp

(#%require "ch2.rkt")
(#%provide generate-huffman-tree)

; Exercise 2.69
;
; The following procedure takes as its argument a list of symbol-frequency
; pairs (where no symbol appears in more than one pair) and generates a Huffman
; encoding tree according to the Huffman algorithm.

(define (generate-huffman-tree pairs)
  (successive-merge
   (make-leaf-set pairs)))

; Make-leaf-set is the procedure given above that transforms the list of pairs
; into an ordered set of leaves. Successive-merge is the procedure you must
; write, using make-code-tree to successively merge the smallest-weight
; elements of the set until there is only one element left, which is the
; desired Huffman tree. (This procedure is slightly tricky, but not really
; complicated. If you find yourself designing a complex procedure, then you are
; almost certainly doing something wrong. You can take significant advantage of
; the fact that we are using an ordered set representation.)

; We just make a tree of the two leaves/trees with lowest weight, (car set) and
; (cadr set), and adjoin that to the remaining leaves/trees (that have higher
; weights). Then we call successive-merge recursively on this result until
; there's only one tree left in the set.

(define (successive-merge set)
  (if (null? (cdr set))
      (car set)
      (successive-merge
        (adjoin-set-h
          (make-code-tree (car set) (cadr set))
          (cddr set)))))

; Test
(define sample-tree
  (make-code-tree
   (make-leaf 'A 4)
   (make-code-tree
    (make-leaf 'B 2)
    (make-code-tree
     (make-leaf 'D 1)
     (make-leaf 'C 1)))))

(equal? sample-tree
        (generate-huffman-tree '((A 4) (B 2) (C 1) (D 1))))
