#lang sicp

(define (for-each-except exception procedure list)
  (define (loop items)
    (cond ((null? items) 'done)
          ((eq? (car items) exception) (loop (cdr items)))
          (else (procedure (car items))
                (loop (cdr items)))))
  (loop list))

;; make-connector : -> Connector
;; A Connector is a dispatch procedure that responds to certain messages:
;;  'has-value? → boolean
;;  'value      → number (if has value)
;;  'set-value! newval setter → sets value, notifies others
;;  'forget     retractor     → forgets value if retractor is informant
;;  'connect    constraint    → adds constraint to listeners
(define (make-connector)
  (let ((value false)
        (informant false)
        (constraints '())
        )

    (define (has-value?)
      informant
      )

    (define (set-my-value newval setter)
      (cond [(not (has-value?)) (set! value newval) (set! informant setter) (for-each-except setter inform-about-value constraints)]
            []
            )
      )


    (define (me request)
      (cond [(eq? request 'has-value?) (if informant true false)]
            [(eq? request 'value) value]
            [(eq? request 'set-value!) set-my-value]
            [(eq? request 'forget) 1]
            [(eq? request 'connect) 1]
            [else (error "Unknown Operation: CONNECTOR" request)]
            )
      )
    me
    )
  )
(define a (make-connector))
(a 'set-value!)