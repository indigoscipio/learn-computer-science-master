#lang simply-scheme
;; ttt.scm
;;; Tic-Tac-Toe program

(define (ttt position me)
  (ttt-choose (find-triples position) me))

(define (find-triples position)
  (every (lambda (comb) (substitute-triple comb position))
         '(123 456 789 147 258 369 159 357)))

(define (substitute-triple combination position)
  (accumulate word
	      (every (lambda (square)
		       (substitute-letter square position))
		     combination) ))

(define (substitute-letter square position)
  (if (equal? '_ (item square position))
      square
      (item square position) ))

(define (ttt-choose triples me)
  (cond ((i-can-win? triples me))
        ((opponent-can-win? triples me))
        ((i-can-fork? triples me))
        ((i-can-advance? triples me))
        (else (best-free-square triples)) ))

(define (i-can-win? triples me)
  (choose-win
   (keep (lambda (triple) (my-pair? triple me))
         triples)))

(define (my-pair? triple me)
  (and (= (appearances me triple) 2)
       (= (appearances (opponent me) triple) 0)))

(define (opponent letter)
  (if (equal? letter 'x) 'o 'x))

(define (choose-win winning-triples)
  (if (empty? winning-triples)
      #f
      (keep number? (first winning-triples)) ))

(define (opponent-can-win? triples me)
  (i-can-win? triples (opponent me)) )

(define (i-can-fork? triples me)
  (first-if-any (pivots triples me)) )

(define (first-if-any sent)
  (if (empty? sent)
      #f
      (first sent) ))

(define (pivots triples me)
  (repeated-numbers (keep (lambda (triple) (my-single? triple me))
                          triples)))

(define (my-single? triple me)
  (and (= (appearances me triple) 1)
       (= (appearances (opponent me) triple) 0)))

(define (repeated-numbers sent)
  (every first
         (keep (lambda (wd) (>= (count wd) 2))
               (sort-digits (accumulate word sent)) )))

(define (sort-digits number-word)
  (every (lambda (digit) (extract-digit digit number-word))
         '(1 2 3 4 5 6 7 8 9) ))

(define (extract-digit desired-digit wd)
  (keep (lambda (wd-digit) (equal? wd-digit desired-digit)) wd))

(define (i-can-advance? triples me)
  (best-move (keep (lambda (triple) (my-single? triple me)) triples)
             triples
             me))

(define (best-move my-triples all-triples me)
  (if (empty? my-triples)
      #f
      (best-square (first my-triples) all-triples me) ))

(define (best-square my-triple triples me)
  (best-square-helper (pivots triples (opponent me))
		      (keep number? my-triple)))

(define (best-square-helper opponent-pivots pair)
  (if (member? (first pair) opponent-pivots)
      (first pair)
      (last pair)))

(define (best-free-square triples)
  (first-choice (accumulate word triples)
                '(5 1 3 7 9 2 4 6 8)))

(define (first-choice possibilities preferences)
  (first (keep (lambda (square) (member? square possibilities))
               preferences)))


;10.1 The ttt procedure assumes that nobody has won the game yet. What happens if you invoke ttt with a board 
; position in which some player has already won? Try to figure it out by looking through the program before you run it.

;A complete tic-tac-toe program would need to stop when one of the two players wins. Write a predicate already
;won? that takes a board position and a letter (x or o) as its arguments and returns #t if that player has already won.

(ttt '______xxx 'x)
; returns 1
#|
it seems that it returns the next position which is incorrect it should be game over
so lets define gmae over
|#

(define (already-won? position me);
  ; winning means there are 3 x/o in winning triples
  (not (empty? (keep (λ (t) (= (appearances me t) 3) ) (find-triples position))))
  )
(already-won? '______xxx 'x) ;#t
(already-won? '_________ 'x) ;#f


#|
=======================================================
10.2
 The program also doesn't notice when the game has ended in a tie, that is, when all nine squares are already filled. 
What happens now if you ask it to move in this situation?
Write a procedure tie–game? that returns #t in this case.


(define (tie-game? position)
  ; if there's a triple in triples that contain a number, then the game is still going
  (empty? (keep (λ (char) (and (not (equal? char 'x))
                               (not (equal? char 'o))
                               )  ) position))
  )
(tie-game? 'xoxoxooxo) ; should return true
(tie-game? 'xoxo_o_xo) ; should return false
=======================================================
|#



#|
=======================================================
10.3 A real human playing tic-tac-toe would look at a board like this:
oox
xxo 
ox_

and notice that it's a tie, rather than moving in square 9. Modify tie–game? from Exercise 10.2 to notice this 
situation and return #t.

(Can you improve the program's ability to recognize ties even further? What about boards with two free squares?)
|#

;helper function
; is-dead-triple:: word -> boolean
(define (is-dead-triple? triple)
  (and  (> (appearances 'x triple) 0)
        (> (appearances 'o triple) 0))
  )

(define (is-live-triple? triple)
  (not (is-dead-triple? triple))
  )

(define (tie-game? position)
  ; if there's a triple in triples that contain a number, then the game is still going
   (empty? (keep is-live-triple? (find-triples position)))
  )
(tie-game? 'xoxoxooxo) ; should return true
(tie-game? 'xoxo_o_xo) ; should return false

; =======================================================

#|

10.4 Here are some possible changes to the rules of tic-tac-toe:
• What if you could win a game by having three squares forming an L shape in a corner, such as squares 1, 2, and 4?
• What if the diagonals didn't win?
• What if you could win by having four squares in a corner, such as 1, 2, 4, and 5?
Answer the following questions for each of these modifications separately: What would happen if we tried to 
implement the change merely by changing the quoted sentence of potential winning combinations in find
triples? Would the program successfully follow the rules as modified?

answer:
yes, for #1 we can just change the winning combinations to
'(124 236 478 689)
for #2 we can remove the diagonals so there's only 6 winning combinations, the rows and columbs
and for #3 we can just change the winning the combinations to the same

but wait the logic is different forthese since normal tic tac toe
the best move and can i win is designed to win in tic tac toe?

#1 the pivot neesd to change
#1 it has no diagonals

|#
