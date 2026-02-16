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

(define (set-value! connector new-value informant)
  ((connector 'set-value!) new-value informant))

(define a (make-connector))
(a 'has-value?)
(set-value! a 5 'user)



#|
; Exercise 3-33
;; averager : Connector Connector Connector -> Constraint-Network
;; connects a, b, and avg such that avg = (a + b) / 2
(define (averager a b avg)
  (define (process-new-value)
    (cond [(and (has-value? a) (has-value? b)) (set-value! avg (/ (+ (get-value a) (get-value b)) 2) me)] ; a and b has values
          [(and (has-value? a) (has-value? avg)) (set-value! b (* 2 (- (get-value avg) (get-value a))) me)] ; a and avg has values
          [(and (has-value? b) (has-value? avg)) (set-value! a (* 2 (- (get-value avg) (get-value b) )) me)] ; b and avg has value
          )

    )

  (define (process-forget-value)
    (forget-value! a me)
    (forget-value! b me)
    (forget-value! avg me)
    (process-new-value)
    )

  
  (define (me request)
    (cond [(eq? request 'I-have-a-value) (process-new-value)]
          [(eq? request 'I-lost-my-value) (process-forget-value)]
          [else (error "Unknown Operation AVERAGER" request)]
          )
    )

  (connect a me)
  (connect b me)
  (connect avg me)
  me
  )
|#


; Exercise 3.34
(define (squarer a b)
  (multiplier a a b))

; There is a serious flaw in this idea. Explain.
; answer:
; The multiplier constraint expects three distinct connectors: two inputs and one output.
; In (multiplier a a b), we're passing the same connector 'a' twice.
; This works fine when 'a' is known: the system can compute b = a * a.
; But if we try to set 'b' and infer the value of 'a', the system gets confused:
; it's trying to solve a * a = b with only one unknown, which is a nonlinear equation.
; Since the constraint network only knows how to do simple multiplication and division,
; it can't compute square roots or handle the same connector in two input positions.
; This breaks the logic of the multiplier constraint and leads to incorrect or undefined behavior.


; Exercise 3.35
; Complete the squarer
(define (squarer a b)
  (define (process-new-value)
    (cond [(has-value? b) (cond [(< (get-value b) 0) (error "square is less than 0: SQUARER")]
                                [else (set-value! a (sqrt (get-value b)) me) ])] ;calcuate a
          [else (set-value! b (sqr (get-value a)) me)]
          )
    )
  (define (process-forget-value)
    (forget-value! a me)
    (forget-value! b me)
    )

  (define (me request)
    (cond [(eq? request 'I-have-a-value) (process-new-value)]
          [(eq? request 'I-lost-my-value) (process-forget-value)]
          [else (error "Unknown Operation SQUARER" request)]
          )
    )

  (connect a me)
  (connect b me)
  me  
  )


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
; global env: a = a connector obejct within its own closure

; define b (make-connector)
; returns me; a dispatch procedure simila to a but with different closure

; (set-value! a 10 'user)
; applies set-my-vallue to a with 10 as value and 'user as the informant
; new E1 frame is created
; E1 (a's connector closure) : {informant: 'user, value: 10}
;