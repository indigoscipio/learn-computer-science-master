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
;(make-lambda '(x y) '((+ x y)))

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
;(let->combination '(let ((x 1) (y 2)) (+ x y)) )

; =========================================


; Exercise 4.7
; how a let* expression can be written as a set of nested let expression
; answer: we can do it since let only allows one binding we make another let that binds that binding inside this new one
; so each new nested let introduces new binding

(define (sequence->exp seq)
  (cond [(null? seq) '()] ; empty seq
        [(null? (cdr seq)) (car seq)] ; only one item
        [else (cons 'begin seq)]
        )
  )

; definitoin
;; let*->nested-lets: Expression -> Expression
;; Purpose: Convert a let* expression into a nested let expression.
(define (let*->nested-lets exp)
  (let* ((bindings (cadr exp))
         (body (sequence->exp (cddr exp)))
         )
    (cond [(null? bindings) body]
          [else (let ((first-binding (car bindings))
                      (rest-bindings (cdr bindings)))
                  (list 'let
                        (list first-binding)
                        (let*->nested-lets (list 'let* rest-bindings body )))
                  )
                ]
          )

    )
  )


; =========================================

#|
(define (let->combination exp)
  (let ((bindings (let-bindings exp))
        (body (let-body exp))
        )
    (cons (make-lambda (map car bindings) body) ; build the lambda expresion
          (map cadr bindings) ; apply the arugments
          )
    )
  )
|#


; exercise 4.8 - named let
; first element after 'let is a symbol, followed by bindings and body
; extract name, bindings, body
; build lambda procedure from bindings and body

; List-of-Symbols Expression -> Expression
;(define (make-lambda parameters body)
;  (cons 'lambda (cons parameters body)))

(define (let->combination.v2 exp)
  (cond [(symbol? (cadr exp)) (let* ((name (cadr exp))
                                     (bindings (caddr exp))
                                     (params (map car bindings))
                                     (values (map cadr bindings))
                                     (body (sequence->exp (cdddr exp)))
                                     )
                                (list (list 'lambda (list name) (cons name values) )
                                      (list 'lambda params body)
                                      )
                                )] ;named let
        [else (error "Not a named let" exp)] ;not named let
        )
  )
(let->combination.v2 '(let sum-n ((n 10) (acc 0))
                        (if (= n 0)
                            acc
                            (sum-n (- n 1) (+ n acc)))))



; =========================================

; Exercise 4.9
; List-of-Expression List-of-Ex-ression -> List-of-Expression
;; Purpose: Convert a 'while' expression into an equivalent recursive expression.

(define (while test body)
  ; local heper that takes body and build recursive expression
  (list 'let 'loop '()
        (list 'if
              test
              (cons 'begin (append body (list (list 'loop))))
              'done))

  ; handle the base case when test is false
  ; body is a proper expression
  )
(while '(< x 10) '(set! x (+ x 1)))


(define (for expr body)
  (let* ((init (car expr))
         (var (car init))
         (test (cadr expr))
         (update (caddr expr))
         )
    ; create a let that binds (var init)
    (list 'let (list (list var (cadr init)))
          ; define recursive loop
          (list 'let 'loop '()
                (list 'if test
                      ; if the test passes, do body -> update -> call loop
                      (cons 'begin (list body update (list 'loop)) )
                      ;else return 'done
                      'done
                      )
                )
          )
    )
  )
(for '((i 0) (< i 5) (set! i (+ i 1)))
  '(display i) )

