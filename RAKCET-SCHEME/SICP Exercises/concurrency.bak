#lang sicp

(define (for-each-except exception procedure list)
  (define (loop items)
    (cond ((null? items) 'done)
          ((eq? (car items) exception) (loop (cdr items)))
          (else (procedure (car items))
                (loop (cdr items)))))
  (loop list))

(define (make-connector)
  (let ((value false) (informant false) (constraints '()))

    (define (has-value?)
      informant
      )
    
    (define (set-my-value newval setter)
      (cond ((not (has-value? me))
             (set! value newval)
             (set! informant setter)
             (for-each-except setter
                              (lambda (c) (c 'I-have-a-value))
                              constraints))
            ((not (= value newval))
             (error "Contradiction" (list value newval)))
            (else 'ignored)))
    (define (forget-my-value retractor)
      (if (eq? retractor informant)
          (begin (set! informant false)
                 (for-each-except retractor
                                  (lambda (c) (c 'I-lost-my-value))
                                  constraints))
          'ignored))
    (define (connect new-constraint)
      (if (not (memq new-constraint constraints))
          (set! constraints
                (cons new-constraint constraints)))
      (if (has-value? me)
          ((lambda (c) (c 'I-have-a-value)) new-constraint))
      'done)
    (define (me request)
      (cond ((eq? request 'has-value?)
             (if informant true false))
            ((eq? request 'value) value)
            ((eq? request 'set-value!) set-my-value)
            ((eq? request 'forget) forget-my-value)
            ((eq? request 'connect) connect)
            (else (error "Unknown operation: CONNECTOR"
                         request))))
    me))


;Exercise 3.36
(define a (make-connector))
(define b (make-connector))
(set-value! a 10 'user)

; At sometime during evaluation of the set-value!, the fol
; lowing expression from the connector’s local procedure is
; evaluated:
(for-each-except setter inform-about-value constraints)

;answer
; defina a (make-connector)
; returns me, a dispatch procedure - gets evaluated and stores it in global env
; global env: a -> dispatch proc
; a's closure: {value: false, informant: valse, constraints: '()}

; define b (make-connector)
; returns me; a dispatch procedure simila to a but with different closure
; b's closure: {value: false, informant: valse, constraints: '()}

; (set-value! a 10 'user)
; evaluates to (me request)
; Creates new frame (lets say E1 that binds request = 'set-value!)
; E1 : request = 'set-value!
; returns the procedure set-my-value which expects 2 args

; Then inside of set-my-value
; new E2 frame is created that binds the argument as the new value
; it binds newval = 10 and 'user = setter
; evaluates the conditionals (not (has-value? me))
; current me (in this case a has no value eg false) - evaluates to true
; inside this clause, 3 things are run:
; 1. (set! value newval) - sets a's connector value to new value (false to 10)
; 2. (set! informant setter) - sets a's connector informant as the setter (false to 'user)
; 3. (for-each-except setter (for-each-except setter inform-about-value constraints))
; this informs the other constraints except the current setter that the value has been updated

(define (celcius-fahrenheit-converter x)
  (c+ (c* (c/ (cv 9) (cv 5) ))
      (cv 32))
)

(define C (make-connector))
(define F (calcius-fahrenheit-converter C))

; constraints: c+, c*, c/

; Connector Connector -> Connector
(define (c+ x y)
  (let ((z (make-connector)))
    (adder x y z)
      z
    )
  )


(define (c- x y)
  (let ((z (make-connector)))
    (subtractor x y z)
      z
    )
  )


(define (c/ x y)
  (let (z (make-connector)))
  (divider x y z)
  z
  )

(define (cv n)
  (let ((z (make-connector)))
    (constant n z)
    z
    )
  )