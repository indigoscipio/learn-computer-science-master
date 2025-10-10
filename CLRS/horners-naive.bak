#lang racket

; given a non empty list
; swaps 1st and 2nd item
; leave it be otherwise (if empty or 1)
; List-of-x -> List-of-x
(define (swap l)
  (cond [(null? l) '()]
        [(null? (cdr l)) l]
        [else (cons (cadr l) (cons (car l) (cddr l) ) )]
        )
  )
(swap '(1 2 3 4)) ;should return '(2 1 3 4)
(swap '(1 2)) ; should return '(2 1)
(swap '(2)) ; leave as it is
(swap '()) ; leave as it is


(define (bubble-sort list)
  ;outer loop
  (define (loop1 l1)
    (cond [(null? l1) '()]
          [(equal? l1 (loop2 l1)) l1]
          [else (loop1 (loop2 l1))])
    )

  ; inner loop
  ; List-of-x -> List-of-x (Sorted)
  (define (loop2 l2)
    (cond [(null? l2) '()]
          [(null? (cdr l2)) l2] ; one lement left, theres nothing to compare with
          [(<= (car l2)(cadr l2)) (cons (car l2) (loop2 (cdr l2)))] ;already sorted
          [else (cons (cadr l2) (loop2 (cons (car l2) (cddr l2)))) ]
          )
    )
  
  (loop1 list)
  )
(bubble-sort '())
(bubble-sort '(2))
(bubble-sort '(5 2))
(bubble-sort '(1 -8 11 97 5))