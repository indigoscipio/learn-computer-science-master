#lang racket

; Any -> List-of-any
; given an element x, check if it exists in a list
; if it exists, remove it, otherwise return as it is
(define (drop x list)
  (cond [(null? list) '()]
        [(eq? x (car list)) (cdr list)]
        [else (cons (car list) (drop x (cdr list))) ]
        )
  )
(drop 2 '()) ; return '()
(drop 3 '(1 2 3 5 9)) ; return '(1 2 5 9)
(drop 5 '(1 5)) ; return '(1)


;List-of-number -> List-of-number (Sorted)
(define (selection-sort list)

  ; approach 1: using tail iter/accumulator
  ; List-of-number List-of-number (Sorted) -> List-of-number (Sorted)
  ; acc stores sorted list so far
  #|
  (define (iter l acc)
    (cond [(null? l) (reverse acc)]
          [else (iter (drop (apply min l) l) (cons (apply min l) acc) )]
          )
    )
  (iter list '())
  |#


  ; approach 2: using basic recursion
  ; on each iteration, build the sorted list using recursion
  (cond [(null? list) '()]
        [else (cons (apply min list) (selection-sort (drop (apply min list) list)) ) ])

  ; approach 3
  
  )

(selection-sort '(1 3 5 8 7))