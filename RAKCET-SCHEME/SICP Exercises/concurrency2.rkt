#lang sicp

(define x 10)
(define (proc1) (set! x (* x x)) )
(define (proc2) (set! x (+ x 1)))


(define (parallel-execute procs)
  (cond
    [(null? procs) 'ok]
    [else ((car procs)) (parallel-execute (cdr procs))]))
(parallel-execute (list proc1 proc2))



; Procedure -> Serialized Procedure
(define (make-serializer x) 0)


(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  (define (dispatch m)
    (cond [(eq? m 'withdraw) withdraw]
          [(eq? m 'deposit) deposit]
          [(eq? m 'balance) balance]
          [else (error "Unknown Operation MAKE-SERIALIZER" m)]
          )
    )
  dispatch
  )
