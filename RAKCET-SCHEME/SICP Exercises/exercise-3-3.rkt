#lang racket

; Number -> (Number -> Number)
(define (make-accumulator init)
  (let ((acc init))
    (lambda (x) (begin (set! acc (+ x acc))
                       (display "Acc now: ")
                       acc))
    )
  )
(define A (make-accumulator 5))



; Exercise 3.2
; [Any -> Any] -> Number
(define (make-monitored f)
  (let ((counter 0))
    
    (define (apply-and-increment input)
      (let ((result (f input)))
        (begin
          (set! counter (add1 counter))
          (display "Counter now: ")
          (display counter)
          (newline)
          result)
        )      
      )

    (define (reset-counter)
      (begin (set! counter 0) "Counter Reset!")
      )
    
    (lambda (input) (cond [(eq? input 'how-many-calls) counter]
                          [(eq? input 'reset-count) (reset-counter)]
                          [else (apply-and-increment input) ]))
    )
  )


;exercise 3.3
; Number Symbol -> (Symbol Symbol -> (Number -> Number))
(define (make-account balance password)
  (define (withdraw amount)
    (cond [(>= balance amount) (begin (display "Balance now: ")
                                      (set! balance (- balance amount))
                                      balance)]
          [else "Insufficient Funds"])
    )
  
  (define (deposit amount)
    (begin (display "Balance now: ")
           (set! balance (+ balance amount))
           balance
           )
    )

  
  (define (dispatch pw msg)
    (cond [(eq? pw password) (cond [(eq? msg 'withdraw) withdraw ]
                                   [(eq? msg 'deposit) deposit]
                                   [else "Operation not found"]
                                   )]
          [else (lambda (x) "Incorrect password! ")])
    
    )
  dispatch
  )
(define acc (make-account 100 'secret-password))
((acc 'secret-password 'withdraw) 40)
((acc 'secret-password 'withdraw) 40)
((acc 'some-other-password 'deposit) 50)

