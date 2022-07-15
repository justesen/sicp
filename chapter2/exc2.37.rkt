#lang sicp

; Exercise 2.37
;
; Suppose we represent vectors v = (v_i) as sequences of numbers, and matrices m
; = (m_ij) as sequences of vectors (the rows of the matrix). For example, the
; matrix
;     1 2 3 4
;     4 5 6 6
;     6 7 8 9
; is represented as the sequence ((1 2 3 4) (4 5 6 6) (6 7 8 9)). With this
; representation, we can use sequence operations to concisely express the basic
; matrix and vector operations. These operations (which are described in any
; book on matrix algebra) are the following[...]
;
; We can define the dot product as

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op
                      initial
                      (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

; Fill in the missing expressions in the following procedures for computing the
; other matrix operations. (The procedure accumulate-n is defined in Exercise
; 2.36.)

(define (matrix-*-vector m v)
  (map (lambda (u) (dot-product u v)) m))

(define (transpose mat)
  (accumulate-n cons nil mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (v) (matrix-*-vector cols v)) m)))

; Test
(define m (list (list 1 2 3 4) (list 4 5 6 6) (list 6 7 8 9)))
(define v (list 2 0 1 1))
(equal? (matrix-*-vector m v) (list (+ 2 0 3 4) (+ 8 0 6 6) (+ 12 0 8 9)))
(define n (transpose m))
(equal? n (list (list 1 4 6) (list 2 5 7) (list 3 6 8) (list 4 6 9)))
(define o (matrix-*-matrix m n))
(equal? o (list (list 30 56 80)
                (list 56 113 161)
                (list 80 161 230)))
