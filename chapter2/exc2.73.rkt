#lang sicp

 ; put/get are required for this exercise, even though they're not defined
 ; until chapter 3.
(#%require "../chapter3/ch3.rkt")

; Exercise 2.73

; Section 2.3.2 described a program that performs symbolic differentiation:
;
; (define (deriv exp var)
;   (cond ((number? exp) 0)
;         ((variable? exp)
;          (if (same-variable? exp var) 1 0))
;         ((sum? exp)
;          (make-sum (deriv (addend exp) var)
;                    (deriv (augend exp) var)))
;         ((product? exp)
;          (make-sum
;            (make-product
;             (multiplier exp)
;             (deriv (multiplicand exp) var))
;            (make-product
;             (deriv (multiplier exp) var)
;             (multiplicand exp))))
;         ⟨more rules can be added here⟩
;         (else (error "unknown expression type:
;                       DERIV" exp))))
;
; We can regard this program as performing a dispatch on the type of the
; expression to be differentiated. In this situation the “type tag” of the
; datum is the algebraic operator symbol (such as +) and the operation being
; performed is deriv. We can transform this program into data-directed style by
; rewriting the basic derivative procedure as

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var)
             1
             0))
        (else ((get 'deriv (operator exp))
               (operands exp)
               var))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

; 1. Explain what was done above. Why can’t we assimilate the predicates
;    number? and variable? into the data-directed dispatch?

; number?, same-variable? are predicates, so there's nothing to dispatch.

; 2. Write the procedures for derivatives of sums and products, and the
;    auxiliary code required to install them in the table used by the program
;    above.

; For sums:
(define (install-sum-package)
  ;; internal procedures
  (define (addend s) (car s))
  (define (augend s) (cadr s))
  (define (deriv-sum exp var)
    (make-sum (deriv (addend exp) var)
              (deriv (augend exp) var)))
  (define (make-sum x y)
    (list '+ x y))
  ;; interface to the rest of the system
  (put 'deriv '+ deriv-sum)
  (put 'make-sum '+ make-sum)
  'done)

(define (make-sum a1 a2)
  ((get 'make-sum '+) a1 a2))

; For products:
(define (install-product-package)
  ;; internal procedures
  (define (multiplier p) (car p))
  (define (multiplicand p) (cadr p))
  (define (deriv-product exp var)
    (make-sum
     (make-product
      (multiplier exp)
      (deriv (multiplicand exp) var))
     (make-product
      (deriv (multiplier exp) var)
      (multiplicand exp))))
  (define (make-product x y)
    (list '* x y))
  ;; interface to the rest of the system
  (put 'deriv '* deriv-product)
  (put 'make-product '* make-product)
  'done)

(define (make-product m1 m2)
  ((get 'make-product '*) m1 m2))

; Test
(install-sum-package)
(display (deriv '(+ x 2) 'x))
(newline)
(install-product-package)
(display (deriv '(* x 2) 'x))
(newline)

; 3. Choose any additional differentiation rule that you like, such as the one
;    for exponents (Exercise 2.56), and install it in this data-directed
;    system.

; Similar structure to those above
(define (install-exponent-package)
  ;; internal procedures
  (define (base e) (car e))
  (define (exponent e) (cadr e))
  (define (deriv-exponent exp var)
    (make-product
     (exponent exp)
     (make-exponent (base exp) (make-sum (exponent exp) -1))))
  (define (make-exponent x y)
    (list '** x y))
  ;; interface to the rest of the system
  (put 'deriv '** deriv-exponent)
  (put 'make-exponent '** make-exponent)
  'done)

(define (make-exponent b e)
  ((get 'make-exponent '**) b e))

; Test
(install-exponent-package)
(display (deriv '(* 2 (** x 3)) 'x))
(newline)

; 4. In this simple algebraic manipulator the type of an expression is the
;    algebraic operator that binds it together. Suppose, however, we indexed
;    the procedures in the opposite way, so that the dispatch line in deriv
;    looked like
;        ((get (operator exp) 'deriv)
;         (operands exp) var)
;    What corresponding changes to the derivative system are required?

; We just have to change the order of the arguments to put.
