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

; CONSTANTS
(define WORD_DIGIT '(one two three four five six seven eight nine))

; assume number is valid 2 - 10 and wd is valid ajkq
(define (rank-value rank mode)
  (if (number? rank)
      rank
      (cond[(equal? rank 'j) 11]
           [(equal? rank 'q) 12]
           [(equal? rank 'k) 13]
           [else (cond [(equal? mode 'high) 14]
                       [(equal? mode 'low) 1]
                       [else (error "not a valid mode: only accept high or low")]
                       )] ;ace case
           )
      )

  )
(rank-value 'a 'low)

(define (...))
(rank-values '(j k k a a) 'low)
(rank-values '(a 2 3 4 5) 'low)

; rank:: extracts the rank of a current card
(define (rank card)
  (bf card)
  )

; suit:: extracts the suit of a given card
(define (suit card)
  (first card)
  )

; given a word x, checks if every item in a list is  identical to x
(define (is-identical? target xs)
  (empty? (keep (λ (x) (not (equal? x target))) xs))
  )
(is-identical? 's '(s s s s s)) ;true

(define (count-rank target xs)
  (item (count (keep (λ (x) (equal? x target) ) xs)) WORD_DIGIT)
  )
(count-rank 'q '(q 3 4 3 4)) ;should return 1

; given a list of item, returns a unique list
(define (make-unique-list xs)
  (cond [(empty? xs) '()]
        [(member? (car xs) (cdr xs)) (make-unique-list (cdr xs))]
        [else (cons (car xs) (make-unique-list (cdr xs)))]
        )
  )
(make-unique-list '(q 3 4 3 4)) ; should return q 3 4

(define (is-straight? hand)
  0
  )

; number -> boolean
(define (is-straight-helper? hand)
  (let ((sorted-hand (sort hand <)))
    (if (equal? (count (make-unique-list hand)) (count hand))
        (equal? (- (last sorted-hand) (first sorted-hand)) 4); does not contain duplicate, proceed with checking the first & last sequence
        #f ;contains duplicate
        )
    )
  )
(is-straight-helper? '(3 5 6 4 7))
(is-straight-helper? '(14 2 3 4 5))
(is-straight-helper? '(1 2 3 4 5))

; given a unique list of ranks,
; return a tally of '(<NUMBER> <RANK> <NUMBER> <RANK> ...)
(define (compute-ranks unique-ranks full-hand)
  (cond [(empty? unique-ranks) '()]
        [else (se (count-rank (first unique-ranks) full-hand) (first unique-ranks)
                  (compute-ranks (bf unique-ranks) full-hand) )]
        )
  )
;(compute-ranks '(q 3 4) '(q 3 4 3 4))

(define (poker-value hand)
  ; suit view
  ; rank view (sequences and groups)
  (let ((ranks (map rank hand) )
        (suits (map suit hand))
        )
    ranks
    )
  )
;(poker-value '(h4 s4 c6 s6 c4))