#lang simply-scheme

; VECTORS
(define v (make-vector 5))
(vector-set! v 0 'shoe)


(define *lap-vector* (make-vector 20 0))
*lap-vector*
(define (initialize-lap-vector i)
  (if (< i 0)
      'done
      (begin (vector-set! *lap-vector* i 0)
             (initialize-lap-vector (- i 1))
             )
      )
  )

(define (lap car-num)
  (vector-set! *lap-vector* car-num (+ (vector-ref *lap-vector* car-num) 1))
  (vector-ref *lap-vector* car-num)
  )
; =================================================

(define (card-list)
  (reduce append
          (map (lambda (suit) (map (lambda (rank) (word suit rank))
                                   '(a 2 3 4 5 6 7 8 9 10 j q k)))
               '(h s d c))))


(define (shuffle! deck index)
  (if (< index 0)
      deck ;done
      (begin (vector-swap! deck index (random (+ index 1)))
             (shuffle! deck (- index 1))) ;shuffle each card one by one
      )
  )

(define (vector-swap! vector index1 index2)
  (let ((temp (vector-ref vector index1)))
            (vector-set! vector index1 (vector-ref vector index2))
        (vector-set! vector index2 temp)
    )
  )

(define (make-deck)
  (shuffle! (list->vector (card-list)) 51)
  )

(vector-length (vector 1 (vector 1 2 3) 3 4))

; ==================================================
; Imperative programming is about
; State
; Side Effect
; Sequence

#|
Exercises
Do not solve any of the following exercises by converting a vector to a list, using list procedures, and then converting 
the result back to a vector.

23.1 Write a procedure sum–vector that takes a vector full of numbers as its argument and returns the sum of all the 
numbers:
> (sum–vector '#(6 7 8))
21

answer:
|#

; vector -> number
(define (sum-vector v)
  (let ((v-length (vector-length v)))
    (define (sum-vector-helper vect i)
      (if (< i 0)
          0
          (+ (vector-ref vect i)
             (sum-vector-helper vect (- i 1)))
          )
      )
    (sum-vector-helper v (- v-length 1))
    )
  )
(sum-vector '#(6 7 8))

; ==================================================================

#|
23.2 Some versions of Scheme provide a procedure vector–fill! that takes a vector and anything as its two 
arguments. It replaces every element of the vector with the second argument, like this:
> (define vec (vector 'one 'two 'three 'four))
> vec
#(one two three four)
> (vector–fill! vec 'yeah)
> vec
#(yeah yeah yeah yeah)
|#

; vector word -> vector
; fill up vector v with all x
(define (my-vector-fill! v x)
  (let ((vl (vector-length v)))
    (define (my-vector-fill-helper vect item i)
      (begin ()
             ()
             )
      )
    (my-vector-fill-helper v x vl)
    )
  )
(define vec (vector 'one 'two 'three 'four))
(my-vector-fill! vec 'yeah) ;should return #(yeah yeah yeah yeah)

; ==================================================================

#|

|#

; ==================================================================

#|

|#

; ==================================================================

