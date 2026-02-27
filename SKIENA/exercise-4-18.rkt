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

#|
-18. [5] Suppose an array A consists of n elements, each of which is red, white,orblue.
We seek to sort the elements so that all the reds come before all the whites,which
come before all the blues The only operation permitted on the keys are
• Examine(A,i)– report the color of the ith element of A.
• Swap(A,i,j)–swaptheith element of A with the jth element.
Find a correct and efficient algorithm for red-white-blue sorting. There is a linear
time solution.


|#



(define (flag-sort vect)
  ; red: left of low
  ; white: between low and mid - 1
  ; blue: everything to the right of high
  ; unexplored: everyhing between mid and high
  (define (helper v low mid high)
    ; look at mid pos
    (let ((mid (vector-ref v mid)))
      mid
      )
    )
  (helper vect 0 1 2)
  )
(flag-sort (vector 'R 'R 'W 'B 'W 'B))