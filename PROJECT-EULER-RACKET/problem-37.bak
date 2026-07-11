#lang racket

#|
PROBLEM 36: DOUBLE BASE PALINDROMES
The decimal number, 585 = 1001001001 base 2 (binary) which is palindromic in bot hbases
find the sum of all numbers less than 1 million which are palindromic in base 10
and base 2
(please note that the palindromic number, in either base, may not include leading zeroes)

answer:
ok let me undertand the question
i think this is a simple one we wanna find palindromes numbers in both base 10 and 2
and we already given the ceiling which n < 1000000

approach
- need a helper that translates int to binary, maybe int->binary
- helper that cheks if a number is palindomic
- main function that checks if both those number is palindromic, if so store to count

|#
   
; given a number, checks if its a palindrome
; number -> boolean
; A sequence is a palindrome if it equals its own reverse.
(define (is-number-palindrome? xs)
  (equal? xs (reverse xs))
  )

; given an integer n, converts to binary representation
; number -> list-of-number
(define (int->binary n)
  ; base case: quotient is 0
  (define (loop curr-n result)
    (cond [(<= curr-n 0) result]
          [else (let ((q (quotient curr-n 2))
                      (r (remainder curr-n 2)))
                  (loop q (cons r result))
                  )]
          )
    )
  (loop n '())
  )

; given a number n, returns a list of digits that represents n
(define (num->digits n)
  (map (λ (c) (- (char->integer c) (char->integer #\0))) (string->list (number->string n)))
  )

; main func
(define (double-base-palindromes)
  (define (loop curr-n result)
    ; check if palindormic in both bases
    ; if so, add the sum (base10 sum im assuming), not the count
    ; else keep searching
    (cond [(> curr-n 1000000) result]
          [else (let ((curr-n-b2-lst (int->binary curr-n))
                      (curr-n-lst  (num->digits curr-n))
                      )
                  (if (and (is-number-palindrome? curr-n-lst)
                           (is-number-palindrome? curr-n-b2-lst))
                      (loop (+ curr-n 1) (+ curr-n result))
                      (loop (+ curr-n 1) result)
                      )
                  )]
          )
    )
  ; initialize with curr-n = 1
  (loop 1 0)
  )
(double-base-palindromes)
