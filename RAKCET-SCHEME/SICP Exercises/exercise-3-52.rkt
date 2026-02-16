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
; accum takes an input x and mutates sum to (+ x sum) -> returns sum
; current sum now = still 0 because we're not calling accum just defining it

(define seq (stream-map accum
                        (stream-enumerate-interval 1 20)))
; seq enumerate a list of stream from 1 - 20 - it only holds the value 1 and the rest is being lazy loaded
; then it applies accum to each of the interval
; which means if seq is run, it will run accum a total number of 20 times
; then the whole procedure is stored inside seq
; current sum now still 0, we're not calling seq yet just defining it

(define y (stream-filter even? seq))
; y is a stream-filter procedure that filters even numbers for a given list of streams
; current sum now: stil 0

(define z (stream-filter
           (lambda (x) (= (remainder x 5) 0))
           seq))
; z is a stream filter procedure that takes a lambda of 1 argument
; it takex x, and checks if the reminder of x divided by 5 is equal to 0
; current sum now: still 0

#|
(define (stream-ref s n)
  (cond [(empty-stream? s) (error "stream-ref: index out of bounds")]
        [(= n 0) (stream-car s)]
        [else (stream-ref (stream-cdr s) (- n 1) )])
  )
|#

(stream-ref y 7)
; stream ref forces evaluation on seq
; accum gets called for each element
; stream filter filters for even value - it keeps even and discards odd
; first evaluate accum: on each call (sum + 1) + (previous sum) + 2 + (previous sum) + 3 ... until the last interval +20
; so 1 + 3 + 6 ... + up to the 8th index
; then it filters the even number -> return 66


(display-stream z)
; display-stream scans through seq
; and for each value returns by accum checks if the remander of x divided by 5 equals to 0
; but unlike stream ref it doesn't have the limit, just displays all outputs
; prints 10,15,45,55,105,120