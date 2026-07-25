#lang racket

;CHAPTER 4

;; BUBBLE SORT - overview
; pick pair and compare
; swap pair
; shift/move and comapre next pair, repeat until last pair


; BUBBLE SORT
; functional approach (LIST)

; list-of-number -> list-of-number
(define (all-but-last xs)
  (cond [(null? xs) '()] ; lets add this for guard
        [(null? (cdr xs)) '()]
        [else (cons (car xs) (all-but-last (cdr xs)))]
        )
  )
(all-but-last '(1))
(all-but-last '(1 2))
(all-but-last '(1 2 3))

; list-of-x -> list-of-x
; given a list of number, do a single 'bubble' sort pass
(define (bubble xs)
  (cond [(null? xs) '()]
        [(null? (cdr xs)) xs]
        [( > (car xs) (cadr xs)) (cons (cadr xs) (bubble (cons (car xs) (cddr xs)) ))]
        [else (cons (car xs) (bubble (cdr xs)))] ;build normally
        )
  )
(bubble '(5 1 4 2 8)) ; '(1 4 2 5 8)

; list-of-number -> list-of-number
(define (bubble-sort-v1 lst)

  #|
  ; using list building
  (cond [(null? lst) '()]
        [(null? (cdr lst)) lst]
        [else (let ((curr-bubble-pass (bubble lst)))
                (append (bubble-sort-v1 (all-but-last curr-bubble-pass))
                        (list (last curr-bubble-pass)))
                ) ]
        )
  |#

  ; using n-1
  (define (bubble-sort-v1-helper xs n)
    (cond [(zero? n) xs]
          [else (let((curr-pass (bubble xs)))
                  (bubble-sort-v1-helper curr-pass (- n 1))
                  )]
          )
    )
  (bubble-sort-v1-helper lst (- (length lst) 1))
  
  )
(bubble-sort-v1 '(5 1 4 2 8))


; BUBBLE SORT
; imperative approahc (VECTOR)
; two pointers (first two) -> slide these

