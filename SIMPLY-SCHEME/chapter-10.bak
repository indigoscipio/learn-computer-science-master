#lang simply-scheme

; ace = 4
; king = 3
; queen = 2
; jack = 1
; 2 - 10 = 0

; distribution scoring
; looking at each 4 suits
; 0 card in suit = void = 3 pts
; 1 card in suit = singleton = 2 pts
; 2 cards in suit = doubleton = 1 pt
; 3+ cards = normal = 0 pts

; a Card is a 2 letter word
; where the first ltter is the suit
; and the last one is the rank
; hq - h = hearts, q = queen

; Write a procedure card–val that takes a single card as its argument and returns the value of that card.
; card-val:: Word -> Number
(define (card-val card)
  (let ((suit (first card))
        (rank (bf card))
        )
    (cond [(equal? rank 'a) 4]
          [(equal? rank 'k) 3]
          [(equal? rank 'q) 2]
          [(equal? rank 'j) 1]
          [else 0]
          )
    )
  )
;(card-val 'cq)
;(card-val 's7)
;(card-val 'ha)

; Write a procedure high–card–points that takes a hand as its argument and returns the total number of points 
; from high cards in the hand. (This procedure does not count distribution points.)
; high-card-points:: Sentence -> Number
(define (high-card-points cards)
  (accumulate + (every card-val cards))
  )
;(high-card-points '(sa s10 hq ck c4))
;(high-card-points '(sa s10 s7 s6 s2 hq hj h9 ck c4 dk d9 d3))

;Write a procedure count–suit that takes a suit and a hand as arguments and returns the
;number of cards in the hand with the given suit.
; count-suit:: word sentence -> number
(define (count-suit suit cards)
  (count (keep (λ (c) (equal? (first c) suit) ) cards))
  )
;(count-suit 's '(sa s10 hq ck c4))
;(count-suit 'c '(sa s10 s7 s6 s2 hq hj h9 ck c4 dk d9 d3))
;(count-suit 'd '(h3 d7 sk s3 c10 dq d8 s9 s4 d10 c7 d4 s2))

;Write a procedure suit–counts that takes a hand as its argument and returns a sentence containing the number of 
;spades, the number of hearts, the number of clubs, and the number of diamonds in the hand.
(define (suit-counts cards)
  (let ((spades (count-suit 's cards))
        (hearts (count-suit 'h cards))
        (clubs (count-suit 'c cards))
        (diamonds (count-suit 'd cards))
        )
    (se spades hearts clubs diamonds)
    )
  )
;(suit-counts '(sa s10 hq ck c4))
;(suit-counts '(sa s10 s7 s6 s2 hq hj h9 ck c4 dk d9 d3))
;(suit-counts '(h3 d7 sk s3 c10 dq d8 s9 s4 d10 c7 d4 s2))



;Write suit–dist–points that takes a number as its argument, interpreting it as the
;number of cards in a suit. The procedure should return the number of distribution points your hand gets for having that 
;number of cards in a particular suit.

; suit-dist-points:: number -> number
(define (suit-dist-points p)
  (cond [(= p 0) 3]
        [(= p 1) 2]
        [(= p 2) 1]
        [else 0]
        )  
  )



;Write hand–dist–points, which takes a hand as its argument and returns the number of distribution points the 
;hand is worth.
; hand-dist-points:: sentence -> number
(define (hand-dist-points cards)
  (accumulate + (every suit-dist-points (suit-counts cards)))
  )
(hand-dist-points '(sa s10 s7 s6 s2 hq hj h9 ck c4 dk d9 d3))
(hand-dist-points '(h3 d7 sk s3 c10 dq d8 s9 s4 d10 c7 d4 s2))



;Write a procedure bridge–val that takes a hand as its argument and returns the
; total number of points that the hand is worth.
(define (bridge-val cards)
 (+ (hand-dist-points cards) (high-card-points cards) )
  )
(bridge-val '(sa s10 s7 s6 s2 hq hj h9 ck c4 dk d9 d3))
(bridge-val '(h3 d7 sk s3 c10 dq d8 s9 s4 d10 c7 d4 s2))