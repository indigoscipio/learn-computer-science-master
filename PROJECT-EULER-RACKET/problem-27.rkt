#lang racket

#|
PROBLEM 27
QUADRATIC PRIMES

Euler discovered the remarkable quadratic formula:
It turns out that the formula will produce 40primes for the consecutive integer values
0 <= n <= 39

however when n^2 = 40, 40^2 + 40 + 41 = 40(40 + 1) + 41 is divisibel by 41
and certainly when n = 41, 41^2 + 41 + 41 is clearly divisible by 41

the incredible formula n^2 - 79n + 1601 was discovered which procudes 80 primes for the consecutive
values 0 <= n <= 79. the product of the coefficients, -79 and 1601 is -126479

considering quadratics of the form

n^2 + an + b where |a| < 1000 and |b| <= 1000

where |n| is the modulus/absolute value of n
eg |11| = 11 and |-4| = 4




|#