#lang racket

#|
847 A multiplication game
Stan and Ollie play the game of multiplication by multiplying an integer p by one of the numbers 2 to
9. Stan always starts with p = 1, does his multiplication, then Ollie multiplies the number, then Stan
and so on. Before a game starts, they draw an integer 1 < n < 4294967295 and the winner is who first
reaches p ≥ n.
Input and Output
Each line of input contains one integer number n. For each line of input output one line either
Stan wins.
or
Ollie wins.
assuming that both of them play perfectly.
Sample input
162
17
34012226
Sample Output
Stan wins.
Ollie wins.
Stan wins
|#

(define TARGET_NUM (random 1 4294967087))

; player wins if it picks n  p x 9 >=n
; store the winner in result.
; when is-winning? is true, return whoever curr player is the winner
(define (play p)
  (define (play-h curr-p curr-player)
    (cond [ curr-player] ;stan's turn
          [] ;ollie's turn
          )
    )
  (play-h p 'stan #f)
  )
(play 1) ;starts with stan first