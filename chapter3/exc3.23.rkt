#lang sicp

; Exercise 3.23
;
; A deque (“double-ended queue”) is a sequence in which items can be inserted
; and deleted at either the front or the rear. Operations on deques are the
; constructor make-deque, the predicate empty-deque?, selectors front-deque and
; rear-deque, and mutators front-insert-deque!, rear-insert-deque!,
; front-delete-deque!, rear-delete-deque!. Show how to represent deques using
; pairs, and give implementations of the operations. All operations should
; be accomplished in Θ(1) steps.

; Each element in the deque is a node which consists of a pointer to the
; previous node and the next node and the inserted item. The deque then
; consists of a pointer to the first node (front-ptr) and the last node
; (rear-ptr). That way, we can insert both at the front and the back, and
; update the pointers of the second to first/last node.

; Node procedures
(define (new-node x)
  (list nil x nil))

(define (set-prev! node x)
  (set-car! node x))

(define (set-next! node x)
  (set-car! (cddr node) x))

(define (has-next? node)
  (not (null? (caddr node))))

(define (has-prev? node)
  (not (null? (car node))))

(define (next node)
  (caddr node))

(define (prev node)
  (car node))

(define (value node)
  (cadr node))

; Deque procedures
(define (front-ptr deque) (car deque))

(define (rear-ptr deque) (cdr deque))

(define (set-front-ptr! deque item)
  (set-car! deque item))

(define (set-rear-ptr! deque item)
  (set-cdr! deque item))

(define (empty-deque? deque)
  (null? (front-ptr deque)))

(define (make-deque)
  (cons '() '()))

(define (front-deque deque)
  (if (empty-deque? deque)
      (error "FRONT called with an
              empty deque" deque)
      (value (front-ptr deque))))

(define (rear-deque deque)
  (if (empty-deque? deque)
      (error "REAR called with an
              empty deque" deque)
      (value (rear-ptr deque))))

(define (front-insert-deque! deque item)
  (let ((new-front (new-node item)))
    (cond ((empty-deque? deque)
           (set-front-ptr! deque new-front)
           (set-rear-ptr! deque new-front)
           deque)
          (else
           (let ((current-front (front-ptr deque)))
             (set-prev! current-front new-front)
             (set-next! new-front current-front)
             (set-front-ptr! deque new-front)
             deque)))))

(define (rear-insert-deque! deque item)
  (let ((new-rear (new-node item)))
    (cond ((empty-deque? deque)
           (set-front-ptr! deque new-rear)
           (set-rear-ptr! deque new-rear)
           deque)
          (else
           (let ((current-rear (rear-ptr deque)))
             (set-next! current-rear new-rear)
             (set-prev! new-rear current-rear)
             (set-rear-ptr! deque new-rear)
             deque)))))

(define (front-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "DELETE! called with
                 an empty deque" deque))
        ((has-next? (front-ptr deque))
         (let ((current-front (front-ptr deque))
               (new-front (next (front-ptr deque))))
           (set-prev! new-front '())
           (set-front-ptr! deque new-front)
           deque))
        (else
         (set-front-ptr! deque '())
         (set-rear-ptr! deque '())
         deque)))

(define (rear-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "DELETE! called with
                 an empty deque" deque))
        ((has-prev? (rear-ptr deque))
         (let ((current-rear (rear-ptr deque))
               (new-rear (prev (rear-ptr deque))))
           (set-next! new-rear '())
           (set-rear-ptr! deque new-rear)
           deque))
        (else
         (set-front-ptr! deque '())
         (set-rear-ptr! deque '())
         deque)))

(define (print-deque deque)
  (define (iter node)
    (if (null? node)
        (newline)
        (begin (display (value node))
               (if (has-next? node) (display "<=>") nil)
               (iter (next node)))))
  (iter (front-ptr deque)))

; Test
(define q (make-deque))
(front-insert-deque! q 'a)
(print-deque q)
(front-insert-deque! q 'b)
(print-deque q)
(rear-insert-deque! q '1)
(print-deque q)
(rear-insert-deque! q '2)
(print-deque q)
(rear-deque q)
(front-deque q)
(front-delete-deque! q)
(print-deque q)
(front-delete-deque! q)
(print-deque q)
(front-delete-deque! q)
(print-deque q)
(front-delete-deque! q)
(print-deque q)
(rear-insert-deque! q '1)
(rear-insert-deque! q '2)
(rear-insert-deque! q '3)
(rear-insert-deque! q '4)
(print-deque q)
(rear-delete-deque! q)
(front-delete-deque! q)
(print-deque q)
