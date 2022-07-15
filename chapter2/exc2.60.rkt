#lang sicp

; Exercise 2.60
;
; We specified that a set would be represented as a list with no duplicates.
; Now suppose we allow duplicates. For instance, the set {1,2,3} could be
; represented as the list (2 3 2 1 3 2 2). Design procedures element-of-set?,
; adjoin-set, union-set, and intersection-set that operate on this
; representation. How does the efficiency of each compare with the
; corresponding procedure for the non-duplicate representation? Are there
; applications for which you would use this representation in preference to the
; non-duplicate one?

; element-of-set? and intersection-set can be used as already defined.

; For adjoin-set we can just cons. Takes O(1) time, cf. O(n) before.
(define (adjoin-set x set)
  (cons x set))

; For union-set we can just append. Takes time O(|set1|), cf. O(|set1|x(|set1|
; + |set2|)) before.
(define (union-set set1 set2)
  (append set1 set2))

; This implementation is faster if we don't expect many duplicates or if we do
; few element-of-set? operations.
