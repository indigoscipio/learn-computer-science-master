#lang racket

; Number -> Boolean
; Determines if a number is a armstrong number
(define (armstrong-number? n)

  ; check how many digits are there and extract it
  (define (build-lon n)
    (map (lambda (x) (- (char->integer x) (char->integer #\0) ) ) (string->list (number->string n)))
    )


  (define list-length (length (build-lon n)))
  
  ; compute each digits raised to the number of digits
  (define final-value (foldr (lambda (d acc) (+ (expt d list-length) acc) ) 0 (build-lon n)))

  ; sum them together and compare to n
  (= final-value n)  
  )
(armstrong-number? 153)
(armstrong-number? 0)
(armstrong-number? 10)