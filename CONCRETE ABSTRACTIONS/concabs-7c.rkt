#lang racket

; REVIEW PROBLEMS
; Exercise 7.39
; Prove using induction on n that the following procedure produces a list of length n.
(define (sevens n)
  (if (= n 0)
      '()
      (cons 7
            (sevens (- n 1)))
      )
  )


#|
answer:

BASE CASE
n = 0 -> return '() which is a list of length 0
therefore the base case is true

INDUCTIVE HYPOTHESIS
assume that (sevens k) returns a list of length k.

INDUCTIVE STEP
we must show that (sevens k+1) returns a list of length k + 1

since k is >0 it goes into the else case

(cons 7 (sevens (- k 1))) ->
(cons 7 (sevens (- (+ k 1) 1))) ->
(cons 7 (sevens k))

since we assume (sevens k) returns a list of length k
(cons 7 (sevens k)) returns  a list of length k plus the operation cons add 1
so it returns a list of length k + 1

QED.

|#


; ==================================================================================

#|
Exercise 7.40


|#