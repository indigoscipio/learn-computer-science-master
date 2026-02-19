#lang racket

; xs = 2n
(define (split-unfair xs)
  ;split the list
  (let* ((xs-length (length xs))
        (sorted-xs (sort xs <))
        (largest-xs (drop sorted-xs (floor (/ xs-length  2))))
        (smallest-xs (take sorted-xs (floor (/ xs-length 2))))
        )
    (list largest-xs smallest-xs)
    )
  )
(split-unfair '(10 2 8 4 9 1 7 3 6 5))


#|
4.2
a. unsorted O(n): keep track of the smallest and largest
b. sorted, O(1): just pick the first and last item, its' already sorted.
c. sort the list first, then find the list with least differencec 
d. compare diference of each neighbour

|#

; a. UNSORTED LIST - MAX
; assume input is distinct, contains no dups
(define (choose-max-pair-unsorted unsorted-xs)
  ;heper function
  (define (loop xs min max result)
    0
    )
  (loop unsorted-xs  '())  
  )
(choose-max-pair-unsorted '(5 1 8 9 0)) ;(0 . 9)

; SORTED LIST - MAX
(define (choose-max-pair-sorted sorted-xs)
  (cons (car sorted-xs) (last sorted-xs))
  )
(choose-max-pair-sorted '(1 2 3 4 5)) ;(1 . 5)