#lang racket

; List-of-X Number Number Number -> Number
; perform a binary search
(define (binary-search list target start-index end-index)
  (let* ((mid-index (floor (/ (+ start-index end-index) 2)))
        (mid-element (list-ref list mid-index))
        )
    (cond [(> start-index end-index) '()] ;target not found
          [(eq? mid-element target) mid-element] ;target found
          [(< target mid-element) (binary-search list target start-index (- mid-index 1))]
          [else (binary-search list target (+ mid-index 1) end-index)]
          )
    )
  )
(define sample-list '(1 5 9 11 16 ))
(binary-search sample-list 16 0 (- (length sample-list) 1) )
(length sample-list)