#lang racket

(define (divide a d)
  ; counter holds the quotients
  ; acc holds the reminder
  (define (iter q r)
    (cond [(< r d) (cons q r)]
          [else (iter (add1 q) (- r d)) ]
          )
    )
  (iter 0 a)
  )
(divide 8 3)


; euclidean algorithm
(define (my-gcd A B)
  ; Number Number  -> Number
  ; a is the current number being divided
  ; b is the divisor
  (define (gcd-iter a b)
    (cond [(= b 0) a]
          [else (gcd-iter b (modulo a b)) ])
    )
  (gcd-iter A B)
  )