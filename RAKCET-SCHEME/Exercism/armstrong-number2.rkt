#lang racket

; Number -> Boolean
; Determines if a number is a armstrong number
(define (armstrong-number? n)
  ; build list of number from number using math
  ; Number -> List-of-numbers
  (define (build-lon n)
    (cond [(zero? n) '()]
          [else (cons (remainder n 10) (build-lon (quotient n 10)))]
          )
    )

  (define digits (build-lon n))
  
  ; compute each digits raised to the number of digits
  (define (sum-powers l power)
    (cond [(empty? l) 0]
          [else (+ (expt (car l) power) (sum-powers (cdr l) power))])
    )  
  
  ; sum them together and compare to n
  (= (sum-powers digits (length digits)) n)  
  )
(armstrong-number? 153)
(armstrong-number? 0)
(armstrong-number? 10)