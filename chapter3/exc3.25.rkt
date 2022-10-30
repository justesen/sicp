#lang sicp

; Exercise 3.25
;
; Generalizing one- and two-dimensional tables, show how to implement a table
; in which values are stored under an arbitrary number of keys and different
; values may be stored under different numbers of keys. The lookup and insert!
; procedures should take as input a list of keys used to access the table.

; It took a while to really grok the layout of the tables, but I think I got it.

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records))
         (car records))
        (else (assoc key (cdr records)))))

(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup keys table)
      (if (or (null? keys) (null? table))
          #f
          (let ((sub (assoc (car keys) (cdr table))))
            (cond ((and sub (null? (cdr keys))) (cdr sub))
                  (sub (lookup (cdr keys) sub))
                  (else #f)))))
    (define (insert-remaining keys value)
      (if (null? (cdr keys))
          (cons (car keys) value)
          (cons (car keys) (list (insert-remaining (cdr keys) value)))))
    (define (insert! keys value table)
      (cond ((null? keys)
             (error "ran out of keys :("))
            ((null? table)
             (error "ran out of table :("))
            ((null? (cdr keys))
             (let ((record (assoc (car keys) (cdr table))))
               (if record
                   (set-cdr! record value)
                   (set-cdr! table (cons (cons (car keys) value) (cdr table))))))
            ((null? (cdr table))
             (set-cdr! table (list (insert-remaining keys value))))
            (else
             (let ((sub (assoc (car keys) (cdr table))))
               (if sub
                   (insert! (cdr keys) value sub)
                   (set-cdr! table (cons (insert-remaining keys value) (cdr table)))))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) (lambda (keys) (lookup keys local-table)))
            ((eq? m 'insert-proc!) (lambda (keys value) (insert! keys value local-table)))
            (else (error "Unknown operation:
                          TABLE" m))))
    dispatch))

(define population-table (make-table))
(define get (population-table 'lookup-proc))
(define put (population-table 'insert-proc!))

; Populate table (with populations)
(put '("DK" "Hovedstaden" "Copenhagen") 1500000)
(put '("DK" "Midtjylland" "Aarhus") 300000)
(put '("DK" "Hovedstaden" "Hillerød") 40000)
(put '("DK" "Hovedstaden" "Hillerød") 40001)
(put '("DE" "Bavaria" "Munich") 8000000)
(put '("DE" "Schleswig" "Flensburg") 30000)

; Test
(equal? (get '("DK" "Hovedstaden" "Copenhagen")) 1500000)
(equal? (get '("DK" "Midtjylland" "Aarhus")) 300000)
(equal? (get '("DK" "Hovedstaden" "Hillerød")) 40001)
(equal? (get '("DE" "Bavaria" "Munich")) 8000000)
(equal? (get '("DE" "Schleswig" "Flensburg")) 30000)
(equal? (get '("DK" "Schleswig" "Flensburg")) #f)
(equal? (get '("DK" "Hovedstaden" "Flensburg")) #f)
(equal? (get '("ESP" "Hovedstaden" "Flensburg")) #f)
