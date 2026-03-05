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
  
  (define (helper xs low-idx high-idx)
    (let* ((mid-idx (quotient (+ low-idx high-idx) 2))
          (low-val (list-ref xs low-idx))
          (mid-val (list-ref xs mid-idx))
          (high-val (list-ref xs high-idx)))
      (cond [(= low-idx high-idx) mid-val]
            [(> mid-val high-val) (helper xs low-idx mid-idx)]
            [else (helper xs (+ mid-idx 1) high-idx)]
            )
      )
    )
  (helper cshifted-xs 0 (- (length cshifted-xs) 1))
  
  )
(find-largest '(27 29 35 42 5 15 20))