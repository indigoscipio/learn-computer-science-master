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
  (memo-proc (lambda () (exp)))
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

(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin (proc (stream-car s))
             (stream-for-each proc (stream-cdr s)))))

(define (display-stream s)
  (stream-for-each display-line s))
(define (display-line x) (newline) (display x))

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


(define (integers-starting-from n)
  (cons-stream n (lambda () (integers-starting-from (+ n 1)))))
(stream-ref (integers-starting-from 3) 5)



; ===========================================================

; Exercise 3.66

;answer:
; my general comment about theo rder in which the pairs are placed into the stream

; how many pairs precede the pair (1,100)?
; this generates a pair with 1 row and 100 columns
; s (row) = 1, t (cols) = 100
; it returns a cons stream with (1,1) , (1,2) , (1,3) ...
; 1 + 2 + 3 + 4 + 5

; (99,100)
; this one generates 99 rows and 100 cols
; (1,1), (1,2), (2,2), (1,3), (2,3), (3,3), ...
; I'm not sure about the mathematical equation but from what i analyzed
; for every row generated, the col decreases by 1
; so if theres 3S and 3T, there are 6 items total intererweaved
; i'm guessing 99S and 100T -> somewhere around ~50 items total?

; (100,100)
; generates a total pairs of 100 rows and 100 cols
; This one i'm also not quite sure, maybe around 50+

; ===========================================================

; Exercise 3.67

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (stream-map (lambda (x) (list (stream-car s) x))
                (stream-cdr t))
    (pairs (stream-cdr s) (stream-cdr t)))))
(pairs integers integers)