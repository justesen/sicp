#lang sicp

; Exercise 2.42
;
; Complete the program by implementing the representation for sets of board
; positions, including the procedure adjoin-position, which adjoins a new
; row-column position to a set of positions, and empty-board, which represents
; an empty set of positions. You must also write the procedure safe?, which
; determines for a set of positions, whether the queen in the kth column is
; safe with respect to the others. (Note that we need only check whether the
; new queen is safe—the other queens are already guaranteed safe with respect
; to each other.)

(#%require "ch2.rkt")

; Okay, I think I made a pretty neat solution by representing the board as a
; list of row numbers of where the queens are placed. It's neat because a new
; queen can just be cons'ed to the front of the list, so you don't need to
; care about k in safe? and adjoin-positions.

(define empty-board nil)

(define (same-row? q r)
  (= q r))

(define (same-diagonal? q r c)
  (= (abs (- q r)) c))

(define (safe? k positions)
  (define (iter r c positions)
    (cond ((null? positions)
           #t)
          ((or (same-row? r (car positions))
               (same-diagonal? r (car positions) c))
           #f)
          (else
           (iter r (inc c) (cdr positions)))))
  (if (null? positions)
      #t
      (iter (car positions) 1 (cdr positions))))

(define (adjoin-position new-row k rest-of-queens)
  (cons new-row rest-of-queens))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions)
           (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position
                    new-row
                    k
                    rest-of-queens))
                 (enumerate-interval
                  1
                  board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

; Test
(equal? (queens 1) '((1))) ; 1 queen is safe from others
(equal? (queens 2) '())    ; 2 queens can't be safe from each other
(equal? (queens 3) '())    ; Nor 3
(= (length (queens 4)) 2)  ; But four queens can stand without attacking each other
