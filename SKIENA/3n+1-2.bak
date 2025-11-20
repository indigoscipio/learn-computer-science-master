#lang racket


#|
input n
print n
 if n = 1 then STOP
  if n is odd then n ←− 3n + 1
  else n ←− n/2
GOTO

given input 22, the following will be printed:
22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1
|#


;For any two numbers i and j you are to determine the maximum cycle length over all numbers
;between and including both i and j.

; INPUT
; a series of pairs of integers (i j), one pair of integer per line.
; all integers will be less ghan 10,000 and less than 0

; OUPTUT
; i,j and the number of maximum cycle length for integers between and including i and j.
; seperated by one space with all numbers in one line of output  for each line of input

;sample input:
; 1 10 -> 1 10 20
; 100 200 -> 100 200 125
; 201 210 -> 201 210 89
; 900 1000 -> 900 1000 174

; Number Number -> List-of-(Number Number Number)
; given integers i and j, find the largest cycle length among i..j
(define (3np1 i j)

  ; Given a number, compute its collatz cycle length.
  ; Number Number -> Number
  (define (cycle-length n steps)
    (cond [(= n 1) steps]
          [(even? n) (cycle-length (/ n 2) (+ 1 steps))]
          [else (cycle-length (+ (* 3 n) 1) (+ 1 steps) ) ]
          )
    )

  ; given a list of numbers and the max so far, find largest cycle length among the list
  ;  List-of-Number Number -> Number
  (define (cycle-length-acc lon curr-max)
    (cond [(null? lon) curr-max] ;nothing else to compute, return max step
          [else (let ((curr-step (cycle-length (car lon) 1) ))
                  (if (> curr-step curr-max)
                      (cycle-length-acc (cdr lon) curr-step)
                      (cycle-length-acc (cdr lon) curr-max)
                      )
                  ) ]
          )
    )

  (define start (min i j))
  (define end (max i j))
  (list i j (cycle-length-acc (range start (+ end 1)) 0))

  )
(3np1 1 1)
(3np1 2 1)
(3np1 1 10)
(3np1 100 200)
(3np1 201 210)
(3np1 900 1000)