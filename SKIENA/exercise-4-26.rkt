#lang racket



#|
4-27. [6] Let P be a simple, but not necessarily convex, polygon and q an arbitrary
point not necessarily in P. Design an efficient algorithm to find a line segment
originating from q that intersects the maximum number of edges of P. Inother
words, if standing at point q, in what direction should you aim a gun so the bullet
will go through the largest number of walls. A bullet through a vertex of P gets
credit for only one wall. An O(nlogn) algorithm is possible.
|#


(define (find-largest cshifted-xs)
  (let* ((xs-length (length cshifted-xs))
        (left (take cshifted-xs (- xs-length (- (quotient xs-length 2) 1) ) ))
        (mid (list-ref cshifted-xs (quotient xs-length 2)))
        (right (drop cshifted-xs (+ (quotient xs-length 2) 1) ))
        )
    right
    )
  )
(find-largest '(27 29 35 42 5 15 20))