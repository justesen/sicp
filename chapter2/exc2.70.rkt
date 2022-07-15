#lang sicp

(#%require "exc2.68.rkt")
(#%require "exc2.69.rkt")

; Exercise 2.70
;
; The following eight-symbol alphabet with associated relative frequencies was
; designed to efficiently encode the lyrics of 1950s rock songs. (Note that the
; “symbols” of an “alphabet” need not be individual letters.)
;
; A    2    NA  16
; BOOM 1    SHA  3
; GET  2    YIP  9
; JOB  2    WAH  1
;
; Use generate-huffman-tree (Exercise 2.69) to generate a corresponding Huffman
; tree, and use encode (Exercise 2.68) to encode the following message:
;
; Get a job
; Sha na na na na na na na na
;
; Get a job
; Sha na na na na na na na na
;
; Wah yip yip yip yip
; yip yip yip yip yip
; Sha boom
;
; How many bits are required for the encoding? What is the smallest number of
; bits that would be needed to encode this song if we used a fixed-length code
; for the eight-symbol alphabet?

; Okay, let's define the words as a list of symbols,

(define words
  '(GET A JOB
        SHA NA NA NA NA NA NA NA NA
        GET A JOB
        SHA NA NA NA NA NA NA NA NA
        WAH YIP YIP YIP YIP
        YIP YIP YIP YIP YIP
        SHA BOOM))

; then compute the symbol-frequency pairs,

(define (symbol-freq-pairs words)
  (define (add word pairs)
    (cond ((null? pairs)
           (cons (list word 1) pairs))
          ((eq? word (caar pairs))
           (cons (list word (+ 1 (cadar pairs))) (cdr pairs)))
          (else
           (cons (car pairs) (add word (cdr pairs))))))
  (define (iter words pairs)
    (if (null? words)
        pairs
        (iter (cdr words)
              (add (car words) pairs))))
  (iter words '()))

; and generate the Huffman tree.

(define huf-tree (generate-huffman-tree (symbol-freq-pairs words)))

; The encoding requires
(length (encode words huf-tree))
; 84 bits. If we had used a fixed-length code, we would three bits per symbol
; and there are 36 words in the lyrics, i.e., 3*36 = 108 bits.
