#lang sicp


; an interpreter is a procedure
; that evaluates a given expression
; evaluator/interpreter is just another program within a program

; evaluate subexpression -> apply


; Core of the evaluator

; EVAL
; Expression Environment -> ???

; primitive expression
; if number -> evalutate expression (already an atomic elemetn)
; if variables -> do lookup

; special forms (symbols)
; return expression that was quoted
; variable assignment/definition -> compute new value, update env
; lambda -> transform into applicative

#|
(define (eval exp env)
  (cond [(self-evaluating? exp) exp]
        [(variable?) ...] ;do a variable lookup
        [(quoted?) ...] ;return the quoted data itself
        [(assignment? exp) ...] ;evaluate the assignment
        [(definition? exp) ...] ;evalate the definition
        [(if? exp) ...] ; evaluate if
        [(lambda? exp) ...] ; create procedure obeject with parameter, body, and where it was created
        [(begin? ...)] ;evaluate sequence
        [(cond? exp) ...] ;evaluate condition
        [(application? exp)] ; apply the application
        [else ...] ;error
        )
  )
)


; Expression -> Boolean
; checks if the expression starts with 'quote
(define (quoted? exp)
  (equal? (car exp) 'quote)
  )

; Expression -> Boolean
; A Variable is a Symbol
; Checks if an expression is a variable
(define (variable? exp)
  (symbol? exp)
  )

; Acts as a type detector
(define (tagged-list? exp tag)
  0
  )


; Expression -> Boolean
; Checks if an expression is self-evaluating
; String and Number is self-evaluating, else its false
(define (self-evaluating? exp)
  (cond [(number? exp) exp]
        [(string? exp) exp]
        [else false])
  )

; list-of-values : ListOfExpressions × Environment -> ListOfValues
; evaluates each exps and env once
(define (list-of-values exps env)
  (if (null? exps)
      '()
      (cons (eval (car exps) env)
            (list-of-values (cdr exps) env)
            )
      )
  )
|#

; ===================================================================
; EVALUATION PROCEDURE
(define (eval-assignment exp env)
  0
  'ok)

(define (if-predicate exp) (cadr exp))
(define (if-consequent exp) (caddr exp))
(define (if-alternative exp) (cadddr exp))

(define (eval-if exp env)
  (cond [(eval (if-predicate exp) env) (eval (if-consequent exp) env)]
        [else (eval (if-alternative exp) env)])
  )


; Exercise 4.3
; eval in dispatch data-directed style
(define dispatch-table (list (cons 'self-evaluating (lambda (exp env) exp))
                             (cons 'quote (lambda (exp env) (cadr exp)))
                             (cons 'assignment eval-assignment)
                             (cons 'if eval-if)
                             )) ;add more for now this will do

; EXPRESSION TYPE CHECKER
(define (assignment? exp)
  (and (pair? exp) (equal? (car exp) 'set!))
  )

(define (self-evaluating? exp)
  (or (number? exp) (string? exp) (boolean? exp)))

(define (quoted? exp)
  (and (pair? exp) (eq? (car exp) 'quote)))

(define (if? exp)
  (equal? (car exp) 'if)
  )

(define (lookup-handler type)
  (let ((pair (assoc type dispatch-table)))
    (if pair (cdr pair) (error "Unknown expression type"))
    )
  )
(define (eval-lambda exp) 0)
(define (eval-definition exp) 0)

; GET EXPRESSION TYPE
(define (expression-type exp)
  (cond ((self-evaluating? exp) 'self-evaluating)
        ((quoted? exp) 'quote)
        ((assignment? exp) 'assignment)
        ((if? exp) 'if)
        (else 'application)))


(define (eval exp env)
  (let ((type (expression-type exp)))
    ((lookup-handler type) exp env)))

(eval '(if #f 42 99) 'some-env)