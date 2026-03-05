#lang racket



; Exercise 2.7
; Rewrite sum-integers-from-to in this alternative way
; that is, by increseaing low
; Number Number -> Number 
(define (sum-integers-from-to a b)
  (cond [(> a b) 0]
        [else (+ (sum-integers-from-to (+ a 1) b) a)])
  )
(sum-integers-from-to 1 3)


#|
Another type of generalization of sum-of-first can be obtained by varying what
is being summed, rather than just the range of summation:
a. Write a procedure sum-of-squares that computes the sum of the first n squares,
where n is a nonnegative integer.
b. Write a procedure sum-of-cubes that computes the sum of the first n cubes,
where n is a nonnegative integer.
c. Write a procedure sum-of-powers that has two parameters n and p, both non
negative integers, such that (sum-of-powers n p) computes 1p 2p
np.
|#

;; computes the sum of first n squares
(define (sum-of-squares n)
  (cond [(zero? n) 0]
        [else (+  (* n n) (sum-of-squares (- n 1)))])
  )
(sum-of-squares 10)

;; computes the sum of first n cubes
(define (sum-of-cubes n)
  (cond [(zero? n) 0]
        [else (+  (* n n n) (sum-of-cubes (- n 1)))])
  )
(sum-of-cubes 10)

;; computes the sum of powers
(define (sum-of-powers n p)
  (cond [(zero? n) 0]
        [else (+  (expt n p) (sum-of-powers (- n 1) p ))])
  )
(sum-of-powers 2 8)


(define (num-digits n)
  (cond [(< n 10) 1]
        [else (+ 1 (num-digits (quotient n 10)))])
  )
(num-digits 999)

#|
Write a procedure that computes the number of 6s in the decimal representation of
an integer. Generalize this to a procedure that computes the number of d’s, where
d is another argument.
|#

(define (count-sixes n d)
  (cond [(< n 10) (if (equal? n d) 1 0)]
        [(equal? (remainder n 10) d) (+ 1 (count-sixes (quotient n 10) d))]
        [else (count-sixes (quotient n 10) d)])
  )
(count-sixes 6166 6)

#|
Exercise 2.10
Write a procedure that calculates the number of odd digits in an integer. (Reminder:
There is a built-in predicate called odd?.)
|#

(define (count-odds n)
  #|
  (cond [(zero? n) 0]
        [(odd? (remainder n 10)) (+ 1 (count-odds (quotient n 10)))]
        [else (count-odds (quotient n 10))])
  |#
  

  #|
  ; with named let
  (let loop ((remaining n)
             (acc 0)
             )
    (cond [(zero? remaining) acc]
          [(odd? (remainder remaining 10)) (loop (quotient remaining 10) (+ 1 acc))]
          [else (loop (quotient remaining 10) acc)]
          )
    )
  |#
 0
  
  )
(count-odds 1230)


#|
2.11
Write a procedure that computes the sum of the digits in an integer
|#

(define (sum-of-digits n)

  #|
  (cond [(zero? n) 0]
        [else (+ (remainder n 10) (sum-of-digits (quotient n 10)) ) ])
  |#

  (let loop ((remaining n)
             (acc 0))
    (cond [(zero? remaining) acc]
          [else (+ (remainder n 10) (sum-of-digits (quotient n 10)) )]
          )
    )
  )
(sum-of-digits 123)

#|
Any positive integer i can be expressed as i 
2nk, where k is odd, that is, as a
power of 2 times an odd number. We call n the exponent of 2 in i. For example, the
exponent of 2 in 40 is 3 (because 40 235) whereas the exponent of 2 in 42 is 1. If
i itself is odd, then n is zero. If, on the other hand, i is even, that means it can be
divided by 2. Write a procedure for finding the exponent of 2 in its argument.
|#

; find out how many times you can divide a number by 2 before you're left with odd number
(define (find-expo n)
  
  (cond [(odd? n) 0]
        [else (+ 1 (find-expo (/ n 2)))] ;keep dividing by two
        )

  (let loop ((remaining n)
             (expo-count 0))
    (cond [(odd? remaining) expo-count]
          [else (loop (/ remaining 2) (+ 1 expo-count))])
    )
  
  )
(find-expo 40)

#|

> Exercise 2.16
Consider the following procedure foo:

(define foo (lambda (x n)
   (if (= n 0)
      1
      (+ (expt x n) (foo x ( n 1))))))

Use induction to prove that (foo x n) terminates with the value
x^n+1 -1 / x-1

for all values of x does not equal 1 1 and for all integers n≥0. You may assume that
expt works correctly, (i.e., (expt b m) returns b").
Hint: The inductive step will involve some algebra.

answer:
base case
n = 0 -> the code returns 1
plug in the formula -> x - 1 / x - 1 = 1 -> true

inductive hypothesis
assume the statement (foo x k) = x^n+1 - 1 / x-1 is true for some integer k


inductive step
we wanna prove the statement still hlds when we do (foo x (+ k 1))

since n (k + 1) does not equal 0, the else case is run
(+ (expt x n) (foo x ( n 1))))), substitute k + 1
x^k+1 + (foo x k)


|#


