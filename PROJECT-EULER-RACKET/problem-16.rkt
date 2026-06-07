#lang racket

#|
PROBLEM 16
power digit sum

2^15 = 32768 and the sum of its digits is 3+2+7+6+8 = 26
what is the sum of the digits of the number 2^1000?


answer:
ok lets keep this simple.
just use expt -> convert to list -> then sum the digits using foldr.

|#

; given n, calculates sum of digits of the number 2^n
(define (power-digit-sum n)
  (let* ((total-sum (expt 2 n))
        (num-str (number->string total-sum))
        (num-lst (map (λ (char) (- (char->integer char) (char->integer #\0)) ) (string->list num-str)))
        )
    (foldr + 0 num-lst)
    )
  )
(power-digit-sum 15) ;should return 26
(power-digit-sum 8) ; should return 2+5+6 = 13
(power-digit-sum 1000) ; returns 1366