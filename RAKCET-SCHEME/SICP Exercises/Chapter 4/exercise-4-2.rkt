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
|#

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


; ===================================================================

; Exercise 4.2

; louis wants to reorder cond clauses in eval so the clause for precedure appears
; before the clause for assignments, so looks something like this

; answer: 
; louis assumption isn't always correct since you can never tell if a program can contain more application than assignments, definitions etc
; eval is a generalized evaluator program and it needs to work for any data types
; if we try to evaluate the following


; this means we put priority order to check for a application first
; for a application you need a function and argument to apply
; louis version might misclassify anything that looks like a list as procedure application
; and cause the evaluator to misinterpret the data type. It must first evaluate syntactic special forms before checking for application

; part b

(define (is-call? exp)
  (and (pair? exp)
       (equal? (car exp) 'call))
  
  )

(define (eval exp env)
  (cond [(self-evaluating? exp) exp]
        [(variable? exp) ...] ;do a variable lookup
        [(quoted? exp) ...] ;return the quoted data itself
        [(is-call? exp)  (apply (eval (call-operator exp) env)
                                (list-of-values (call-operands exp) env)) ] ; apply the application - MOVED TO TOP OF BEFORE ASSIGNMENT?
        [(assignment?  exp) (eval-assignment exp env)] ;evaluate the assignment
        [(definition? exp) (eval-definition exp env)] ;evalate the definition
        [(if? exp) ...] ; evaluate if
        [(lambda? exp) ...] ; create procedure obeject with parameter, body, and where it was created
        [(begin? exp) ...] ;evaluate sequence
        [(cond? exp) ...] ;evaluate condition
        [else ...] ;error
        )
  )