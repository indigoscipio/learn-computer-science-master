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
      (+ (expt x n) (foo x (- n 1))))))

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
assume the statement (foo x k) = x^k+1 - 1 / x-1 is true for some integer k


inductive step
we wanna prove the statement still hlds when we do (foo x (+ k 1))

since n (k + 1) does not equal 0, the else case is run
(+ (expt x n) (foo x (- k 1))))), substitute k + 1
x^k+1 + (foo x (k+1-1)) -> x^k+1 + (foo x k) ->

since we assumed (foo x k) = x^k+1 - 1 / x-1 we can substitute
x^k+1 + (x^k+1 - 1 / x-1)
x^k+1 (x-1) / x-1 + (x^k+1 - 1 / x-1)
x^k+2 - x^k+1 / x-1 + (x^k+1 - 1 / x-1)
x^k+2 - x^k+1 + x^k+1 - 1
x^k+2 - 1

; ===================================================

Exercise 2.17

Perhaps you have heard the following Christmas song:
On the first day of Christmas
My true love gave to me
A partridge in a pear tree.
On the second day of Christmas
My true love gave to me
Two turtle doves
And a partridge in a pear tree.
On the third day of Christmas
My true love gave to me
Three French hens,
Two turtle doves,
And a partridge in a pear tree.
And so on, through the twelfth day of Christmas. Note that on the first day, my
true love gave me one present, on the second day three presents, on the third day
six presents, and so on. The following procedure determines how many presents I
received from my true love on the nth day of Christmas:
44 Chapter2 RecursionandInduction
(define presents-on-day
(lambda (n)
(if (= n 1)
1
(+ n (presents-on-day (- n 1))))))
How many presents did I receive total over the 12 days of Christmas? This can
be generalized by asking how many presents I received in total over the first n
days. Write a procedure called presents-through-day (which may naturally use
presents-on-day) that computes this as a function of n. Thus, (presents
through-day 1) should return 1, (presents-through-day 2) should return
1 3 4,(presents-through-day 3) should return 1 3 6 10, etc

; ===================================================

|#

(define presents-on-day
  (lambda (n)
    (if (= n 1)
        1
        (+ n (presents-on-day (- n 1))))))

(define (presents-through-day n)

  #|
  (cond [(zero? n) 0]
        [else (+ (presents-on-day n) (presents-through-day (- n 1)))]
        )
  |#

  (let loop [[remaining n]
             [acc 0]]
    (cond [(zero? remaining) acc]
          [else (loop (- remaining 1) (+ (presents-on-day remaining) acc))]
          )
    )
  )
(presents-through-day 4)

; presents through day 1 -> calls presnts on day 1x, recurse 1x
; presents through day 2 -> calls presents on day 2x, recurse 2x


#|

Prove by induction that for every nonnegative integer n the following procedure
computes 2n:

(define f
  (lambda (n)
    (if (= n 0)
        0
        (+ 2 (f (- n 1))))))

answer:

BASE CASE
n = 0 -> goes to the 1st case and returns 0.
since 2n = 2(0) = 0 the base case holds.

INDUCTIVE HYPOTHESIS
assume the code computes f(k) = 2k for some aribtary integer k

INDUCTIVE STEP
we must show that the code works for k+1
since k isnt 0 it goes ot the else case

(+ 2 (f (- n 1)))) substitute with k+1
(+ 2 (f (- k 1)))) -> (+ 2 (f (- (k+1) 1)))) -> (+ 2 (f k)))  ->
since we know f(k) = 2k in IH substitute
(+ 2 2k) -> 2k + 2

show the this result matches the target formula n = k + 1
2n = 2(k+1) = 2k + 2

|#


; =====================================


#|
Exercise 2.19

Prove that for all nonnegative integers n the following procedure computes the value
2^(2^n):

(define foo
  (lambda (n)
    (if (= n 0)
      2
      (expt (foo (- n 1)) 2))))

Hint: You will need to use certain laws of exponents, in particular that (2^a)^b = 2^ab
and 2^a2^b = 2^(a+b)

answer:

BASE CASE
n = 0

the code
since n is 0 it goes to the 1st cond and returns 2
the formula
2^(2^0) -> 2^1 -> 2

therefore the base case holds

INDUCTIVE HYPOTHESIS
assume the code f(k) computes 2^(2^k) for some arbitrary k

INDUCTIVE STEP
we must show it also holds true for k+1
since k is not zero it goes to the else case

(expt (f (- k 1)) 2) -> substitute with k + 1
(expt (f (- (k + 1) 1)) 2)
(expt (f k) 2) which is (f k)^2

since we assumed fk = 2^(2^k) we can substitue
(2^(2^k))^2
2^((2^k) * 2)
2^(2^k * 2^1)
2^(2^k+1) - cant be simplified anymore

