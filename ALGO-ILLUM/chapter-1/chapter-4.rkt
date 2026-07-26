#lang racket

; CHAPTER 4: The Master Method

#|

T(n) = a . T(n/b) + O(n^d)
a = number of smaller subproblem spawned/branced (recursive calls)
b = factor by which input size shrinks (n/2 = halfing the size)
d = exponent in running time in 'combine' step

T(n) = work done by recursive call + work done outside recursive call

requirement
- b > 1 must shrink by same factor b
- a >= 1, must recurse atleast 1 time
- d >=0, outside calls work must be atleast O(1)

case:
- root win: a < b^d -> O(n^d)
input shrinks faster than subproblem spawns
most work at the root/top

- tie: a = b^d -> O(n^d . logn)
work equally balanced
spawns smaller subproblem and shrinks input equally

- leaves win: a > b^d -> O(n^logb a)
spawns new branches more than reducing the problem/input
most work happen a the bottom

example: Merge Sort
subproblem spawned = a = 2
input shrinked =  b = 2
merge/outside problem -> d=1

b^d = 2
a = 2
2 = 2 -> tie

Karatsuba
subproblem spawned -> a = 3
input shrinked -> b = 2
outside computation -> d = 1 (addition, comparison, combine, split etc)

b^d = 2^1 = 2
a = 3

so here a > b^3
which means leaves win?

|#