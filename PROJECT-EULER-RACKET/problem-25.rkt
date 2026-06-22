#lang racket

#|
PROBLEM 25
the fibonaci sequence is defined by the recrrence relation:
fn = fn-1 + fn-2 where f1 = 1 and f2 = 1

hence the first 12 terms will be

f1 = 1
f2 = 1
f3 = 2
f4 = 3
f5 = 5
f6 = 8
f7 = 13
f8 = 21
f9 = 3$
f10 = 55
f11 = 89
f12 = 144

the 12th term, f12 is the first term to contain three digits
what is the index of the first term in the fibonaci sequence to contain 1000 digits?

answer:
let me think, maybe we can apporach this simple
the task isn't summing so we dont need to gnerate a seq of fibonacis
fofcus on finding the first one that has the most digit

- generate fibonaci term k
- for each term check if the digit is the first to contain 1000
- if so return the index of that number - the term

Ask yourself — do you actually need a function that jumps to the nth fibonacci
number directly? Or can you instead walk forward from f1, keeping only the last
two terms you need to compute the next one, and stop when you hit your condition?
This is the difference between:

"give me fib(n)" — requires knowing n in advance, expensive if done recursively
"keep generating the next term until some condition is met" —
only needs the previous two values at any moment
|#

;given an integer n and nonneg digit d, checks if a given number n contains d digits
(define (num-contains-d-digits? n d)
  (= (string-length (number->string n)) d)
  )
(num-contains-d-digits? 100 3) ;#t
(num-contains-d-digits? 1234 4) ;#t
(num-contains-d-digits? 5 0) ; #f

; given a number n, returns the index of first term in the fibonaci sequence to contain n digits
(define (nth-digit-fib-num n)
  
  (define (loop f1 f2 curr-fib curr-term)
    (cond [(num-contains-d-digits? curr-fib n) curr-term]
          [else (loop f2 curr-fib (+ curr-fib f2) (+ 1 curr-term) ) ]
          )
    )
  (loop 1 1 2 3)
  )
(nth-digit-fib-num 3) ; should return term 12
(nth-digit-fib-num 1000) ; should return term 12