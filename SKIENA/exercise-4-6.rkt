#lang racket

#|
Exercise 4.6
[3] Given two sets S1 and S2 (each of size n), and a number x,describeanO(nlogn)
algorithm for finding whether there exists a pair of elements, one from S1 and one
from S2, that add up to x. 
|#

; list-of-x x -> boolean
(define (binary-search sorted-list target)
  (define (binary-search-helper xs low-index high-index)
    (cond [(> low-index high-index) #f]
          [else (let* ((mid-index (quotient (+ low-index high-index) 2))
                       (mid-value (list-ref xs mid-index))
                       )
                  (cond [(equal? mid-value target) #t]
                        [(< mid-value target) (binary-search-helper xs (+ mid-index 1) high-index)] ;mid-value smaller than target, go right
                        [else (binary-search-helper xs low-index (- mid-index 1))] ;mid value larger than target, go left
                        )
                  )])
    )
  (binary-search-helper sorted-list 0 (- (length sorted-list)1))
  )
(binary-search '(1 2 3 4 5 6 7 8) 8)

; given two unsorted list of numbers and x
; checks if theres one item from each set that adds up exastly to x
(define (adds-up-to-x s1 s2 x)
  (let ((sorted-s2 (sort s2 <)))
    ; iterate through xs
    (define (loop xs ys target)
      (cond [(empty? xs) #f]
            [else (let* ((a (car xs))
                         (b (- x a)))
                    (or (binary-search sorted-s2 b) (loop (cdr xs) ys x))
                    )] ;perform binarysearch
            )
      )
    (loop s1 sorted-s2 x)
    )
  
  )
(adds-up-to-x '(3 1 8) '(5 2 9) 10)
