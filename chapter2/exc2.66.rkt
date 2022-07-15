#lang sicp

; Exercise 2.66
;
; Implement the lookup procedure for the case where the set-of-records of records is
; structured as a binary tree, ordered by the numerical values of the keys.

; It's very similar to element-of-set? for binary trees.

(define (lookup given-key set-of-records)
  (cond ((null? set-of-records)
         false)
        ((= given-key (key (entry set-of-records)))
          (entry set-of-records))
        ((< given-key (key (entry set-of-records)))
         (lookup
          given-key
          (left-branch set-of-records)))
        ((> given-key (key (entry set-of-records)))
         (lookup
          given-key
          (right-branch set-of-records)))))
