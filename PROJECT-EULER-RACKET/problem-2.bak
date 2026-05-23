#lang racket


; PROBLEM 1
; if we list all nat num below 10 that are mults of 3 or 5 we get 3,5,6,9. the sum of those is 23
; find sum of all multiples of 3 or 5 below 1000.

; method 1: tail iter/accum
(define (mult-3-or-5 lst)
  ; find factors that are divisible by 3
  ; find factors that are divisible by 5
  ; sum those factors

  ; list-of-x list-of-x -> list-of-x
  (define (loop xs result)
    (cond [(null? xs) result]
          [(or (zero? (remainder (car xs) 3))
               (zero? (remainder (car xs) 5)))(loop (cdr xs) (cons (car xs) result))]
          [else (loop (cdr xs) result)] ;else recurse
          )
    )

  ; initialize with xs = lst and result = '()
  ; sum the whole list
  (foldr + 0 (loop lst '()))

  )
(mult-3-or-5 (range 1 1000))


; method 2: chaining HOFs
(define (mult-3-or-5-v2 xs)
  (let* ((lst (filter (λ (x) (or (zero? (remainder x 5))
                     (zero? (remainder x 3))
                     )) xs))
        (sum (foldr + 0 lst))
        )
    sum
    )
  )
(mult-3-or-5-v2 (range 1 1000))