#lang racket

#|
4-20
Give an efficient algorithm to rearrange an array of n keys so that all the
negative keys precede all the nonnegative keys. Your algorithm must be in-place,
meaning you cannot allocate another array to temporarily hold the items. How fast
is your algorithm?


|#

(define (vector-swap! vect i1 i2)
  (let ((temp (vector-ref vect i1)))
    (vector-set! vect i1 (vector-ref vect i2))
    (vector-set! vect i2 temp)
    )
  )

(define (rearrange vect)
  (define (helper v left right)
    (cond [(> left right) v]
          [else (let ((left-val (vector-ref vect left))
                      (right-val (vector-ref vect right))
                      )
                  (cond [(and (negative? left-val) (positive? right-val)) (helper v (+ 1 left) (- right 1))]; move
                        [(and (positive? left-val) (negative? right-val)) (begin (vector-swap! v left right)
                                                                                 (helper v (+ 1 left) (- right 1))
                                                                                 )];swap both
                        [(and (negative? left-val) (negative? right-val)) (helper v (+ 1 left) right)] ;move left
                        [else (helper v left (- right 1) )] ;move right
                        )
                  )])
    )
  (helper vect 0 (- (vector-length vect) 1))
  
  )
(rearrange (vector -1 4 -2 0 5 -6 3))