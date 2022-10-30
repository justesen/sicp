#lang sicp

; Exercise 3.24
;
; In the table implementations above, the keys are tested for equality using
; equal? (called by assoc). This is not always the appropriate test. For
; instance, we might have a table with numeric keys in which we don’t need an
; exact match to the number we’re looking up, but only a number within some
; tolerance of it. Design a table constructor make-table that takes as an
; argument a same-key? procedure that will be used to test “equality” of keys.
; Make-table should return a dispatch procedure that can be used to access
; appropriate lookup and insert! procedures for a local table.

; Add an extra parameter to assoc and make-table that tests for key equality.

(define (assoc key records same-key?)
  (cond ((null? records) false)
        ((same-key? key (caar records))
         (car records))
        (else (assoc key (cdr records) same-key?))))

(define (make-table same-key?)
  (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable
             (assoc key-1 (cdr local-table) same-key?)))
        (if subtable
            (let ((record
                   (assoc key-2
                          (cdr subtable)
                          same-key?)))
              (if record (cdr record) false))
            false)))
    (define (insert! key-1 key-2 value)
      (let ((subtable
             (assoc key-1 (cdr local-table) same-key?)))
        (if subtable
            (let ((record
                   (assoc key-2
                          (cdr subtable)
                          same-key?)))
              (if record
                  (set-cdr! record value)
                  (set-cdr!
                   subtable
                   (cons (cons key-2 value)
                         (cdr subtable)))))
            (set-cdr!
             local-table
             (cons (list key-1
                         (cons key-2 value))
                   (cdr local-table)))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation:
                          TABLE" m))))
    dispatch))

(define (same-key? key1 key2) (< (abs (- key1 key2)) 0.2))
(define operation-table (make-table same-key?))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

; Test
(put 3.0 2.1 'a)
(put 4.0 2.1 'b)
(put 5.0 2.1 'c)
(put 6.0 2.1 'd)
(eq? (get 2.9 2) 'a)
(put 3.0 2.1 'e)
(eq? (get 2.9 2) 'e)

