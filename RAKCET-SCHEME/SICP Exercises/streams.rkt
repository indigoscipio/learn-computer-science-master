#lang scheme

; Cons stream is a special form defined so that
; (cons-stream a b) is equivalent to (cons a (delay b))
; where delay is a promise

; A Delay is a XXX??? a promise to evaluate exp at some future time
; (delay exp) = (lambda () exp)

(define (n . rest)
rest
  )
(n 1 2 3 4 5)

;a Force is a XXX?? that forces the delay to fulfill its promise
; calls the procedure of no arguments produced by delay
; Delayed object is a procedure then??
(define (force delayed-object) (delayed-object))

; what delay looks like
(define (memo-proc proc)
  (let ((already-run? false)
        (result false)
        )
    (lambda ()
      (if (not already-run?)
          (begin (set! result (proc))
                 (set! already-run? true)
                 result
                 )
          result
          )
      )
    )
  )


; Stream -> Any
; selects the car of the pair
(define (stream-car stream)
  (car stream)
  )

; Stream -> List-of-Any
; selects the cdr of a stream and evalates the delayed expression to obtain the rest of the stream
(define (stream-cdr stream)
  (force (cdr stream))
  )

;Stream -> XX
(define (stream-ref s n)
  0
  )

; Stream XX
(define (stream-map proc s)
  0
  )


