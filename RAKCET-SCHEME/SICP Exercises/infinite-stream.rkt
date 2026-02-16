#lang sicp


; A Stream is either
; (empty list)
; (cons X (-> Stream))
; where stream-cdr-promise is a procedure with no arguments that produces the rest of the stream.

(define the-empty-stream '())
(define (empty-stream? s) (null? s))

; delay : X -> (-> X)
; Takes an expression X and returns a procedure of no arguments that, when called, produces X.
(define (delay exp)
  (memo-proc (lambda () exp))
  )

; cons-stream : X (-> Stream) -> Stream
; Constructs a stream by pairing a value with a delayed rest of the stream.
(define (cons-stream a b) (cons a (delay b)))


; force : (-> X) -> X
; Takes a delayed object (procedure) and forces evaluation to produce X.
(define (force delayed-object) (delayed-object))

; stream-car : Stream -> X
; Returns the first element of the stream.
(define (stream-car stream)
  (car stream)
  )

; stream-cdr : Stream -> Stream
; Returns the rest of the stream by forcing evaluation of the delayed cdr.
(define (stream-cdr stream)
  (force (cdr stream))
  )

; Stream Number -> X
; returns the nth element of a stream
(define (stream-ref s n)
  (cond [(empty-stream? s) (error "stream-ref: index out of bounds")]
        [(= n 0) (stream-car s)]
        [else (stream-ref (stream-cdr s) (- n 1) )])
  )

; (X -> Y) Stream -> Stream-of-Y
; applies proc to each stream
(define (stream-map proc s)
  (cond [(empty-stream? s) the-empty-stream ]
        [else (cons-stream (proc (stream-car s))
                           (stream-map proc (stream-cdr s)))  ])
  )

; Number Number -> List-of-Stream
; enumerates a list of streams
(define (stream-enumerate-interval low high)
  (cond [(> low high) the-empty-stream]
        [else (cons-stream low (stream-enumerate-interval (+ low 1) high))])
  )

; what delay looks like
; Returns a zero-argument procedure (thunk)
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

(define (add2 x)
  (+ x 2)
  )

(define ones (cons-stream 1 ones))
