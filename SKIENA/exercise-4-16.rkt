#lang racket
(require data/heap)

#|

Quicksort
4-16. [3] Use the partitioning idea of quicksort to give an algorithm that finds the median
element of an array of n integers in expected O(n) time. (Hint: must you look at
both sides of the partition?)

|#

(define (quicksort-median lst)
  ; partition

  ; if pivot is in the middle, we found the median
  ; if its to the left, recurse only on left side
  ; if its to the right, recurse only on right side
  (let ((mid-index (quotient (length lst) 2)))
    
    )
  
  )
(quicksort-median '(10 2 15 7 3 12 9))