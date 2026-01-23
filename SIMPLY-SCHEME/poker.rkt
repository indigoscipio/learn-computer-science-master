#lang simply-scheme

#|
THE RULE
* Royal flush: ten, jack, queen, king, and ace, all of the same suit
• Straight flush: five cards of sequential rank, all of the same suit
• Four of a kind: four cards of the same rank
• Full house: three cards of the same rank, and two of a second rank
• Flush: five cards of the same suit, not sequential rank
• Straight: five cards of sequential rank, not all of the same suit
• Three of a kind: three cards of the same rank, no other matches
• Two pair: two pairs of cards, of two different ranks
• Pair: two cards of the same rank, no other matches
• Nothing: none of the above
|#

; a card is a word
; example: s4, h4, c6
; (word suit rank) where suit is one of the following: '(d,h,c,s)
; and rank is a the following: '(a,2,3,4,5,6,7,8,9,10,j,q,k)
 
; a hand is a sentence - a list of cards
; example: '(s4, h4, c6)

; rank:: extracts the rank of a current card
(define (rank card)
  (bf card)
  )

; suit:: extracts the suit of a given card
(define (suit card)
  (first card)
  )


(define (poker-value hand)
  0
  )
(poker-value '(h4 s4 c6 s6 c4))