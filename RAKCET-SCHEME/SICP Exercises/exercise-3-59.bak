#lang sicp

#|

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

; =================================================================

; Exercise 3.53
; without running the program, describe the elements of stream defined by

;(define s (cons-stream 1 (add-stream s s)) )

; answer:
; we are defining s as a cons stream
; with stream-car of 1 and stream-cdr of (add-stream s s)
; in other words this is a self referential cons stream definintion
; (cons stream 1 (add-stream (cons-stream 1 (add-stream ...)) (add-stream ...) ))
; this recursively adds the first stream by itself and saves it to the stream-cdr
; so adds double.
; so it goes something like 1 (1 + 1) -> 1 2 (2 + 2) -> 1 2 4 (4 + 4) -> 1 2 4 8 (8 + 8) -> ...

; =================================================================

(define (add-streams s1 s2) (stream-map + s1 s2))
(define integers (cons-stream 1 (add-streams ones integers)))
(define (integers-starting-from n)(cons-stream n (integers-starting-from (+ n 1))))

; Exercise 3.54

(define (mul-streams s1 s2)
  (stream-map * s1 s2)
  )

(define factorials
  (cons-stream 1 (mul-streams factorials (integers-starting-from 2) )))

; =================================================================

; Exercise 3.55

; Stream -> Stream
(define (partial-sums s)
  ; acc hold the accumulated sum of elements seen so far (but before the current element).

  (define (iter stream acc)
    (cons-stream acc
                 (iter (stream-cdr stream) (+ (stream-car stream) acc)))
    )

  (iter s 0)
  )
; (partial-sums integers) should return 1,3,6,10,15

; =================================================================

; Exercise 3.56

(define (merge s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (cond ((< s1car s2car)
                  (cons-stream
                   s1car
                   (merge (stream-cdr s1) s2)))
                 ((> s1car s2car)
                  (cons-stream
                   s2car
                   (merge s1 (stream-cdr s2))))
                 (else
                  (cons-stream
                   s1car
                   (merge (stream-cdr s1)
                          (stream-cdr s2)))))))))

(define S (cons-stream 1 (merge (merge (scale-stream S 2) (scale-stream S 3)) (scale-stream S 5)) ))

; =================================================================

; Exercise 3.57
(define (add-streams s1 s2) (stream-map + s1 s2))

(define fibs
  (cons-stream
   0
   (cons-stream 1 (add-streams (stream-cdr fibs) fibs))))

; answer:
; without optimization, it would take a longer time/computation
; in fibs, we call (add-streams ...) and (stream-cdr fibs) everytime we want ot get the stream's cdr value
; when we make a stream cons we delay its cdr, but since the cdr is not stored inside memoization it just re-computes
; and inside fibs we are defining cons stream 2 times, so that's 2x computation
; plus the add-streams which returns a cons stream, so 3 times the computation without memoiztaion
; so cons stream 0 ... cons stream 1 .. (cons stream (add-stream for the next fib))... repeat for the next one
; in summary it re-computes all of the previous fib numbers

; whereas in the memoized version, we only have to compute 1 time since the previous value is already stored inside memoization proc
; so on the first call we compute 0 1 and the next one,
; but on the next call we only compute the next fibonaci, so its only evaluated once

|#

; =================================================================

; Exercise 3.58
; Give an interpretation of the stream computed by the following procedure

(define (expand num den radix)
  (cons-stream (quotient (* num radix) den)
               (expand (remainder (* num radix) den) den radix) )
  )


; what are the successive elements produced by (expand 1 7 10)?
; answer:
; lets' evluate (expand 1 7 10)
; first it binda num = 1, den = 7, and radix = 10
; and returns (cons stream ..) with
; car = (quotient (* 1 10) 7) = (quotient 10 7) = 1
; cdr = (expand (remainder (* 1 10) 7) 7 10) = (expand (remainder 10 7) 7 10) = (expand 3 7 10)
; so this creates (cons-stream 1 (expand 3 7 10)), with the next value of den and radix unchanged


; now evaluate (expand 3 7 10)
; num = 3, den = 7, radix = 10
; returns (cons stream...) with
; car = (quotient (* 3 10) 7) = (quotient 30 7) = 4
; cdr = (expand (remainder (* 3 10) 7) 7 10) = (expand (remainder 30 7) 7 10) = (expand 2 7 10)
; this creates (cons stream 1 (cons-stream 4 (expand 2 7 10)))

; now evaluate (expand 2 7 10)
; num = 2, den = 7, radix = 10
; returns (cons stream...) with
; car = (quotient (* 2 10) 7) = (quotient 20 7) = 2
; cdr = (expand (remainder (* 2 10) 7) 7 10) = (expand (remainder 20 7) 7 10) = (expand 6 7 10)
; this creates (cons stream 1 (cons-stream 4 (cons-stream 2 (expand 6 7 10)) ))

; now evaluate (expand 6 7 10)
; num = 6, den = 7, radix = 10
; returns (cons stream...) with
; car = (quotient (* 6 10) 7) = (quotient 60 7) = 8
; cdr = (expand (remainder (* 6 10) 7) 7 10) = (expand (remainder 60 7) 7 10) = (expand 4 7 10)

; now evaluate (expand 4 7 10)
; num = 4, den = 7, radix = 10
; returns (cons stream...) with
; car = (quotient (* 4 10) 7) = (quotient 40 7) = 5
; cdr = (expand (remainder (* 4 10) 7) 7 10) = (expand (remainder 40 7) 7 10) = (expand 5 7 10)

; so it creates a sequence of stream with values: 1,4,2,8,5...


; what is produced by (expand 3 8 10)?
; answer:
; lets' evluate (expand 3 8 10)
; first it binda num = 3, den = 8, and radix = 10
; and returns (cons stream ..) with
; car = (quotient (* 3 10) 8) = (quotient 30 8) = 3
; cdr = (expand (remainder (* 3 10) 8) 8 10) = (expand (remainder 30 8) 8 10) = (expand 6 8 10)


; now evaluate (expand 6 8 10)
; num = 6, den = 8, radix = 10
; returns (cons stream...) with
; car = (quotient (* 6 10) 8) = (quotient 60 8) = 7
; cdr = (expand (remainder (* 6 10) 8) 8 10) = (expand (remainder 60 8) 8 10) = (expand 4 8 10)


; now evaluate (expand 4 8 10)
; num = 4, den = 8, radix = 10
; returns (cons stream...) with
; car = (quotient (* 4 10) 8) = (quotient 40 8) = 5
; cdr = (expand (remainder (* 4 10) 8) 8 10) = (expand (remainder 40 8) 8 10) = (expand 0 8 10)

; now evaluate (expand 0 8 10)
; num = 0, den = 8, radix = 10
; returns (cons stream...) with
; car = (quotient (* 0 10) 8) = (quotient 0 8) = 0
; cdr = (expand (remainder (* 0 10) 8) 8 10) = (expand (remainder 0 8) 8 10) = (expand 0 8 10)

; this creates a sequence of 3,7,5,0,...
; in summary, this procedure generate infinite stream of digits representing a fraction in a given base