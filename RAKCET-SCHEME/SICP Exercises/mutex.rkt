#lang sicp


; () -> Serialized Procedure
(define (make-serializer)
  (let ((mutex (make-mutex) ))
    (lambda (p)(define (serialized-p . args)
                 ; acquire the mutex,
                 (mutex 'acquire)

                 ; runs the procedure to the list of arguments
                 (let ((val (apply p args)))
                   (mutex 'release)
                   val
                   )
                 )
      serialized-p
      )
    )
  )



(define (clear! cell) (set-car! cell false))

(define (make-mutex)
  ; A Cell is a one element list that holds true/false
  ; during initializaiton, a mutex's cell is set to false
  ; (list false) or (list true)
  (let ((cell (list false)))
    ; think of the mutext as a dispatch/message passing-style
    (define (the-mutex m)
      (cond [(eq? 'acquire) (if (test-and-set! cell)
                                (the-mutex 'acquire) ;if busy, retry
                                'ok ;if free, proceed
                                ) ]
            [(eq? 'release) (clear! cell)]
            )
      )
    the-mutex
    )
  )

(define (test-and-set! cell)
  (cond [(car cell) true] ;if its locked, keep it locked
        [else (begin (set-car! cell true)
                     false) ] ;it's unlocked, return false
        )
  )