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

; Exercise 4.1

; we can't tell if the metacircular evaluator evaluates operands from L -> R or R -> L

; evaluates operands from left to right regardless of what order of evaluation in the underlying lisp
(define (list-of-values.v2 exps env)
  ;evaluate each operand first in the order
  ; build the list from those values
  ; acc stores the list of values evaluated so far
  (define (iter expressions acc)
    (cond [(null? expressions) acc] ; no more expressions to evaluate, return acc
          [else (iter (cdr expressions) (cons (eval (car expressions) env) acc)) ]
        )
    )
  ; don't mix evaluation and list construction inside a single cons
  (reverse (iter exps '()))
  )



; list-of-values that evaluates operands from right to left
; evaluate the rest of the operands first, then evaluate the current operand after that
(define (list-of-values-RTL exps env)
  (if (null? exps)
      ; reaches all the way down, evaluate the current expression
      '()
      ; eval the rest of the list
      (append (list-of-values-RTL (cdr exps) env)
              (list (eval (car exps)) env) 
              )
      )
  )

(define (list-of-values-RTL.v2 exps env)
    (foldr (lambda (exp acc) (append acc (list (eval exp env))) ) '() exps)
  )