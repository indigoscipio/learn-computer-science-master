#lang sicp

; =================== BASE EVALUATOR ===================

 (define (eval exp env) ((analyze exp) env))


(define (analyze exp)
  (cond ((self-evaluating? exp) (analyze-self-evaluating exp))
        ((quoted? exp) (analyze-quoted exp))
        ((variable? exp) (analyze-variable exp))
        ((assignment? exp) (analyze-assignment exp))
        ((definition? exp) (analyze-definition exp))
        ((if? exp) (analyze-if exp))
        ((lambda? exp) (analyze-lambda exp))
        ((let? exp) (analyze-let exp))
        ((begin? exp) (analyze-sequence (begin-actions exp)))
        ((cond? exp) (analyze (cond->if exp)))
        ((application? exp) (analyze-application exp))
        (else (error "Unknown expression type: ANALYZE" exp))

        )
  )

; =================== ANALYZE ===================
; Analyze Self-Evaluating Expression
(define (analyze-self-evaluating exp)
  (lambda (env) exp))

; Checks if an expression is a type of 'let
(define (let? exp)
  (tagged-list? exp 'let)
  )

; Analyze Let Expression
(define (analyze-let exp)
  (let ((proc (analyze (let->lambda exp))))
    (lambda (env) (proc env))))

; Let to Lambda Transformation
(define (let->lambda exp)
  (let ((bindings (cadr exp))
        (body (cddr exp))
        )
    (cons (make-lambda (map car bindings) body) ; build the lambda expresion
          (map cadr bindings) ; apply the arugments
          )
    )
  )

(define (analyze-quoted exp)
  (let ((qval (text-of-quotation exp)))
    (lambda (env) qval)))

(define (analyze-variable exp)
  (lambda (env) (lookup-variable-value exp env)))

(define (analyze-assignment exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze (assignment-value exp))))
    (lambda (env)
      (set-variable-value! var (vproc env) env)
      'ok)))

(define (analyze-definition exp)
  (let ((var (definition-variable exp))
        (vproc (analyze (definition-value exp))))
    (lambda (env)
      (define-variable! var (vproc env) env)
      'ok)))

(define (analyze-if exp)
  (let ((pproc (analyze (if-predicate exp)))
        (cproc (analyze (if-consequent exp)))
        (aproc (analyze (if-alternative exp))))
    (lambda (env) (if (true? (pproc env))
                      (cproc env)
                      (aproc env)))))

(define (analyze-lambda exp)
  (let ((vars (lambda-parameters exp))
        (bproc (analyze-sequence (lambda-body exp))))
    (lambda (env) (make-procedure vars bproc env))))

(define (analyze-sequence exps)
  (define (sequentially proc1 proc2)
    (lambda (env) (proc1 env) (proc2 env)))
  (define (loop first-proc rest-procs)
    (if (null? rest-procs)
        first-proc
        (loop (sequentially first-proc (car rest-procs))
              (cdr rest-procs))))
  (let ((procs (map analyze exps)))
    (if (null? procs) (error "Empty sequence: ANALYZE"))
    (loop (car procs) (cdr procs))))

(define (analyze-application exp)
  (let ((fproc (analyze (operator exp)))
        (aprocs (map analyze (operands exp))))
    (lambda (env)
      (execute-application
       (fproc env)
       (map (lambda (aproc) (aproc env))
            aprocs)))))

(define (execute-application proc args)
  (cond ((primitive-procedure? proc)
         (apply-primitive-procedure proc args))
        ((compound-procedure? proc)
         ((procedure-body proc)
          (extend-environment
           (procedure-parameters proc)
           args
           (procedure-environment proc))))
        (else
         (error "Unknown procedure type: EXECUTE-APPLICATION"
                proc))))

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


(eval '(let ((x 3)) (+ x 5) ) the-empty-environment)