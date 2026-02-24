#lang racket

#|

Give an efficient algorithm to compute the union of sets A and B,where
n = max(|A|,|B|). The output should be an array of distinct elements that form
the union of the sets, such that they appear more than once in the union.
(a) Assume that A and B are unsorted. Give an O(nlogn) algorithm for the
problem.
(b) Assume that A and B are sorted. Give an O(n) algorithm for the problem.

answer:
a. if both list are unsorted
to find the union
sort both list
use the pointer method
total = 2x n log n (sort) -> comparison (n) -> n + n log n = n log n

b. if its already sorted
use the two pointer approach

if the number in set a is smaller than set b, add that to the result
if the number is set b is smaller than set a, add that to the reuslt
if the numbers are equal, keep only once and repeat

that O(n) complexity

|#


; takes two sorted list and a target
; finds the union using two pointer thing
(define (union-set-two-pointer s1 s2)
  (define (ustp-helper xs ys result)
    (cond [(null? xs) (reverse (append (reverse ys) result))]
          [(null? ys) (reverse (append (reverse xs) result))]
          [else (let* ((x (car xs))
                      (y (car ys))
                      )
                  (cond [(equal? x y) (ustp-helper (cdr xs) (cdr ys) (cons x result))]
                        [(< x y) (ustp-helper (cdr xs) ys (cons x result))]
                        [else (ustp-helper xs (cdr ys) (cons y result))]
                        )
                  )])
    )
  (ustp-helper s1 s2 '())
  
  )
(union-set-two-pointer '(1 3 5) '(5 8 10))