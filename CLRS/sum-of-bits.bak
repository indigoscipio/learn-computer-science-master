#lang racket

; inserts a number correctly to a list of sorted number
; Number List-of-number -> List-of-number
; build the list on each iteration
(define (insert n l)
  (cond [(null? l) (cons n '())]
        [(>= n (car l)) (cons (car l) (insert n (cdr l)))] ; skip
        [else (cons n l)] ;otherwise put it and insert the rest
        )
  )
(insert 19 '(-2 0 1 2 5 6 19))

; List-of-number -> List-of-number
; perform an insertion sort given a list
(define (insertion-sort list)
  ;take the first element
  ; recursivel sort the rest
  ; insert the first element into the sorted rest
  (cond [(null? list) '()]
        [else (let ((key (car list))
                    (rest (cdr list))
                    )
                (insert key (insertion-sort rest))
                )])
  )
(insertion-sort '(0 8 -9 11 31 -444))

;2.1-2
;Rewrite the INSERTION-SORT procedure to sort into nonincreasing instead of non
;decreasing order.