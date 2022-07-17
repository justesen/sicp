#lang sicp

(#%require "exc3.03.rkt")

; Exercise 3.7
;
; Consider the bank account objects created by make-account, with the password
; modification described in Exercise 3.3. Suppose that our banking system
; requires the ability to make joint accounts. Define a procedure make-joint
; that accomplishes this. Make-joint should take three arguments. The first is
; a password-protected account. The second argument must match the password
; with which the account was defined in order for the make-joint operation to
; proceed. The third argument is a new password. Make-joint is to create an
; additional access to the original account using the new password. For
; example, if peter-acc is a bank account with password open-sesame, then
;
; (define paul-acc
;   (make-joint peter-acc
;               'open-sesame
;               'rosebud))
;
; will allow one to make transactions on peter-acc using the name paul-acc and
; the password rosebud. You may wish to modify your solution to Exercise 3.3 to
; accommodate this new feature.

; We can actually do this without modifying make-account by simply wrapping
; with another password checker:

(define (make-joint account password new-password)
  (define (dispatch pw m)
    (if (eq? pw new-password)
        (account password m)
        (lambda (m) "Incorrect password")))
  dispatch)

; Test
(define peter-acc (make-account 100 'peter))
((peter-acc 'peter 'withdraw) 10)
((peter-acc 'peter 'withdraw) 10)
(define paul-acc
  (make-joint peter-acc
              'peter
              'paul))
((paul-acc 'paul 'withdraw) 10)
((paul-acc 'peter 'withdraw) 10)
