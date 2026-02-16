#lang sicp

; =====================================================

; Exercise 4.11


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


(define (tagged-list? exp tag)
  (and (pair? exp) (eq? (car exp) tag)))


(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))

(define (compound-procedure? p)
  (tagged-list? p 'procedure))

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

;; procedure-parameters: CompoundProcedure -> [Listof Symbol]
;; Returns the list of parameter names for the procedure.
(define (procedure-parameters proc)
  (cadr proc))  ; second element is parameters


;; procedure-body: CompoundProcedure -> Expression or [Listof Expression]
;; Returns the body expression(s) of the procedure.
(define (procedure-body proc)
  (caddr proc)) ; third element is body

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

; Exercise 4.14

; louis installs map as a primitive procedure
; when he tries it it goes terribly wrong
; why does louis's map fail but eva works?

; answer
; I'm guessing because eva defines the procedure as compound it works
; louis map doesn't work because he defines it as primitive proc

; when eva's map gets evaluated, itts being fed into eval
; and eval finds the map as a compound procedure and works normally
; finds the parameters -> evaluate the body and environment, etc.

; =====================================================

; Exercise 4.15

; p = argumnent
; a = object
; p halts on a if evaluating the expression (p a) returns a value
; as opposed to terminating to an error message or running forever

(define (run-forever) (run-forever))
(define (try p)
  ; does p halts when it runs on itself?
  (if (halts? p p)
      (run-forever)
      'halted
      )
  )

; assume halts is a magical procedure that always predict wheter a program halts

; we are building run forever and try to break this assumption

; case 1: assume halts? says it halts
; this would go into the run forever clause, contradicting the purpose

; case2: assume halts? doesn't halts
; in this case it would go to the 'halted block, contradicting the purpose

; in both cases are contradictory and therefore it cannot exist