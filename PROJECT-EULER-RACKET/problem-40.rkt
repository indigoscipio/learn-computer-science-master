#lang racket

#|
PROBLEM 40: CHAMPERNOWNE'S CONSTANT

an irrational decimal fraction is created by concatenating the
positive integers

0.1234567890[1]112131415161718192021
itcanbe seen that the 12th digit of the fractional part is 1
if dn represents the nth digit of the fractional part
find the value of the following expr

d1 x d10 x d100 x 1000 x d10000 x d100000 x d1000000

answer:
ok let me understand the question
so it wants me to find the value of those fractional aprts
1st fractional part x 10th frac digit x 100th fac digit x ... up to millionth fractional
digit
so input is irrational number and output is also number
im assuming those value result is always the same??

lets try to simplify the question
lets say we just do d1 * d10
so 1st frac digit * 10th frac digit
and lets do pi for example

3.1415926535
1st frac digit -> 1
10th frac digit -> 5
so for 2 digit the result is 5


approach
- helper function: given a fraction (or just extract the denom maybe),
extract the digit at given digit location d
- main function that multiples d1, d10, ..., d1mi
|#


; number -> list-of-number
(define (num->lst n)
  (map (λ (c) (- (char->integer c) (char->integer #\0)) ) (string->list (number->string n)))
  )

; number string -> number
(define (digit-at-pos d s)
  (- (char->integer (string-ref s (- d 1))) (char->integer #\0))
  )
;(digit-at-pos 0 1415926535) ; out of bound, too low
(digit-at-pos 1 "1415926535") ; 1
(digit-at-pos 10 "1415926535") ; 5
;(digit-at-pos 11 1415926535) ; out of bound, too high

; void -> number
; generate champ seq up to equal upper limit
(define (generate-champ-seq upper-limit)
   (string-append* (map number->string (range 1 (+ upper-limit 1))))
  )
(generate-champ-seq 15) ; 12345678910


(define (champernownes-constant)
  (let ((seq (generate-champ-seq 1000000)))
    (define (loop d result)
      (cond [(>= d 1000000) result]
            [else (let* ((curr-digit (digit-at-pos d seq))
                         (next-d (* d 10)))
                    (loop next-d (* curr-digit result))
                    )]
            )
      )
    (loop 1 1)
    )
  )
(champernownes-constant)
(string-length (generate-champ-seq 1000000))

