#lang racket

; exercise 2.6
; a. Describe precisely what the following procedure computes in terms of n:
(define subtract-the-first
  (lambda (n)
    (if (= n 0)
        0
        (- (subtract-the-first (- n 1))
           n))))
(subtract-the-first 4)

; the procedures is like the opposite of sum-of first
; whereas sum of first sums number up to n, it subtracts it instead

; ====================================

; b. Consider what happens when you exchange the order of multiplication in factorial:

(define factorial2
  (lambda (n)
    (if (= n 0)
        1
        (* n
           (factorial2 (- n 1))))))

;Experimentation with various values of n should persuade you that this version
;computes the same value as did the original factorial. Why is this so? Would
;the same be true if you switched the order of addition in sum-of-first?

; here the recursion happens on the right sire (* n (factorial2 ...))
; the base case isevaluated first (* 3 (*2 (* 1 1)))
; the order doesn't matter for multiplication or addition
; because of commutative rule, but for negative it matters

; ====================================

;c. If you reverse the order of subtraction in subtract-the-first, you will get a
;different value in general. Why is this so? How would you precisely describe the
;value returned by this new version?

; because order of subtraction matter in mathematics;
; (3 - 2) is different than (2 - 3)

#|
in the orgiianl version
f(n) = f(n-1) - n
f(1) = 0 - 1 = -1
f(2) = f(1) - 2 = -3
f(3) = f(2) - 3 = -6

in the reversed version
f(n) = n - f(n-1)
f(1) = 1 - 0 = 1
f(2) = 2 - f(1) = 1
etc
|#