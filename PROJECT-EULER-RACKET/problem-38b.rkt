#lang racket

#|
PROBLEM 38: Pandigital Multiples
take the number 192 and mult it by each 1,2,3

192 * 1 = 192
192 * 2 = 384
192 * 3 = 579

by concatenating each product weget the 1-9 pandigital, 192384576
we will call 192384576 the concatenated product of 192 and (1,2,3)

the same can be achieved by starting with 9 and multiplying by 1,2,3,4,5
giving pandigital 918273645 which is concatenated product of 9 and (1,2,3,4,5)

what is the largest 1 - 9 pandigital 9 digit number that can be formed
as the concatenated product of and integer with (1,2,3,...,n) where n > 1?

answer:
ok let me understand the question

it wants me to find largest 9 digit pandigital that can be formed
as concateed product with itneger(1,2,..,n.) wher n > 1

let find the search space
since its pandigital its 9 digit max
but the thing is n can range from anywhere
it only wants me to find the largest pandigital
largest means probably 1st digit must start with 9 then? hmmm

from the example the integer is 9 and n  is 5
9 x 1 = 9
9 x 2 = 18
9 x 3 = 27
9 x 4 = 36
9 x 5 = 45
concat -> '(9 1 8 2 7 3 6 4 5) -> pandigital

UPPER BOUND
; num = 9 digit number is ruled out since n > 1
; num = 8 digit -> n = 2 -> 8 digit + 8 digit -> 16 digit | not valid
; num = 7 digit -> n = 2 -> 7 digit + 7 digit -> 14 digit | not valid
; num = 6 digit -> n = 2 -> 6 digit + 6 digit -> 12 digit | not valid
; num = 5 digit -> n = 2 -> 5 digit + 5 digit -> 10 digit | not valid
; num = 4 digit -> n = 3 -> not valid
; num = 4 digit -> n = 2 -> 4+4 -> not valid
; num = 4 digit -> n = 4 -> not valid
; num = 3 digit -> n = 3 -> 3 + 3 + 3 -> valid
; num = 2 digit -> n = 4 -> 2+2+2+2 -> not valid
; num = 1 digit -> n = 9 -> valid
search space: 1 digit number (1 - 9), 3 digit number (100 - 999)


approach
- helper that multiplies the integer by n incrmeentally, maybe sends back as list of numbers
- helper that concats a list of numbers -> can use append?
- helper that chceks wheter a given digit is pandigital
- main function tha takes the number and n

|#

; number number -> list-of-digits
(define (increment-mult num n)
  (reverse (cond [(zero? n) '()]
        [else (cons (* n num) (increment-mult num (- n 1)))]))
  )
(increment-mult 192 3)

; given a number n, returns a list of digit of n
(define (number->digits n)
  (map (λ (c) (- (char->integer c) (char->integer #\0)) ) (string->list (number->string n)))
  )
(number->digits 576) ; '(5 7 6)

; given a list of numbers, returns a list of digits of that number
(define (numbers->digits numbers)
  (foldr (λ (n acc) (append (number->digits n) acc) ) '() numbers)
  )
(numbers->digits '(576 384 192)) ; '(5 7 6 3 8 4 1 9 2)

; list-of-number -> boolean
(define (is-pandigital? num-digits)
  (let ((table (make-vector 10)))
    (define (loop curr-digits)
      (cond [(null? curr-digits) #t]
            [(equal? (vector-ref table (car curr-digits)) #t) #f]
            [else (begin (vector-set! table (car curr-digits) #t)
                         (loop (cdr curr-digits))
                         ) ]
            )
      )
    
    (vector-fill! table #f)
    
    ; pandigital must have length exactly 9
    ; and pandigital must have a nonzero digit (1 - 9)
    (if (or (not (= (length num-digits) 9))
            (member 0 num-digits)
            )
        #f
        (loop num-digits)
        )
    )
  )
(is-pandigital? (number->digits 123456789))
(is-pandigital? (number->digits 12))
(is-pandigital? (number->digits 0))
(is-pandigital? (number->digits 192384576))
(is-pandigital? (number->digits 918273645))

(define (digits->number digits)
  (foldl (λ (d acc) (+ d (* 10 acc) ) ) 0 digits)
  )
(digits->number '(9 8 7 6 5 4 3 2 1)) ;987654321

; number number -> number
; search space: 1 digit number (1 - 9), 3 digit number (100 - 999)
(define (pandigital-multiples)
  ; collect the pandigital that can be formed with curr-num and curr-n
  ; number number number -> list-of-numbers
  (define (loop num-min num-max n result)
    ; base : stop when curr-num reaches n-max
    (cond [(> num-min num-max) result]
          [else (let* ((mult-nums (increment-mult num-min n))
                       (mult-nums-digits (numbers->digits mult-nums))
                       (curr-num (digits->number mult-nums-digits))
                       )
                  (if (is-pandigital? mult-nums-digits)
                      (loop (+ num-min 1) num-max n (cons curr-num result)) ; add to result
                      (loop (+ num-min 1) num-max n result ) ; skip
                      )
                  )]
          )
    )
  (sort (append (loop 1 9 9 '())
                (loop 1000 9999 2 '())
                (loop 100 999 3 '())) >)
  )
;(pandigital-multiples)