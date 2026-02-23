#lang racket

#|
Given a set of S containing n real numbers, and a real number x. We seek an
algorithm to determine whether two elements of S exist whose sum is exactly x.
(a) Assume that S is unsorted. Give an O(nlogn) algorithm for the problem.
(b) Assume that S is sorted. Give an O(n) algorithm for the problem.


answer:

a. sort both list -> n log n
find the partner b = x - a



b. the two pointer tehcnue
low pointer = left
right pointer = right

if the value is too high
move right pointer to the left
if the value is too low
move left pointer to the right

|#

; takes two sorted list and a target
; finds the two sum thing
; listofx listofx x -> boolean
(define (two-sum-with-pointer s1 s2 target)
  ; success
  ; sum too high
  ; sum too low
  (define (tswp-helper xs ys)
    (cond [(or (empty? xs)(empty? ys)) #f]
          [else (let ((x (car xs))
                      (y (car ys))
                      (sum (+ x y))
                      )
                  (cond []
                        []
                        ; sum is too high
                        ; sum is too low
                        ; equal - found it!
                        )
                  )])
    )
  (twsp-helper s1 (reverse s2))
  
  )
(two-sum-with-pointer '(1 3 5) '(5 8 10) 13)