check with target formula
2^(2^n) - substitute with k+1
2^(2^k+1)

therefore it matches

|#


#|
Exercise 2.20

Prove that the following procedure computes n/(n+1) for any nonnegative integer n.
That is, (f n) computes n/(n+1) for any integer n >= 0.

(define f
  (lambda (n)
    (if (= n 0)
      0
      (+ (f (- n 1))
        (/ 1 (* n (+ n 1)))))))

answer:

BASE CASE
n = 0
the formula
n/(n+1) -> 0/(0+1) = 0/1 = 0

the code
since n = 0 it goes to the 1st case and returns 0;

therefore the base case holds.

-----

INDUCTIVE HYPOTHESIS

assume the code f(k) computes k/(k+1) for some integer k

-----

INDUCTIVE STEP

we must show that it also works for k + 1.
since k is not 0, it goes into the else case

(+ (f (- k 1)) (/ 1 (* k (+ k 1)))) -> substite with k + 1
(+ (f (- (k + 1) 1)) (/ 1 (* (k + 1) (+ (k + 1) 1))))
(+ (f k) (/ 1 (* (k + 1) (k + 2) ))) which is

(f k) + (1/k+1*k+2) - since we assume f(k) earlier substitute
k/k+1 + (1/k+1*k+2) - multiple left with k + 2
k . k+2/k+1*k+2 + 1/k+1*k+2
k^2+2k/k+1*k+2 + 1/k+1*k+2
k^2+2k+1/k+1*k+2
(k+1)(k+1)/k+1*k+2
k+1/k+2

check the target formula, subsitute n = k+1
k+1/(k+1+1)
k+1/k+2

therefore it matches

|#


#|
Exercise 2.22
Consider the following procedure

(define foo
  (lambda (n)
    (if (= n 0)
      0
      (+ (foo (- n 1))  (/ 1 (- (* 4 (square n)) 1))))))

a. What is the value of (foo 1)?Of(foo 2)?Of(foo 3)?
b. b. Prove by induction that for every nonnegative integer n, (foo n) computes
n/(2n+1).

answer:

a.
(foo 1) -> n = 1
since n is not 0, it goes to else case
(+ (foo (- 1 1))  (/ 1 (- (* 4 (square 1)) 1)))
(+ (foo 0)  (/ 1 3)) - we know foo 0 = 0, substitute
(+ 0  (/ 1 3))
(/ 1 3) = 1/3

(foo 2) -> n = 2
since n is not 0, goes to the else case
(+ (foo (- 2 1))  (/ 1 (- (* 4 (square 2)) 1)))
(+ (foo 1)  (/ 1 15)) - we know foo 1 is 1/3 from prev computation, substitute
(+ (/ 1 3)  (/ 1 15))
so the result is 1/3 + 1/15 = 5+1/15 = 6/15 = 2/5

(foo 3) -> n = 3
since n is not 0, goes to the else case
(+ (foo (- 3 1))  (/ 1 (- (* 4 (square 3)) 1)))
(+ (foo 2)  (/ 1 35)) - since we know foo 2 is 2/5 substitute
so its 2/5 + 1/35 = 14+1/35 = 15/35 = 3/7

b.

BASE CASE
n = 0

the code
since n is = 0, it goes in the 1st case which reutrns 0

the formula - n/(2n+1) - substitute
0/(2*0+1) = 0/1 = 0

therefore the base case holds

-----

INDUCTIVE STEP

assume the code (foo n) = f(k) computes the formula n/(2k+1) for some integer k

-----

INDUCTIVE HYPOTHESIS

we want to show it also holds true for k + 1
since k is not 0, it goes into the else case

(+ (f (- k 1))  (/ 1 (- (* 4 (square k)) 1))) - substitute with k+1
(+ (f (- (k+1) 1))  (/ 1 (- (* 4 (square (k+1))) 1)))
(+ (f k)  (/ 1 (- (* 4 (k+1)^2 ) 1))) which is

(f k) + 1/4(k+1)^2 - 1 >> since we assumed (fk) in IH substitute
k/(2k+1) + 1/4(k+1)^2 - 1
k/(2k+1) + 1/2(k+1)-1 * 2(k+1)+1
k/(2k+1) + 1/2k+1 * 2k+3

mult left side with 2k+3
k.(2k+3)/(2k+1)(2k+3) + 1/(2k+1) (2k+3)
2k^2+3k+1/(2k+1)(2k+3)
(2k+1)(k+1)/(2k+1)(2k+3)
(k+1)/(2k+3)

check formula and subtitute with n = k+1
k+1/(2(k+1)+1)
k+1/2k+2+1
k+1/2k+3

therefore it matches


|#
