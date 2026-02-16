#lang scheme


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
        [else (stream-ref (stream-cdr s) (sub1 n) )])
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
        [else (cons-stream low (stream-enumerate-interval (add1 low) high))])
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

; memoize a procedure with 1 argument
; [Any -> Any] -> Memoized [Any -> Any]
(define (memoize f)
  (let ((cache '()))
    (lambda (x)
      ; stores x inside the cache
      (let ((entry (assoc x cache) ))
        (cond [entry (cdr entry)];if an entry is found, return its value
              [else ( let ((result (f x))) ;fx is not yet computed, store it as a result
                       (set! cache (cons (cons x result) cache) )
                       result
                       ) ] ; otherwise, store the new computed value/result inside cache, and return the result
              )
        )
      )
    )
  )



; ==============================================================

#|
; Exercise 3.50
; argstreams is a list of streams stored as an argument inside stream-map
; (List-of X List-Of-Stream)) -> List-of-Stream
(define (stream-map proc . argstreams)
  (if (empty-stream? (car argstreams))
      the-empty-stream
      (cons-stream (apply proc (map stream-car argstreams) ) ;apply procedure to each arguments
                   (apply stream-map (cons proc (map stream-cdr argstreams)) ) ;not sure what this does
                   )
      )
  )
|#


; ==============================================================

; Exercise 3.51
; X -> X
(define (show x)
  (display x)
  (newline)
  x)

(define x (stream-map show (stream-enumerate-interval 0 10)))
; answer:
; first, x holds a total of 10 cons-stream with 0 - 10 value, result from stream-enumerate-interval
; it creates a promise but no number is printed yet (0 . <promise to show the rest>)
; then it uses stream-map to apply the show procedure (basically displays each number 0 - 10)

; (stream-ref x 5)
; this shows the number 5 (or 5th index of stream-enumberate-interval 0 10)
; forces evaluation until reaching index 5
; (show 0) -> prints 0, returns 0
; (show 1) -> prints 1, returns 1
; ... etc until 5
;(stream-ref x 7)
; this shows the number 7 (or 7th index of stream-enumberate-interval 0 10)

; ==============================================================

; Exercise 3.52

(define sum 0)
; answer:
; current sum now = 0
(define (accum x) (set! sum (+ x sum) sum))
; accum takes an input x and mutates the sum to (+ x sum) -> returns it
(accum 10)
sum