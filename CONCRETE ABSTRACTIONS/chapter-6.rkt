#lang racket

#|
 Exercise 6.1
A fourth version of Nim uses two piles of coins but adds the restriction that a
player can remove at most three coins in any one turn. To implement this ver
sion, we could use the three operations, make-game-state, size-of-pile, and
remove-coins-from-pile, as before. In this case, whenever we use remove
coins-from-pile, the parameter indicating how many coins to remove should
have a value of 1, 2, or 3.
Alternatively, we could replace remove-coins-from-pile with the three oper
ations, remove-one, remove-two,andremove-three, where each of these opera
tions would have just two parameters: the current game state and the pile to remove
from. With this implementation, we would have five operations instead of three.
Compare these two approaches to implementing this new version of Nim. What are
the advantages and disadvantages of each one? Is one implementation better than
the other?

answer:
using first method (pass num to rmeove as param)
pros
+ its composable/reusable, if we wanna tailor it to remove 10 or n card we can do it
+ this is a more abstracted version of the remove one, remove two, rmeove three etc, no need to create extra procedure

cons
- we'd need to make sure the param is from a correct range eg 1-3 so extra additional check


using second method (3 additional proc)
pros
+ its more "secure" and feels "guaranteed", if we remove one then it removes one

cons
- if we wanna make like rmeove 10 or remove 100 or remove arbitrary number we'd have to make that function
- way too much function additions, if we wanna make remove 5 we'd have to create another function up to 5

|#

; ----------------------------------------------

;returns an integer equal to the number of coins in the p-th
;pile of the game-state
;(size-of-pile game-state p)

;given a Nim game-state, returns a new game state with n
;fewer coins in pile p
;(remove-coins-from-pile game-state n p)

;returns a game state with n coins in the first pile
;and m coins in the second pile
;(make-game-state n m)

#|
Exercise 6.2
When you played Nim with another person and a gamekeeper, what did the game
keeper do if you asked her to remove more coins from a pile than she could possibly
remove? (For example, what if you asked her to remove six coins from a pile with
only five coins in it?) If we want our computer version to work in a similar way, we
need to build in some sort of error checking on the part of the input procedures.
What would you modify in order to continue asking the user for another number
if the number selected was illegal (both for coins and pile)? Is it better to do the
error checking in human-move or prompt? Could you use a procedural parameter
to good effect?

answer
is the player wants to remove coin > current pile then its illegal,
put the logic in human move instead of the prompt
I think the prompt purpose is only to show what the user input

(define (get-valid-input prompt-string valid?)
  (let ((val (prompt prompt-string)))
    (if (valid? val)
        val
        (begin (display "Invalid input, try again.")
               (get-valid-input prompt-string valid?)))))
|#

#|
cise 6.3
The version of Nim we have just written designates the winner as the one taking the
last coin. What needs to be changed in order to reverse this, that is, to designate the
one taking the last coin as the loser?

answer:
modify the announce winner just flip and winner and loser simple

|#

; =======================================================================================


#|
Exercise 6.4
The restriction that we can only use at most nine coins in each pile is somewhat
unreasonable. A more reasonable one would be to limit the size of the piles to at
most 99 coins. Change the implementation above so that it reflects this restriction.

|#

#|
Exercise 6.5

What happens if we try to remove more coins from a pile than are actually in the
pile? For example, what would be the result of evaluating
(remove-coins-from-pile (make-game-state 3 2) 5 1)
Modify remove-coins-from-pile so that such a request would result in just re
moving all of the coins from the specified pile.


(define make-game-state
  ;; assumes no more than 9 coins per pile
  (lambda (n m) (+ (* 10 n) m))
  )

(define size-of-pile
  (lambda (game-state pile-number)
    (if (= pile-number 1)
        (quotient game-state 10)
        (remainder game-state 10))))

(define remove-coins-from-pile
  (lambda (game-state num-coins pile-number)
    ; if num coins > the pile
    (let ((amount-to-take (min num-coins (size-of-pile game-state pile-number))))
      (if (= pile-number 1)
          (make-game-state (- (size-of-pile game-state 1)
                              amount-to-take)
                           (size-of-pile game-state 2))
          (make-game-state (size-of-pile game-state 1)
                           (- (size-of-pile game-state 2)
                              amount-to-take)))
      )    
    )
)
|#




#|
Exercise 6.6
What are some other ways of coping with errors?

use error
use min/max to clip a range
|#


#|
Exercise 6.7
Look back at the procedures for calculating the exponent of 2 in a number that you
wrote in Exercise 2.12 on page 40 and Exercise 3.2 on page 54. Generalize one of
these to a procedure exponent-of-in such that (exponent-of-in n m) returns
the exponent of the highest power of n that divides evenly into m.

|#

;; asume p is nonegative
(define (expt b p)
  (cond [(zero? p) 1]
        [else (* b (expt b (- p 1)))])
  )

(define (find-expo n)
  (define (iter counter result)
    (cond [(odd? counter) result]
          [else (iter (/ counter 2) (+ 1 result)) ])
    )
  (iter n 0)
  )

; number number -> number
(define (exponent-of-in base total)
  (cond [(zero? (remainder total base)) (+ 1 (exponent-of-in base (quotient total base))) ] ;fully divisble, found 1 factor, increase count
        [else 0]
        )
  )


(define (make-game-state n m)
  (λ (x) (if (odd? x) n m))
  )

((make-game-state 10 20) 1)


#|
Write the equations for three-pile game states that correspond to those given earlier
for two-pile game states.


|#

#|
Exercise 66.11

Now that we have the main constructor and selector for the three-pile game state
ADT, we need to change the procedures remove-coins-from-pile, total-size,
and display-game-state appropriately. Do so.

|#


(define (remove-coins-from-pile game-state num-coins pile-number)
  (let ((amt-to-take (min num-coins (size-of-pile game-state pile-number))))
    (cond [(= pile-number 1) (make-game-state (- (car game-state) amt-to-take) (cadr game-state) (cddr game-state) )]
          [(= pile-number 2) (make-game-state (car game-state) (- (cadr game-state) amt-to-take) (cddr game-state) )]
          [else (make-game-state (car game-state) (cadr game-state) (- (cddr game-state) amt-to-take))] 
          )
    )
  )


(define (display-game-state game-state)
  (newline)
  (newline)
  (display" Pile 1:")
  (display(size-of-pilegame-state 1))
  (newline)
  (display" Pile 2:")
  (display(size-of-pilegame-state 2))
  (newline)
  (display" Pile 3:")
  (display(size-of-pilegame-state 3))
  (newline)
  (newline))

(define total-size
  (lambda(game-state)
    (+(size-of-pile game-state 1)
      (size-of-pile game-state 2)
      (size-of-pile game-state 3)
      )))


#|
What will go wrong if we use the existing computer-move with three-pile game
states? Change computer-move so that it works correctly with three-pile game states.

answer:
(let ((pile (if (> (size-of-pile game-state 1) 0)
1
2)))

here we only have conditional to check if 1st pile is not empty if so move the 2nd one we don't have the logic for the 3rd one


|#

(define (computer-move game-state)
  ; computer only move if its ifnds a nonempty pile
  (let ((pile (cond [(> (size-of-pile game-state 1) 0) 1]
                    [(> (size-of-pile game-state 2) 0) 2]
                    [else 3]
                    )
              ))
    (display "I take 1 coin from pile ")
    (display pile)
    (newline)
    (remove-coins-from-pile game-state 1 pile)))