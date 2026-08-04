#lang racket

; RECURSION

; EXERCISES
#|
EXERCISE 1

The following function prints every other number from a low number to a
high number. For example, if low is 0 and high is 10, it would print:
0
2
4
6
8
10
Identify the base case in the function:
def print_every_other(low, high):
if low > high:
return
print(low)
print_every_other(low + 2, high)

answer:
not very familiar with pyhton but lets try ti
in racket this is jut print even number

the base case seems when low exceeds high (low > high)
since in every recursive call we increment low by +2
and keep high as it is, it will eventually pass high
so the if low > high; return is the bsae case

in racket it would be something lke this
|#
(define (print-every-other low high)
  (cond [(> low high) '()]
        [else (cons low (print-every-other (+ low 2) high))]
        )
      )
(print-every-other 0 10)


; =============================================

#|
EXERCISE 2
My kid was playing with my computer and changed my factorial function
so that it computes factorial based on (n-2) instead of (n-1). He also changed
number<=1 to number==1. Predict what will happen when we run factorial(10)
using this function:

def factorial(number):
if number == 1:
return 1
else:
return number * factorial(number-2)

answer:
lets analyze this again with my shitty python skill
so the question asks whats gonna happen with the modified code

since we changed the base case to number ==1
and each recursive call decrements the number by 2

when we run factorail(10)
the input n/number will become
10 -> 8 -> 6 -> 4 -> 2 -> 0 -> -2 -> ...
so the function will never terminates
since it will never reach the base case


|#

; =============================================


#|
EXERCISE 3
Following is a function in which we pass in two numbers called low and
high. The function returns the sum of all the numbers from low to high. For
example, if low is 1 and high is 10, the function will return the sum of all
numbers from 1 to 10, which is 55. However, our code is missing the base
case and will run indefinitely! Fix the code by adding the correct base case:


def sum(low, high):
return high + sum(low, high-1)

answer:
ok let me try to fix this in racket
let me understnad the question frist
ok so it prints sum of number from low to high by increment 1

so it seems we decrement the high here instead of incrementing the low
so the base case happens when high reaches low or more
so base case shuold be when high < low

in racket i would just do the opposite, incrment the low
|#

(define (sum-of-num low high)
  (cond [(> low high) 0]
        [else (+ low (sum-of-num (+ low 1) high))]
        )
  )
(sum-of-num 0 10) ;returns 55

; or with the high decrement whichis the same ithink
; as long as high is not lower then low
(define (sum-of-num-v2 low high)
  (cond [(< high low) 0]
        [else (+ high (sum-of-num low (- high 1)))]
        )
  )
(sum-of-num-v2 0 10) ;returns 55


; =============================================

#|
4. Here’s an array containing both numbers and arrays, which in turn con
tain numbers and arrays:

ARRAY = [ 1,
2,
3,
[4, 5, 6],
7,
[8,
[9, 10, 11,
[12, 13, 14]
]
],
[15, 16, 17, 18, 19,
[20, 21, 22,
[23, 24, 25,
[26, 27, 29]
], 30, 31
], 32
], 33
]

Write a recursive function that prints all the numbers (and just numbers).

|#

(define array '(1
                2
                3
                (4 5 6)
                7
                (8
                 (9 10 11
                    (12 13 14)))
                (15 16 17 18 19
                    (20 21 22
                        (23 24 25
                            (26 27 29))
                        30 31)
                    32)
                33))


; list-of-list -> list-of-number
; idont remember hopefully this is correct
; letsjust do flatten since it will eventually print anyway
(define (flatten xxs)
  ; a number? print it
  ; a list/pair? recurse
  ; otherwise recurse
  (cond [(null? xxs) '()]
        [(number? (car xxs)) (cons (car xxs) (flatten (cdr xxs)) )]
        [else (append (flatten (car xxs))
                      (flatten (cdr xxs))) ] ;sublist
        )
  )
(flatten array)
