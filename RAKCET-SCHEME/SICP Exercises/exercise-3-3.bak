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

(define s (make-monitored sqrt))
(s 100)
(s 'how-many-calls) ; should return 1
(s 200)
(s 100)
(s 'reset-count)
(s 'how-many-calls)
(s 200)
(s 100)
(s 'reset-count)