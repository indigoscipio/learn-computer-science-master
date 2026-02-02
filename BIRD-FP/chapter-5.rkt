#lang racket

;RECURSION

; with pattern matching
(define (expo base pow)
  (match pow
    [0 1]
    [n (* base (expo base (- n 1)))]
    )
  )
(expo 2 3)


; ====================
(define (fib n)
  (match n
    [0 0]
    [1 1]
    [n (+ (fib (- n 1)) (fib (- n 2))) ]
    )
  )
(fib 25)


; ================================
#|
exercise
Using the recursive definitions ofaddition and multiplication of natural 
numbers given in Section 5.1, prove all or some of the following familiar 
properties of arithmetic:

0 + n = n = n + 0 (+ has identity 0)
answer:

the toolkit
a. 0 + n = n
b. (m+1) + n = (m+n) + 1

base case: n = 0
check if proprty holds when plugging 0
LHS -> 0 + 0 = 0
RHS -> 0 + 0 = 0

IH : assume k+0 = k

inductive step: we need to show k+1
substitute into toolkit n = k+1
show that (k+1) + 0
(k+1) + 0 = (k+0) + 1
(k + 1) + 0 = k + 1

RHS
0 + n = n
base case
0 + 0 = 0 in rule a  it's alos 0

hypothesis assume 0 + k = k
inductive step
n = k + 1
...


; =========================

1 * n = n = n * 1

the toolkit
a. 0 * n = 0
b. (m + 1) * n = (m * n) + n

base case = n = 0
LHS -> 0 * n = 0 -> 0 * 0 = 0
RHS -> n * 1 -> 0 * 1 = 0
therefore base case is true

inductive hypothesis
assume 1 * k = k and k * 1 = k is true

inductiev hypothesis
n = n * 1
show k + 1 = (k + 1) * 1
(k + 1) * 1 = (k * 1) + 1, substitue from IH
(k + 1) * 1 = k + 1

part 2, prove n = 1 * n
lhs = 1 * 0
rhs - also 0 by rule b

ih -> assume k = 1 * k
istep = show k + 1 = 1 * (k + 1)
with rule b
(0 + 1) * (k + 1)
(0 * (k + 1)) + (k + 1)



|#