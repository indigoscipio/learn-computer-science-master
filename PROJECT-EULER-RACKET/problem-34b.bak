#lang racket

#|
PROBLEM 34
DIGIT FACTORIALS

145 is a curious number as 1! + 4! + 5! = 1 + 24 + 120 = 145
find the sum of all numbers which are equal to the sum of the factorial of their digits

note: as 1! = 1 and 2! = 2 are not sums they are not included

answer:

ok let me understand the question
we wanna find sum of all number which are equal to the sum of the factorial of their digits
need to find the boundary

approach
- basic factorial
- helper that checks if each digit factorial sum is equal to itself
- main function that computs all fo the sums of those

now to find the boundary
i am assuming zeor factorial is not counted??
1 digit -> 0, 3! = 6, 4! = 12
2 digit -> 11 - 99 -> 1! + 1!, 9! + 9! -> 2 - 725760
3 digit -> 111 - 999 -> 1! + 1! + 1!, 9! + 9! + 9! -> 3 - 1088640
4 digit -> 1111 - 9999 -> 4 - 1451520
5 digit -> 11111 - 99999 -> 5 - 1814400
6 digit -> 111111 - 999999 -> 6 - 2177280
7 digit -> 1111111 - 9999999 -> 7 - 2540160
8 digit -> 11111111 - 99999999 -> 8 - 2903040 ---- this is the boundary

7 digits: smallest is 1,000,000
largest factorial sum is 7 × 9! = ?

At some point, the maximum possible
factorial sum for an n-digit number becomes less than the
smallest n-digit number. Once that happens, no n-digit number can ever be a solution
so you have your upper bound. Work out when that crossover happens.

On zero and one:
Your instinct is right to be suspicious.
The problem explicitly excludes 1 and 2 because they're "not sums"
meaning a single digit isn't really summing anything.
So your loop should start at 3 or 10, and you don't need to worry about 0! at all.


One thing worth thinking about:
Factorial of digits 0-9 will be called many many times as you iterate.
Do you want to recompute them every time, or is there a smarter way to organize that?
Not a blocker, just something a CS learner should notice.

|#

; number -> number
(define (fact n)
  (cond [(zero? n) 1]
        [else (* n (fact (- n 1)) )]
        )
  )

; helper: num->list-of-num
; number -> list-of-numbers
(define (num->list-of-num n)
  (map (λ (char) (- (char->integer char) (char->integer #\0)) ) (string->list (number->string n)))
  )

; number -> boolean
(define (is-sum-digit-factorial? n)
  ; divide n into individual digits
  ; sum their digit factorials
  ; check if its equal to original n
  
  (let* ((nums (num->list-of-num n))
        (fact-nums-sum (foldr (λ (n acc) (+ (fact n) acc) ) 0 nums))
        )
    (if (< n 2)
        #f
        (= n fact-nums-sum)
        )
    )  
  )
(is-sum-digit-factorial? 100) ;#f
(is-sum-digit-factorial? 145) ;#t

; main function
(define (digit-factorials)
  ; boundary is 7 digit
  ; dont recompute everytime
  ; maybe use like memo or dp? notsure how to doit

  (define (helper n max-bound result)
    (cond [(> n max-bound) result]
          [(is-sum-digit-factorial? n) (helper (+ n 1) max-bound (+ n result) ) ]; add to result
          [else (helper (+ n 1) max-bound result)] ;keep finding
          )
    )
  (helper 11 9999999 0) ; yeah this is insanely slow and laggy but works
  )
(digit-factorials) ;40730