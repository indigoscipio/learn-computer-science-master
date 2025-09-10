#lang racket

; given a list, splits it into two sections
; List-> list-of-(Pair-of-List)
(define (split l)
  (let ((mid-index (floor (/ (length l) 2) )))
    mid-index
    )
  )
(split '())
(split '(1 2 3)) ; (1 2)
(split '(1 2 3 4 5 6)) ; '(1 2 3)

; List-of-X (sorted) List-of-X (sorted) -> List-of-X (Sorted)
; given a two already sorted list, merge into one with all of the elements sorted
; on each iteration, build the list with cons with the smalest in the front
(define (merge left right)
  (cond [(null? left) right]
        [(null? right) left]
        [(< (car left) (car right)) (cons (car left) (merge (cdr left) right))] ; put left before right
        [else (cons (car right) (merge left (cdr right)) )] ;put right in front and and recurse
        )
  )
(merge '() '(9))
(merge '(8) '())
(merge '() '())
(merge '(1 3 9) '(2 4 6 10))

(define (merge-sort l)
  ; create temporary arary, split into 2
  ; add 1 for the sentinel for each
  ; loop into the 2
  0
  )

(merge-sort '(1 5 9 -44 8 500 6 -10))