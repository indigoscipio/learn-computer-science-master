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
; assume input is nonempty distinct, contains no dups
(define (choose-max-pair-unsorted unsorted-xs)
  ;heper function
  (define (loop xs min max)
    (cond [(null? xs) (cons min max)]
          [(< (car xs) min) (loop (cdr xs) (car xs) max)];update min
          [(> (car xs) max) (loop (cdr xs) min (car xs))];update max
          [else (loop (cdr xs) min max)] ;outside of boundary
          )
    )
  (loop (cdr unsorted-xs) (car unsorted-xs) (car unsorted-xs))  
  )
(choose-max-pair-unsorted '(5 1 8 9 0)) ;(0 . 9)

;b. SORTED LIST - MAX
(define (choose-max-pair-sorted sorted-xs)
  (cons (car sorted-xs) (last sorted-xs))
  )
(choose-max-pair-sorted '(1 2 3 4 5)) ;(1 . 5)

;c. UNSORTED LIST - MIN
(define (choose-min-pair-unsorted unsorted-xs)
  ;sort the list
  ;find least difference (same as D)
  0
  )
(choose-min-pair-unsorted '(5 1 8 9 0))

;d. SORTED LIST - MIN
; assume list is nonempty unique, with atleast 2 element
(define (choose-min-pair-sorted sorted-xs)
  (define (loop xs best-pair-so-far)
    (cond [(null? xs) best-pair-so-far]
          [(null? (cdr xs)) best-pair-so-far]
          [else (let* ((fst (car xs))
                       (sec (cadr xs))
                       (curr-diff (abs (- fst sec)))
                       (best-pair-diff (abs (- (car best-pair-so-far) (cdr best-pair-so-far))))
                       )
                  (if(< curr-diff  best-pair-diff)
                     (loop (cdr xs) (cons fst sec))
                     (loop (cdr xs) best-pair-so-far)
                     )
                  )]
          )
    )
  (loop (cddr sorted-xs) (cons (car sorted-xs) (cadr sorted-xs) ))
  )

; ==================================
; 4.3
(define (partition-into-pair xs)
  (let*  ((sorted-xs (sort xs <))
         (xs-length (length xs))
         (left-half (take sorted-xs (floor (/ xs-length 2))))
         (right-half (drop sorted-xs (floor (/ xs-length 2))))
         )    
    (define (loop l1 l2 result)
      ; l1/l2 is empty, no pair left, return the result
      ; else pair the 1st smallest and 1st largest it and recurse
      (cond [(or (null? l1) (null? l2)) result]
            [else (loop (cdr l1) (cdr l2) (cons (cons (car l1) (car l2)) result)) ])
      )
    ; initialize with the right half list reversed
    (loop left-half (reverse right-half) '())
    )
  )
(partition-into-pair '(6 11 26 77 12 9))
(partition-into-pair '(1 3 5 9))

