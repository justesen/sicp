#lang sicp

; Exercise 3.4
;
; Modify the make-account procedure of Exercise 3.3 by adding another local
; state variable so that, if an account is accessed more than seven consecutive
; times with an incorrect password, it invokes the procedure call-the-cops.

(define (call-the-cops)
  "Cops called!")

(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance
                     (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request:
                 MAKE-ACCOUNT" m))))
  (define calls-with-incorrect-password 0)
  (define (check-password pw m)
    (cond ((eq? pw password)
           (set! calls-with-incorrect-password 0)
           (dispatch m))
          ((< calls-with-incorrect-password 6)
           (set! calls-with-incorrect-password (+ 1 calls-with-incorrect-password))
           (lambda (m) "Incorrect password"))
          (else (lambda (m) (call-the-cops)))))
  check-password)

; Test
(define acc
  (make-account 100 'secret-password))

((acc 'secret-password 'withdraw) 40)
; 60

((acc 'some-other-password 'deposit) 50)
; "Incorrect password"

((acc 'secret-password 'deposit) 40)
; 100

((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
