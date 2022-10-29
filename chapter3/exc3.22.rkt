#lang sicp

; Exercise 3.22
;
; Instead of representing a queue as a pair of pointers, we can build a queue
; as a procedure with local state. The local state will consist of pointers to
; the beginning and the end of an ordinary list. Thus, the make-queue procedure
; will have the form

(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))
    (define (set-front-ptr! x) (set! front-ptr x))
    (define (set-rear-ptr! x) (set! rear-ptr x))
    (define (empty?) (eq? front-ptr '()))
    (define (dispatch m)
      (cond ((eq? m 'empty-queue?)
             (empty?))
            ((eq? m 'front-queue)
             (if (empty?) (error "Empty") (car front-ptr)))
            ((eq? m 'insert-queue!)
             (lambda (x)
               (let ((new-pair (cons x '())))
                 (cond ((empty?) (set-front-ptr! new-pair) (set-rear-ptr! new-pair))
                       (else (set-cdr! rear-ptr new-pair) (set-rear-ptr! new-pair))))))
            ((eq? m 'delete-queue!)
             (cond ((empty?) (error "Empty"))
                   (else (set-front-ptr! (cdr front-ptr)))))))
    dispatch))

(define (empty-queue? q)
  (q 'empty-queue?))

(define (front-queue q)
  (q 'front-queue))

(define (insert-queue! q item)
  ((q 'insert-queue!) item)
  q)

(define (delete-queue! q)
  (q 'delete-queue!)
  q)

; Complete the definition of make-queue and provide implementations of the
; queue operations using this representation.

; The dispatch conditions are quite similar to the ones defined previously,
; except the argument queue is nor implicit; we just change front-ptr and
; rear-ptr themselves instead of it being a cons pair.

(define q (make-queue))
(insert-queue! q 'a)
(insert-queue! q 'b)
(front-queue q); a
(delete-queue! q)
(insert-queue! q 'c)
(insert-queue! q 'd)
(delete-queue! q)
(front-queue q); c
(delete-queue! q)
(front-queue q); d
(delete-queue! q)
(empty-queue? q); #t
