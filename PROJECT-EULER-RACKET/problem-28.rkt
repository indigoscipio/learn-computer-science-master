#lang racket

#|
Problem 28
starting with the number 1 and moving to the right in a clockwise direction by a 5x5
spiral is formed as follows

21 22 23 24 25
20  7  8  9 10
19  6  1  2 11
18  5  4  3 12
17 16 15 14 13

it can be verified that the sum of the numbers on the diagonals is 101
what is the sum of the numbers on the diagonals in a 1001 x 1001 spiral formed
in the same way?

answer:

ok let me undestand this
we have a 5x5 numbers with 1 starting at the centr
so 0-4 row and 0-4 col

let me get a sense of the pattern
1 is in the middle -> r=2, c=2
2 is the right -> r=3, c=2 
3 bottom of that -> r=3, c=3
4 to the left -> r=3, c=2
5 to the left -> r=3, c=1
6 up -> r=2, =c1
7 up -> r=1, c=1

yeah i cant sense any pattern
lets do 3x3
7  8  9
6  1  2
5  4  3
diagonals are 1,3,5,7,9 = 25
the corners in 3x3 are 1 number apart
here it increments by 2

but in 5x5 the corners are 3 apart
so incrmeent by 4

in 7x7 the corners are 5 apart -> increment by 6

now weneed to find how far apart 1001 by 1001
it's 1001 - 2 apart, so 999 between those two numbers
so we need to increment by +1000 to reach first to last

side length : s
gap between corners : s-1
last corner is a perfect square: s^2

a few approaches
- find corner values
- sum them lal

subproblems to tackle
- find last corner (can just inline, n^2)
- given n, find its all four corner
- sum all corners


|#

; given a number n >= 3 (nxn grid/side length), returns the sum of its four corners
; number -> number
(define (sum-corners n)
  (let* ((last-corner (sqr n))
        (corner0 (- last-corner (- n 1)))
        (corner1 (- corner0 (- n 1)))
        (corner2 (- corner1 (- n 1)))
        )
    (+ last-corner corner0 corner1 corner2)
    )
  )
(sum-corners 3) ;9+7+5+3= 24
(sum-corners 5) ;25+21+17+13= 76


; given a nxn spiral number grid, computes the sum of the two main diagonals
; number -> number
(define (num-spiral-diagonals-sum n)
  (define (helper curr-n result)
    (cond [(> curr-n n) (+ 1 result)] ;done, return result + 1
          [else (let ((curr-diag-sum (sum-corners curr-n)))
                  (helper (+ curr-n 2) (+ curr-diag-sum result) )
                  )] ; keep summing
          )
    )
  (helper 3 0)
  )
(num-spiral-diagonals-sum 5)
(num-spiral-diagonals-sum 1001)