#lang racket

#|
PROBLEM 39
INTEGER RIGHT TRIANGLES

if p is the perimeter of a right angle triangle with integral
lenght sides, {a,b,c}, there are exactly three solutions for p = 120

{20,48,52},{24,45,51},{30,40,50}

for which value of p <= 1000, the number of solutions maximised?

answer:
ok so the question is about right triangles

for area if i remember its something like a^2 + b^2 = c^2
where c is the hypotenuse, a and b is the foot length
for perimeter im not really sure, basically lenght of all 3 sides


p = 120 -> 3 solutions
we wanna find most solutions for p <= 1000

approach
- helper that generates all possible triplet list for each number
- probably another helper for the perimeter thing
- main function that keeps track of highest number of solutions


|#

; pythagorean = a^2 + b^2 = c^2
; number number number -> boolean
(define (is-valid-right-triangle? a b c)
  0
  )


; void -> number
; p = fixed, a = known, b  and c = derived
#|
Derive c from p and a
Derive b from p, a, and c
Check is-valid-right-triangle?
Count solutions for a given p
Find the p with the most solutions
|#
(define (integer-right-triangles)
  0
  )