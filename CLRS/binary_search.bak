#lang racket

(define (split-pointer lon)
  ; acc stores the split left list built so far
  ; l1 = slow pointer list, l2 = fast pointer list
  (define (iter l1 l2 acc)
    (cond [(null? l2) (list (reverse acc) l1)]
          [(null? (cdr l2)) (list (reverse acc) l1)] ; if fast poitner reaches the end, ...
          [else (iter (cdr l1) (cdr (cdr l2)) (cons (car l1) acc) )]
          )
    )
  (iter lon lon '())
  
  )
(split-pointer '())
(split-pointer '(1 2 3)) ; '((1 2) '(3))
(split-pointer '(1 5 9 -44 8 500))

; given a list, splits it into two sections
; List-> list-of-(Pair-of-List)
(define (split l)
  (let ((mid-index (floor (/ (length l) 2) )))
    ; acc stores the split list so far
    (define (iter items i acc)
      (cond [(null? items) (list (reverse acc) '())]
            [(= i mid-index) (list (reverse acc) items) ];return acc + rest of the list
            [else (iter (cdr items) (+ i 1) (cons (car items) acc) )])
      )
    (iter l 0 '())    
    )
  )
;(split '()); '()
;(split '(1 2 3)) ; '((1 2) '(3))
;(split '(1 2 3 4 5 6)) ; '((1 2 3) (4 5 6))

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
;(merge '() '(9))
;(merge '(8) '())
;(merge '() '())
;(merge '(1 3 9) '(2 4 6 10))

; List-of-X -> List-of-X (sorted)
(define (merge-sort l)
  ; create temporary arary, split into 2
  (cond [(null? l) '()]
        [(null? (cdr l)) l]
        [else (let ((left (car (split l)))
                    (right (cadr (split l)))
                    )
                (merge (merge-sort left) (merge-sort right))
                )])
  ; add 1 for the sentinel for each
  ; loop into the 2
  )
;(merge-sort '())
;(merge-sort '(1 5 9 -44 8 500 6 -10))