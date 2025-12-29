#lang racket

;3.2.1: evaluate the expr
; [j | i <- [1,-1,2,-2]; i > 0; j <- [1..i]]
;answer:
; ok so we know the result is j
; 1st generator:
; i <- [1,-1,2,-2] -> we need to process these 4 first
; [1, -1, 2,-2] such that i>0
; so i > 0 here is [1,2]
; 2nd generator
; j <- [1..i], so j depends on i
; we already have [1,2] as i so
; when i = 1 -> [1]
; when i = 2 -> [1,2]
; so [[1],[1,2]]


#|

3.2.2 under what conditions on xs and ys does the equation below hold?:
[x | x <- xs ; y <- ys] = [x | y <- ys ; x <- xs]

; answer
LHS
; we know the reslut is x
; 1st generator
; pull item from the list xs and name it x (the result)
; for each x, let 2nd generator run
; 2nd generator:
; pull item from list ys and name it y
; and get that as the result x
; xs = [1,2], ys = [a,b]
; x=1
;  y=a -> 1
;  y=b -> 1
; x=2
;  y=a -> 2
;  y-b -> 2
; [1,1,2,2]

RHS
the result is x
1st generator
for each item y in ys, run 2nd generator
2nd generator: x <- xs
pull item x from xs and get that as result x
xs = [1,2], ys = [a,b]
1st y: a
  1st x: 1 -> 1
  2nd x : 2 -> 2
2nd y: b
 1st x: -> 1
 2nd x -> 2
[1,2,1,2]

2 conditions:
when ys has exactly 1 lement [outputs [1,2]]
when ys is empty [] empty result
when all elements in xs are identical
when xs is empty

3.2.3
using list comprehension, define a function for counting the number of negative numbers in a list

answer:
;; count-negative:: [Int] -> Int
countNegs xs = length [x | x <- xs ; x < 0]
filter each number and check if its < 0
list the numbers that are negaitve
count those numbers and output as a result


3.2.4
define a function intpairs so that (intpairs n) is a list of all distinct
pairs of integers 1 <= x, y <= n

answer:
1st loop x
2nd loop y
intpairs n = [(x,y) | x <- [1..n] ; y <- [1..n]]

3.2.25
write program to find all quadruples (a,b,c,d) in the range 0 < a,b,c,d <= n such that
a^2 + b^2 = c^2 + d^2

answer:
quadruples n = [(a,b,c,d) | a <- [1..n] ; b <- [1..n] ; c <- [1..n] ; d <- [1..n] ; a^2 + b^2 == c^2 + d^2 ; (a, b) /= (c, d)  ]

3.2.6
define x^n using a list of comprehension

expt b n = product [b | i <- [1..n]]

3.2.7
determine the value of (divisors 0) where

divisors n = [d | d <- [1..n] ; n mod d = 0]

ansewr:
ok so we want to know what the value of divisors 0
so first determine the d
d comes from generator from 1 to 0
which means its an empty list since 1..0
and therefore the filter n mod d will not be evaluated since theres nothing int htelist

3.2.8
define a function mindivisor which returns smallest divisor
greater than 1, of a given positive integer
using mindivisor construct a function for testing wheter a number is prime
answer:

mindivisor n = min[d | d <- [2..n]; n mod d == 0]

primetest
a number is prime if it has a divisor 1 and itself
mindivisor 17 = 17 - so mindivisor needs to return that number itself to know a number is prime
is-prime? n = (mindivisor n) == n


3.2.9
define gcd to allow for zero arguments

gcd is largest number that divides a and b without a reminder

gcd = [d | d <- list1 ; (member? d list2)]

3.2.10
show that if n has a divisor in the range 1 < d < n then it has one in the range
1 < d <= sqrt(n)

d > sqrt(n) . k > sqrt(n)
= d . k > n
therefore it must be impossible


|#