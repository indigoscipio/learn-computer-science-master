#lang sicp

; =================== BASE EVALUATOR ===================
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp) (make-procedure (lambda-parameters exp)
                                       (lambda-body exp)
                                       env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type: EVAL" exp))))


; =================== EVAL LOGIC ===================

(define (apply procedure arguments)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure procedure arguments))
        ((compound-procedure? procedure)
         (eval-sequence
          (procedure-body procedure)
          (extend-environment
           (procedure-parameters procedure)
           arguments
           (procedure-environment procedure))))
        (else
         (error
          "Unknown procedure type: APPLY" procedure))))


; Procedure Argument
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values (rest-operands exps) env))))

; Evaluate If
(define (eval-if exp env)
  (if (true? (eval (if-predicate exp) env))
      (eval (if-consequent exp) env)
      (eval (if-alternative exp) env)))

; Eval sequence
(define (eval-sequence exps env)
  (cond ((last-exp? exps)
         (eval (first-exp exps) env))
        (else
         (eval (first-exp exps) env)
         (eval-sequence (rest-exps exps) env))))

; Eval Assignment
(define (eval-assignment exp env)
  (set-variable-value! (assignment-variable exp)
                       (eval (assignment-value exp) env)
                       env)
  'ok)

; Eval Definition
(define (eval-definition exp env)
  (define-variable! (definition-variable exp)
    (eval (definition-value exp) env)
    env)
  'ok)

; Boolean
(define (true? x) (not (eq? x false)))
(define (false? x) (eq? x false))

; Make-procedure
(define (make-procedure parameters body env)
  (list 'procedure parameters body env))
(define (compound-procedure? p)
  (tagged-list? p 'procedure))
(define (procedure-parameters p) (cadr p))
(define (procedure-body p) (caddr p))
(define (procedure-environment p) (cadddr p))

; =================== EVAL CHECKER & SELECTOR ===================

(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        (else false)))

(define (variable? exp) (symbol? exp))

(define (quoted? exp) (tagged-list? exp 'quote))
(define (text-of-quotation exp) (cadr exp))

(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))

(define (assignment? exp) (tagged-list? exp 'set!))
(define (assignment-variable exp) (cadr exp))
(define (assignment-value exp) (caddr exp))

(define (definition? exp) (tagged-list? exp 'define))
(define (definition-variable exp)
  (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))
(define (definition-value exp)
  (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda (cdadr exp)
                   ; formal parameters
                   (cddr exp)))) ; body

(define (lambda? exp) (tagged-list? exp 'lambda))
(define (lambda-parameters exp) (cadr exp))
(define (lambda-body exp) (cddr exp))

(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

(define (if? exp) (tagged-list? exp 'if))
(define (if-predicate exp) (cadr exp))
(define (if-consequent exp) (caddr exp))
(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))

(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))

(define (begin? exp) (tagged-list? exp 'begin))
(define (begin-actions exp) (cdr exp))

(define (last-exp? seq) (null? (cdr seq)))
(define (first-exp seq) (car seq))
(define (rest-exps seq) (cdr seq))

(define (sequence->exp seq)
  (cond ((null? seq) seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))))
(define (make-begin seq) (cons 'begin seq))

(define (application? exp) (pair? exp))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))

(define (cond? exp) (tagged-list? exp 'cond))
(define (cond-clauses exp) (cdr exp))
(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))
(define (cond-predicate clause) (car clause))
(define (cond-actions clause) (cdr clause))
(define (cond->if exp) (expand-clauses (cond-clauses exp)))
(define (expand-clauses clauses)
  (if (null? clauses)
      'false
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "ELSE clause isn't last: COND->IF"
                       clauses))
            (make-if (cond-predicate first)
                     (sequence->exp (cond-actions first))
                     (expand-clauses rest))))))


; A Binding is a (cons Symbol Any)
; example: (cons a 1)
(define binding0 (cons 'a 10))
(define binding1 (cons 'b 20))
(define binding2 (cons 'c 30))
(define binding3 (cons 'd 40))
(define binding4 (cons 'e 50))


; A Frame is (listof Binding)
; Frame = (list (cons a 1) (cons b 2) ...)
(define frame0 (list binding1 binding0))
(define frame1 (list binding3 binding2))
(define frame2 (list binding4))


; An Environment is (listof Frame)
; example: (list (cons a 1) (cons b 2) (cons c 3))
(define env0 (list frame2 frame1 frame0))

; extracts the enclosing environment of an env
(define (enclosing-environment env)
  (cdr env)
  )


; extracts the first frame of an environmne
(define (first-frame env)
  (car env)
  )

; Creates an empty environment
(define the-empty-environment '())

; Creates a new frame based on given variable and values
; assume variables and values are the same length
(define (make-frame variables values)
  ;(map (lambda (var val) (cons var val) ) variables values)

  ;recursive version
  (cond [(or (null? variables) (null? values)) '()]
        [else (cons (cons (car variables) (car values)) (make-frame (cdr variables) (cdr values))  ) ]
        )
  )

; extracts a list of variables from a given frame
; Frame -> List-of-Symbols
(define (frame-variables frame)
  (map car frame)
  )

; extracts a list of values from a given frame
; Frame -> List-of-Any
(define (frame-values frame)
  (map cdr frame)
  )


; Adds a new binding to a given frame
; Symbol Any Frame -> 'ok
(define (add-binding-to-frame! var val frame)
  (let ((new-binding (cons var val)))
    (set-cdr! frame (cons (car frame) (cdr frame)) )
    (set-car! frame new-binding)
    )
  )

; List-of-symbols List-of-any Environment -> MaybeEnvironment
; extendes a given environment with addition vars and vals
(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (error "var length and vars length does not match" vars vals)
      )
  )


; =====================================================

; Exercise 4.12
; abstracting what's common
; these 3 things have these in common
; 1. Traverse frames until finding the variable
; 2. Perform an action when found (return value, mutate value, add bindin)
; 3. Handle the "not found" case appropriately for each operation

;scans a frame from given var and returns a match binding
; returns Key-Value pair if found; false otherwise
; Symbol Frame -> MaybeFrame
(define (scan var frame)
  (assoc var frame)
  )

; abstracted version of scan-env
; Symbol Environment (Binding -> X) (() -> X) -> X
(define (traverse-env var env success-proc error-proc)
  (cond [(null? env) (error-proc)]
        [else (let* ((frame (first-frame env))
                     (result (scan var frame)) ; result is a frame
                     )
                (if result
                    (success-proc result)
                    (traverse-env var (enclosing-environment env) success-proc error-proc))
                )])
  )

; lookup-variable-value: symbol environment -> value or error
(define (lookup-variable-value var env)
  (define (success-proc binding)
    (cdr binding))

  ; Error procedure that takes no argument
  (define (error-proc)
    (error "Unbound variable"))
  
  (traverse-env var env success-proc error-proc)
  )

; Symbol Any Environment -> #void
(define (set-variable-value! var val env)
  (define (success-proc binding)
    (set-cdr! binding val) ) 

  ; Error procedure that takes no argument
  (define (error-proc)
    (error "Unbound variable"))
  
  (traverse-env var env success-proc error-proc)
  )

; Symbol Any Environment -> #void
(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (success-proc binding)
      (set-cdr! binding val))

    ; Error procedure that takes no argument
    (define (error-proc)
      (add-binding-to-frame! var val frame))

    (traverse-env var env success-proc error-proc)
    )
  )

; =====================================================

; Exercise 4.13

; Symbol Frame -> Frame (with the given binding removed)
(define (remove-binding var frame)
  (cond [(null? frame) '()] ;stop building the list
        [else (let ((first-frame (car frame)))
                (if (eq? var (car first-frame))
                    (remove-binding var (cdr frame))
                    (cons first-frame (remove-binding var (cdr frame)))
                    )
                )]
        ) 
  )

; make-unbound!: Symbol Environment -> #void
; Mutates env by removing var from its first frame (if present)
(define (make-unbound! var env)
  (let* ((frame (first-frame env))
         (vars (frame-variables frame))
         (vals (frame-values frame))
         (updated-list (enclosing-environment env))
         )
    (set-car! env (remove-binding var frame))
    )
  )

; =====================================================



(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))

(define (primitive-implementation proc) (cadr proc))

; A Procedure is a (list Symbol Procedure)
; Primitive Procedures is a list of procedures
(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cons)
        (list 'cons cons)
        (list 'car car)
        (list 'null? null?)
        )
  )


; Extracts the primitive procedure name  from primitive-procedures
; List-of-[List-of-Symbol Procedure] -> List-of-Symbols
(define (primitive-procedure-names)
  (map car primitive-procedures)
  )

; Extracts the function object of a primitive procedure list
; List-of-[List-of-Symbol Procedure] -> List-of-Procedures
(define (primitive-procedure-objects)
  (map (lambda (proc) (cadr proc) ) primitive-procedures)
  )

(define (setup-environment)
  (let ((initial-env (extend-environment (primitive-procedure-names)
                                         (primitive-procedure-objects)
                                         the-empty-environment)))
    (define-variable! 'true true initial-env)
    (define-variable! 'false false initial-env)
    initial-env))

(define the-global-environment (setup-environment))

(define apply-in-underlying-scheme apply)

(define (apply-primitive-procedure proc args)
  (apply-in-underlying-scheme (primitive-implementation proc) args)
  )

; ============== DRIVER LOOP ==============

(define input-prompt ";;; M-Eval input: ")
(define output-prompt ";;; M-Eval output: ")

(define (prompt-for-input string)
  (newline) (newline) (display string) (newline)
  )


(define (announce-output string)
(newline)(display string) (newline)
  )


(define (driver-loop)
  (prompt-for-input input-prompt)
  (let* ((input (read))
         (output (eval input the-global-environment) )
         )
    (announce-output output-prompt)
    (user-print output)
    (driver-loop)
    )
  )


(define (user-print object)
  (if (compound-procedure? object)
      (display (list 'compound-procedure (procedure-parameters object) (procedure-body object) '<procedure-env>))
      (display object))
  )


; =====================================================

; Exercise 4.16a

(define (lookup-variable-value.v2 var env)
  (define (env-loop env)
    
    (define (scan var frame)
      (assoc var frame)
      )

    (cond [(null? env) (error "Unbound variable")]
          [else (let* ((frame (first-frame env))
                       (result (scan var frame))
                       )
                  (if result
                      (if (eq? (cdr result) '*unassigned*)
                          (error "Unassigned variable")
                          (cdr result)
                          )
                      (lookup-variable-value.v2 var (cdr env))
                      )
                  )])
    
    )
  (env-loop env))


; Exercise 4.16b
; List-of-Expression -> List-of-Expression
;; Transforms a body containing internal defines into a single expression
;; using let + set! to simulate simultaneous variable creation.
(define (scan-out-defines proc-body)
  (define (filter l p)
    (cond [(null? l) '()]
          [(p (car l)) (cons (car l) (filter (cdr l) p))]
          [else (filter (cdr l) p)]
          )
    )

  (define (is-define? exp)
    (eq? (car exp) 'define))

  (define (not-is-define? exp)
    (not (eq? (car exp) 'define)))

  (let* ((defines (filter proc-body is-define?))
         (not-defines (filter proc-body not-is-define? ))
         )

    ; List-of-expr -> List-of-expr
    ; builds a list of defines with the variables unassigned
    (define (build-let defines)
      (map (lambda (define) (cons (cadr define) '*unassigned* ) ) defines)
      )

    ; List-of-expr -> List-of-expr
    (define (build-set! defines)
      (map (lambda (define) (list 'set! (cadr define) (caddr define))) defines )
      )

    ; Builds the final expression/transformation
    (list 'let (build-let defines) (append (build-set! defines) not-defines))
    
    )
  )
(scan-out-defines '((define x 5) (define y 6) (+ x y)))

;c answer
; we should put it inside make-procedure because everytime we make a new procedure,
; scna out defines automatically transform the procedure and it stays permanent

; but if we put it inside procedure bodyu
; everytime we want to xtract the procedure body the scan out defines gets called
; resulting in inefficient compilation


; =====================================================

; Exercise 4.17
; Diagrams of environment

; default sequential version
(lambda (x)
  (define a 1)
  (define b (+ a 2))
  (+ a b x))

; answer: 
; defines a unnamed lambda
; takes x as an argument
; Frame E1 exists inside this lambda
; so e1: {a = 1, b = (+ a 2), procedure body <+ a b x>}
; evaluates the body -> finds a -> 1
; finds b -> 3
; if we run it it will return 1 + 3 + x
; in here, the lambda holds everything, from parameter x to local defines
; for variable lookup, it happens in E1 since it holds all the variable

; version with let! and set!
; which has one extra frame
#|
(lambda <vars>
  (let ((u '*unassigned*)
        (v '*unassigned*))
    (set! u <e1>)
    (set! v <e2>)
    <e3>))
|#

; answer:
; inside this lamda it creates new frame E1
; E1 = <binds vars x = ..., let (...)>
; inside this let is another frame E2
; which binds u = unassigned
; v = unassigned
; and the body expression = set! u <e1> and set! v <e2> and <e3>
; which is evaluated inside this E2
; when evaluating e3 there is E1 (param x) and E2 (u and v)
; in the scanned version, lambda holds only the parameter vars
; the inner let creates a new closure that holds u and v
; variable lookup for E1 happens inside the let. if it want vars it gets from E1, if it wants u and v it borrows inside E2
; the extra frame is created because let is a syntactic sugar for lambda which  creates an additional frame/closure

; =====================================================

; Exercise 4.18

#|
(lambda <vars>
  (let ((u '*unassigned*)(v '*unassigned*))
    (let ((a <e1>) (b <e2>))
      (set! u <e1>)
      (set! v <e2>)
      <e3>
      )
    ))

(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)
|#

; answer
; y depends on dy
; dy repends on y
; this is a mutual recursion
; in the original textbook/code, this could still work because all variables  initially defined with *unassigned*
; then it uses set! to assign them to real values, which exists immediately.

; however in the 2nd version, (let inside let), when were defineing y, dy might not exist yet and could lead to unbound variable issue
; and breaks the  mutual recursion

; =====================================================

; Exercise 4.19

(let ((a 1))
  (define (f x)
    (define b (+ a x))
    (define a 5)
    (+ a b))
  (f 10))

; asnwer

; Ben's approach (top to bottom)
; evaluate let, creates new frame E1 that binds a = 1
; E1: {a:1, (f 10)}
; calls to (f10)
; when f 10 is evaluated it references a = 1 so the computation returns (+ 5 11) = 16


; Alyssa's approach
; evaluate let
; creates new frame E1 that binds a = 1
; E1: {a:1, (f 10)}
; calls to (f 10) inside E1

; We created another define /scope
; which is a named lambda of f that takes x
; new frame E2 is created, binds x = 10
; e2: {b: (+ a x) (a: 5 [not the old a, this is a new binding]) application: (+ a b)}
; both a and b exists but with unassigned value
; evaluate b first -> references a
; but a is not defined, returns error

; when is the new value of a visible?
; it is visible at definition time, but evaluated when there's something that calls/references a

; is b computed using the old a (1)? or the new (5)? or error?
; b's value returns an error because we are referencing the new a which is defined after b
; if we didn't define a it wold've referenced the old a (1)