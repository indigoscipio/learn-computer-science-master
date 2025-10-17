#lang racket

; Returns the fewest number of coins to give a customer so that the
; sum of their value equals to the correct amount of change
; Number List-of-numbers -> List-of-numbers
(define (change amount coins)
  ; check if the largest coins fit
  ; if it fits, remove it from the list and continue with the next one
  ; 15 -> 100, 25, 10 - fits, push 10 into the result and subtract 15 - 10 -> 5
  ; then start again from the highest coins value, repeat.

  ; List-of-numbers List-of-numbers -> Maybe List-of-numbers
  ; acc holds the current solution so far
  (define (iter l curr-amount acc)
    (cond [(null? l) acc]
          [(zero? curr-amount) acc]
          [(negative? (- curr-amount (car l))) (iter (cdr l) curr-amount acc) ] ; coin dosn't fit, move on to the next one
          [else (iter l (- curr-amount (car l)) (if XXX if not XXX) ] ; coin fits, subtract curr amount with car l and recurse 
          
          )
    )
  (iter (reverse coins) amount '())
  )

(change 6 '(1 3 4))
(change 15 '(1 5 10 25 100)); should return '(5, 10)
(change 40 '(1 5 10 25 100)) ;should return '(5, 10, 25)
(change 25 '(1 5 10 25 100)) ; '(25)
(change 23 '(1 4 15 20 50)) ;(4 4 15)
(change 63 '(1 5 10 21 25)) ;(21 21 21)

#|
(change 999 '(1 2 5 10 20 50 100)) ;(2 2 5 20 20 50 100 100 100 100 100 100 100 100 100)
(change 21 '(2 5 10 20 50)) ;'(2 2 2 5 10)
(change 27 '(4 5)) ;(4 4 4 5 5 5)
(change 0 '(1 5 10 21 25)) ;'()
(change 3 '(5 10)) ;error
(change 94 '( 5 10)) ;error no comb can add up to target
(change -5 '(1 2 5)) ;error negative



(- 15 100)
(- 15 25)
(- 15 10)
(- 15 5)
|#
