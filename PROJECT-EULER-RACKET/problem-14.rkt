#lang racket

#|
Longest Collatz Sequence

The following iterative sequence is defined for the set of positive integers:

RULE:
n -> n/2 (n is even)
n -> 3n + 1 (n is odd)

Using the rule above and starting with , we generate the following sequence:

13 -> 40 -> 20 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1

It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms.
Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.

which stargin number, under one million, produces the longest chain?

NOTE: Once the chain starts the terms are allowed to go above one million.

answer:
ok so we wanna basically find longest chain for n under 1,000,000
let me formulate a plan, keep it simple

a quick small example first
n=1 (base case)

n=2 (even)
2 -> 1
length = 2 terms

n=3 (odd)
3 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1
length = 8 terms

rough outline
. initialize variable longest-so-far which saves longest collatz sequence
. then on each iteration gather that terms sequence, and save it to var
. compare to longest-so-far one and check if the length exceeds, if so replace it
. do this until we go to one million

|#

; given a posint number > 1, returns its collatz sequence
; number -> list-of-number
(define (collatz-seq n)
  (cond [(<= n 1) (cons 1 '())] ;chain ends
        [(even? n) (cons n (collatz-seq (quotient n 2))) ] ;even case
        [else (cons n (collatz-seq (+ (* 3 n) 1))) ]) ; odd case
  )
(collatz-seq 1) ;should return '(1)
(collatz-seq 2) ; '(2 1)
(collatz-seq 3) ; '(3 10 5 16 8 4 2 1)
(collatz-seq 13) ; '(13 40 20 10 5 16 8 4 2 1)

; number -> number
; finds collatz longest chain below x
(define (longest-collatz-chain-below x)
  (define (loop longest-seq best-n curr-n)
    (let ((curr-seq (collatz-seq curr-n)))
      (cond [(>= curr-n x) best-n] ; length reaches x, return final result
            [(> (length curr-seq) (length longest-seq)) (loop curr-seq curr-n (+ 1 curr-n))] ; found new long, update
            [else (loop longest-seq best-n (+ 1 curr-n) )] ;keep searching
            )
      )
    )
  (loop (collatz-seq 2) 2 2)
  )
(longest-collatz-chain-below 10) ;9
(longest-collatz-chain-below 100) ;97
(longest-collatz-chain-below 150) ;129
(longest-collatz-chain-below 1000) ;871
(longest-collatz-chain-below 1000000) ;837799