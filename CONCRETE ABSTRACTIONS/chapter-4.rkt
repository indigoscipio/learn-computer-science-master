#lang racket

; ORDERS OF GROWTH & TREE RECURSION


#|
Exercise 4.1
Go ahead and figure out exactly what n + (n 1) + ... + 2 + 1 is.
Do this by adding
the first term to the last, the second to the second from last, and so forth. What does
each pair add up to? How many pairs are there? What does that make the sum?

answer:
(n + 1) + ((n-1) + 2) + ((n-2) + 3) + ... (first n-midpoint) + last midpoint

so if n = 5
(5 + 1) + (4 + 2) + (3)
so 2 total pairs + one half pair => so it makes 2n total pairs + 1/2 pair

sum = 6 + 6 + 3 = 15

total number of pair = n/2
total value of each pair = n+1
multiply it = n/2 * n + 1 -> n(n+1)/2 = n^2+n/2



|#