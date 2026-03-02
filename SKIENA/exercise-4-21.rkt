#lang racket

#|
Other sorting algorithms
4-21. [5] Stable sorting algorithms leave equal-key items in the same relative order as in
the original permutation. Explain what must be done to ensure that mergesort is
a stable sorting algorithm.

answer:
decition happens inside the merge funciton
if (left_item <= right_item)

the <= ensures if the left item is equal to the right
then it passes the check and put it infront of it

|#

(define (vector-swap! vect i1 i2)
  (let ((temp (vector-ref vect i1)))
    (vector-set! vect i1 (vector-ref vect i2))
    (vector-set! vect i2 temp)
    )
  )
