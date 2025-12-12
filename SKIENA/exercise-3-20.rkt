#lang racket

; List-of-x -> Number
; given a list of item, finds its middle value
(define (find-mid l)
  ; using turle & hare pointer
  ; List-of-x Number Number -> Number
  (define (loop slow fast)
    (cond [(null? fast) (car slow)] ;list is empty, return slow
          [(null? (cdr fast)) (car slow)] ; fast pointer at the last element, return the middle value
          [else (loop (cdr slow) (cdr (cdr fast)))] ; else keep racing
          )
    )
  ; initialize with slow & fast at pos 0
  (if (null? l)
      (error "cant be empty")
      (loop l l)
      )
  
  )
(find-mid '())
(find-mid '(1))
(find-mid '(1 2 3 4 5 6))
