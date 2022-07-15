#lang sicp

(#%require "ch2.rkt")
(#%provide encode)

; Exercise 2.68
;
; The encode procedure takes as arguments a message and a tree and produces the
; list of bits that gives the encoded message.

(define (encode message tree)
  (if (null? message)
      '()
      (append
       (encode-symbol (car message)
                      tree)
       (encode (cdr message) tree))))

; Encode-symbol is a procedure, which you must write, that returns the list of
; bits that encodes a given symbol according to a given tree. You should design
; encode-symbol so that it signals an error if the symbol is not in the tree at
; all. Test your procedure by encoding the result you obtained in Exercise 2.67
; with the sample tree and seeing whether it is the same as the original sample
; message.

(define (encode-symbol symbol tree)
  (cond ((leaf? tree)
         '())
        ((element-of-set? symbol (symbols (left-branch-h tree)))
         (cons 0 (encode-symbol symbol (left-branch-h tree))))
        ((element-of-set? symbol (symbols (right-branch-h tree)))
         (cons 1 (encode-symbol symbol (right-branch-h tree))))
        (else (error "Symbol " symbol " is not in tree"))))

; Test
(define sample-tree
  (make-code-tree
   (make-leaf 'A 4)
   (make-code-tree
    (make-leaf 'B 2)
    (make-code-tree
     (make-leaf 'D 1)
     (make-leaf 'C 1)))))

(equal? (encode '(A D A B B C A) sample-tree)
        '(0 1 1 0 0 1 0 1 0 1 1 1 0))
