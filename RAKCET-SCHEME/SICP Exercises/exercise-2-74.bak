#lang racket


;Exercise 2.73
;; Operation, type -> procedure
; make-hash creates a new mutable hash table
(define *op-table* (make-hash))


;; put : op type proc -> Void
;; store proc under key (list op type)
; hash-set! mutates the table
(define (put op type proc)
  (hash-set! *op-table* (list op type) proc))     


;; get : op type -> proc or #f
;; retrieve the procedure stored under (list op type)
; hash-ref looks up a key, returns default #f if absent
(define (get op type)
  (hash-ref *op-table* (list op type) #f))

; Any -> Boolean
(define (variable? x)
  (symbol? x)
  )

; Variable Variable -> Booleab
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2) )
  )

 (define (=number? exp num) (and (number? exp) (= exp num)))

; Number Number -> Sum
; A sum is a List-of-[Symbol Number Number]
(define (make-sum a1 a2)
  (cond [(=number? a1 0) a2]
        [(=number? a2 0) a1]
        [(and (number? a1) (number? a1)) (+ a1 a2)]
        [else (list '+ a1 a2 )]
        )
  )

;Number Number -> Product
; A product is a List-of-[Symbol Number Number]
(define (make-product m1 m2)
  (cond [(or (=number? m1 0) (=number? m2 0) ) 0]
        [(=number? m1 1) m2]
        [(=number? m2 1) m1]
        [(and (number? m1) (number? m2)) (* m1 m2) ]
        [else (list '* m1 m2)]
        )
  )

; Any -> Boolean
(define (sum? x)
  (and (pair? x) (equal? (car x) '+) )
  )

; Sum -> Number
; extracts the addend of a sum
(define (addend s)
  (cadr s))

;Sum -> Number
; extracts the augend of a sum
(define (augend s)
  (caddr s))


; Any -> Boolean
; A product is a list whose first element is the symbol *
(define (product? x)
  (and (pair? x) (equal? (car x) '*) )
  )

; Product -> Number
;A multiplier is the second item of the product list:
(define (multiplier p) (cadr p))

; Product -> Number
;A multiplicand is the third item of the product list
(define (multiplicand p) (caddr p))

; Number Number -> Exponent
(define (make-exponentiation base exp)
  (cond [(=number? exp 0) 1]
        [(=number? exp 1) base]
        [else (list '** base exp) ]
        )
  )

; Exponentiation -> Number
; A base is the second item of an exponentiation
(define (exponentiation-base e)
  (cadr e)
  )

; An exp is the third item of an exponentiation
(define (exponentiation-exp e)
  (caddr e)
  )

; Exponent -> Boolean
; Checks if and expression is an Exponent
; An exponent is a list whose first element is the symbol **
(define (exponentiation? x)
  (and (pair? x) (equal? (car x) '**) )
  )
;(exp? (make-exp 2 8))

; original deriv
#|
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum (make-product
                    (multiplier exp)
                    (deriv (multiplicand exp) var))
                   (make-product
                    (deriv (multiplier exp) var)
                    (multiplicand exp))))
        ;⟨more rules can be added here⟩
        (else (error "unknown expression type:
 DERIV" exp))))
|#

; Exercise 2.73
;rewritten version in dispatch style programming
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp))
               (operands exp) var))))






; Part a
; becaue number and symbol is primitive values, they don't have operators like (list '+ x y), so its the same

;part b.
; differntiate a +
(define (deriv-sum operands var)
  (make-sum (deriv (car operands) var)
            (deriv (cadr operands) var)))

; differentiate a *
(define (deriv-mul operands var)
  (let ((u (car operands))
        (v (cadr operands))
        )
    (make-sum (make-product u (deriv v var))
              (make-product (deriv u var) v)
              )
    )
  )

; new exponent operation
(define (deriv-exp operands var)
  (let ((u (car operands)) ; base
        (n (cadr operands))) ; exponent
    (make-product n
                  (make-product (make-exponentiation u (- n 1))
                                (deriv u var)))))


; part d
;  ((get (operator exp) 'deriv) (operands exp) var)

;; put : op type proc -> Void
;; store proc under key (list op type)
; hash-set! mutates the table

;; get : op type -> proc or #f

; we would need to change how get works because since we currently it takes op and type
; since we swapped into type and op get gives an error
; additionally we will also need to change put since it right now it takes op type proc
