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
(define (is-number-palindrome? n)
  (let* ((num-lst (map (λ (c) (- (char->integer c) (char->integer #\0))) (string->list (number->string n))) )
         (num-lst-rev (reverse num-lst)))
    ; 1 digit number is always a palindrome
    (equal? num-lst num-lst-rev)
    )
  )
(is-number-palindrome? 303) ;#t
(is-number-palindrome? 99) ; #t
(is-number-palindrome? 8) ; #t
(is-number-palindrome? 358) ; #f

; given an integer n, converts to binary representation
; number -> number
#|
Given n, ask: what's the remainder when I divide by 2?
That's the least significant bit.
Then what do I do with the rest? (quotient n 2) Then repeat.
So binary conversion is naturally recursive
Each step peels off one bit. The base case is when n reaches 0.
The output is a sequence of 0s and 1s. Think about what shape (list

16 -> divide by 2 -> q = 8, r = 0
8 -> divide by 2 -> q = 4, r = 0
4 -> divide by 2 -> q = 2, r = 0
2 -> divide by 2 -> q = 1, r = 0
1 -> divide by 2 -> q = 0, r = 1
build up from last -> 1 0 0 0 0
hmm, do i set result acc as list of number or just nmber
lets just do ist of number its simpler
ifiremmeber we can also use foldr or smth but lets save this for later
|#

; digits->number:: given a list of digits, converts it back to a number
(define (digits->number xs)
  (foldl  (λ (d acc) (+ d (* 10 acc)) ) 0 xs)
  )
(digits->number '(1 0 1)) ; 1 + 0 + 100

; number -> number
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
  (digits->number (loop n '()))
  )
(int->binary 1) ; should return 1
(int->binary 3) ; 11
(int->binary 4) ; 100
(int->binary 7) ; 111
(int->binary 16) ; 10000

; main func
(define (double-base-palindromes)
  (define (loop curr-n result)
    ; check if palindormic in both bases
    ; if so, add the sum (base10 sum im assuming), not the count
    ; else keep searching
    (cond [(> curr-n 1000000) result]
          [else (let ((curr-n-b2 (int->binary curr-n)))
                  (if (and (is-number-palindrome? curr-n)
                           (is-number-palindrome? curr-n-b2))
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