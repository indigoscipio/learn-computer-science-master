#lang racket

#|
4-23. [5] We seek to sort a sequence S of n integers with many duplications, such that
the number of distinct integers in S is O(logn). Give an O(nloglogn) worst-case
time algorithm to sort such sequences

answer:
use frequency tree
n = 8
unique - log 8 = 3

only 3 nodes


|#

(define (vector-swap! vect i1 i2)
  (let ((temp (vector-ref vect i1)))
    (vector-set! vect i1 (vector-ref vect i2))
    (vector-set! vect i2 temp)
    )
  )
