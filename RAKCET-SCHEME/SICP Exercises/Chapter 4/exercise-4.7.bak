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

; =========================================

; Exercise 4.6

;(define (let? exp) (tagged-list? exp 'let)) ;wtf is tagged list?

; List-of-Symbols Expression -> Expression
(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))
(make-lambda '(x y) '((+ x y)))

(define (let-bindings exp) (cadr exp))
(define (let-body exp) (cddr exp))

(define (let->combination exp)
  (let ((bindings (let-bindings exp))
        (body (let-body exp))
        )
    (cons (make-lambda (map car bindings) body) ; build the lambda expresion
          (map cadr bindings) ; apply the arugments
          )
    )
  )
(let->combination '(let ((x 1) (y 2)) (+ x y)) )

; =========================================

; Exercise 4.7
; how a let* expression can be written as a set of nested let expression
; we can do it since let only allows one binding we make another let that binds that binding inside this new one


(define (let*->nested-lets exp)
  
  )