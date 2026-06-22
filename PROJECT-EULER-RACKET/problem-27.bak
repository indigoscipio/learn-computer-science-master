#lang racket

#|
PROBLEM 26
RECIPROCAL CYCLES

a unit fraction contains 1 in the numerator
the decimal representation of the unit fractions with denominators 2 to 10 are given:

1/2 = 0.5
1/3 = 0.5
1/4 = 0.5
1/5 = 0.5
1/6 = 0.5
1/7 = 0.5
1/8 = 0.5
1/9 = 0.5
1/10 = 0.5

where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle.
it can be seen that 1/7 has a 6 digit recurring cycle

find the value of d < 1000 for which 1/d contains the longest recurring cycle
in its decimal fraction part.

answer:

ok so let me understand the question
we wanna find value of 1/d that contains the longest recurring cycle procided d < 1000
in the example above 1/7 is the longest when d < 11 which has (142857) repeating cycle
let me formulate a simple approach

- for each number 1/d, check if that number contains a repeating cycle
- if so, check how long that repeating cycle is
- store that cycle and if theres anohter number with longer cycle, replace the current best

i dont know if this is a best plan maybe theres some kind of mathematical secret but ill try it first
|#

; given a number n, returns its cycle length in 1/n
; number -> number
(define (cycle-length n)
  (define (helper r seen-remainders result)
    (cond [(zero? r) 0]
          [(member r seen-remainders) result] ; base case
          [else (let ((new-remainder (remainder (* 10 r) n)))
                  (helper new-remainder (cons r seen-remainders) (+ 1 result))
                  ) ]
          )
    )
  (helper 1 '() 0)
  )
(cycle-length 2) ; 0
(cycle-length 7) ; 6

; given a number up to d, finds longest recurring cycle in its decimal fraction part
; number -> number
(define (reciprocal-cycles d)
  (define (loop n longest-n-so-far longest-cycle-len-so-far)
      (cond [(> n d) longest-n-so-far]
            [else (let ((curr-cycle-length (cycle-length n)))
                    (if (> curr-cycle-length longest-cycle-len-so-far)
                        (loop (+ n 1) n curr-cycle-length )
                        (loop (+ n 1) longest-n-so-far longest-cycle-len-so-far )
                        )
                    )])
      )
    (loop 1 1 1)
  )
(reciprocal-cycles 11) ; 1/1 - 1/10 -> shold return 7
(reciprocal-cycles 1000) ; returns 983
