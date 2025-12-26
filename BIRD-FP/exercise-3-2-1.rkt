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
[(count xs) | x <- xs ; x < 0 ]
filter each number and check if its < 0
list the numbers that are negaitve
count those numbers and output as a result

|#