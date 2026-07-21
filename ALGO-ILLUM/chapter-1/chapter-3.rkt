#lang racket

;CHAPTER 3

; a Result is a (list merged-list inversion-count)
; where merged-list is a list of numbers
; and inversion count is a number

; list-of-x list-of-y -> Result
(define (merge xs ys)
  (cond [(null? xs) (list ys 0)]
        [(null? ys) (list xs 0)]
        [(< (car xs) (car ys)) (cons (car xs) (merge (cdr xs) ys)) ] ; put in front 
        [else (cons (car ys) (merge xs (cdr ys))) ]) 
  )

; given a list of length n, splits the list into two with length n/2
; list-of-x -> listof-list-of-x
(define (split xs)
  (let* ((n (quotient (length xs) 2))
        (first-half (take xs n) )
        (second-half (drop xs n))
        )
    (list first-half second-half)
    )
  )

; MERGE SORT
(define (mergesort xs)
  (let* ((split-xs (split xs))
         (first-half (car split-xs))
         (second-half (cadr split-xs)))
    (cond [(null? xs) '()]
          [(null? (cdr xs)) xs] ; only one item
          [else (merge (mergesort first-half) (mergesort second-half)) ])
    )
  )

; v2, with mergesort
; n log n implementation
(define (count-inversions-v2 xs)

  )
(count-inversions-v2 '(1 3 5 2 4 6))

; helper
; number list-of-number -> number
(define (count-inversion x xs)
  (cond [(null? xs) 0]
        [(> x (car xs)) (+ 1 (count-inversion x (cdr xs)))] ;out of order
        [else (count-inversion x (cdr xs))]
        )
  )
(count-inversion 3 '(1 2))

; INVERSIONS
; how out of order is an array?
; normal way
(define (count-inversions xs)
  (cond [(null? xs) 0]
        [else (let ((fst (car xs))
                    (rest (cdr xs))
                    )
                (+ (count-inversion fst rest) (count-inversions rest) )
                )]
        )
  )
(count-inversions '(3 1 2)) ; i0 vs 1, i0 vs 2, 2 inversions
(count-inversions '(1 3 5 2 4 6)) ;???
(count-inversions '(1 2 3)) ; 0 inversions

