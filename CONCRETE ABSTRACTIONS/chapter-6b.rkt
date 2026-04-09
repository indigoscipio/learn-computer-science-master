#lang racket


#|
6.25
We previously said that each move in Nim “transforms the game into a smaller
game, if we measure the size of the game in terms of the total number of coins.”
This raises the possibility that we could define a predicate game-state-< that would
compare two game states and determine whether the first is smaller (in the sense of
having a smaller total number of coins). Similarly, we could define game-state->,
game-state-=, game-state-<=, etc. Define a general purpose procedure called
make-game-state-comparator for making procedures like those just described,
given the numerical comparison procedure (e.g., <) to use. Here are some examples
of its use, together with examples using the comparators it makes:

(define game-state-< (make-game-state-comparator <))
(game-state-< (make-game-state 3 7) (make-game-state 1 12))
#t
(define game-state-> (make-game-state-comparator >))
(game-state-> (make-game-state 3 7) (make-game-state 1 12))
#f
(game-state-> (make-game-state 13 7) (make-game-state 1 12))
#t

|#

(define (make-game-state a b)
  (cons a b)
  )

(define (total-coins game-state)
(+ (car game-state) (cdr game-state))
  )

; something like this
(define (make-game-state-comparator op)
  (λ (gs1 gs2) (op (total-coins gs1) (total-coins gs2)) )
  )

(define game-state-< (make-game-state-comparator <))
(define game-state-> (make-game-state-comparator >))


(game-state-< (make-game-state 3 7) (make-game-state 1 12))
(game-state-> (make-game-state 3 7) (make-game-state 1 12))
(game-state-> (make-game-state 13 7) (make-game-state 1 12))

; ====================================================================================

#|
Exercise 6.26
Recall that when you worked with fractals in section 4.3
many of the procedures required parameters that represented the x and y coordinates of points in an im

|#