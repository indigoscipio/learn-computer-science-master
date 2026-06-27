#lang racket

#|
PROBLEM 30 - DIGIT FIFTH POWER

surprisingly there are only 3 numbers that can be written as the sum of fourth powers of
their digits

1634 = 1^4 + 6^4 + 3^4 + 4^4
8208 = 8^4 + 2^4 + 0^4 + 8^4
9474 = 9^4 + 4^4 + 7^4 + 4^4

as 1 = 1^4 is not a sum so its not included

the sum of these numbers is 1634+8208+9474 = 19316
find the sum of all the numbers that cna be written as the sum of fifth powers of their digits

answer:

ok let me understand the quetsion
we wanna find sum of all nums that can be written as the sum of fifts powers of their digits

so we know in n^4 example

1634 -> 1 + 1296 + 81 + 256
1 -> excluded
so it can be formed from any digit 0 - 9 power

lets do a small example -> second power
5 = 2^2 + 1^2
13 = 2^2 + 3^2
25 = 3^2 + 4^2

or maybe im understanding this incorrectly

planned approach
- 


|#

