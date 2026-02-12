#lang racket

; list-of-number -> boolean
; given a sequence of numbers, checks if its decreasing
(define (is-valid-sequence? n nums)
   (equal? (range 1 n) (sort nums <))
  ; are the numbers between 1 and n-1?
  )
; helper to find absulote sequence
; list-of-number list-of-number -> list-of-number
(define (loop-abs xs result)
  (cond [(empty? xs) (reverse result)]
        [(empty? (cdr xs)) (reverse result)]
        [else (loop-abs (cdr xs) (cons (abs (- (car xs) (cadr xs))) result) )])
  )

; JOLLY JUMPERS
; number -> boolean
(define (is-jolly-jumpers? nums)
  ; base case, the list is empty, return the result
  ; check (abs (- 4 1))
  ; then check (abs (- (abs (- 4 1)) 4))
  (let* ((n (car nums))
        (num-sequences (cdr nums))
        (abs-xs (loop-abs num-sequences '()))
        )
    (is-valid-sequence? n abs-xs)
    )

  )
(is-jolly-jumpers? '(4 1 4 2 3))
(is-jolly-jumpers? '(5 1 4 2 -1 6))