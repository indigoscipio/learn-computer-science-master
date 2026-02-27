#lang racket
(require data/heap)

#|

Quicksort
4-16. [3] Use the partitioning idea of quicksort to give an algorithm that finds the median
element of an array of n integers in expected O(n) time. (Hint: must you look at
both sides of the partition?)

|#

(define (quicksort-median lst)
  (let* ((mid-index (quotient (length lst) 2)))
    ;; partition: x listofx listof(listofx listofx listofx)
    (define (helper xs i)
      (let* ((pivot (car xs))
             (rest (cdr xs))
             (smaller (filter (λ (x) (< x pivot)) xs))
             (equal (filter (λ (x) (= x pivot)) xs))
             (larger (filter (λ (x) (> x pivot)) xs))
             (length-smaller (length smaller))
             (length-equal (length equal))
             (length-larger (length larger)))
        (cond [(< i length-smaller) (helper smaller i)]
              [(< i (+ length-smaller length-equal)) pivot]
              [else (helper larger (- i (+ length-smaller length-equal)))]
              )
        )
      )
    (helper lst mid-index)    
    )
  )
(quicksort-median '(10 2 15 7 3 12 9))

#|
4-17. [3] The median of a set of n values is the n/2th smallest value

(a) Suppose quicksort always pivoted on the median of the current sub-array. How
many comparisons would Quicksort make then in the worst case?

(b) Suppose quicksort were always to pivot on the n/3th smallest value of the
current sub-array. How many comparisons would be made then in the worst
case?

answer:
a. if pivot is in the median/middle then check both left/right side equally
so check left + check right oepration = 2n or something

b. 

|#