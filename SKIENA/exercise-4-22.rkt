#lang racket

#|
4-22. [3] Show that n positive integers in the range 1 to k canbesortedinO(nlogk)
time. The interesting case is when k<<n.

answer:
example
n = 100
k = 3

use balanced bst
each node represnts 1 - k
because there are only k possible avlues
the tree only needs k nodes

the height of hte balanced tree with k nodes is log k


|#

(define (vector-swap! vect i1 i2)
  (let ((temp (vector-ref vect i1)))
    (vector-set! vect i1 (vector-ref vect i2))
    (vector-set! vect i2 temp)
    )
  )
