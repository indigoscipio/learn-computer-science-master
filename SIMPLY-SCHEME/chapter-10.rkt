#lang simply-scheme

;a winning combination (triple) is a 3 letter number
;where the triple represents 3 horizontal rows. 3 vertical colums, and 2 diagonals
; '(123 456 789 147 258 369 159 357)
(define WINNING-COMBINATIONS '(123 456 789 147 258 369 159 357) )

; number -> number/letter
; finds the letter in a single square
(define (substitute-letter square position)
  (if (eq? '_ (item square position))
      square
      (item square position))
  )
(substitute-letter 5 '_xo_x_o__)

;finds all three letters corresponding to three squares
(define (substitute-triple combinations position)
  (accumulate word (every (λ (n) (substitute-letter n position) ) combinations))
  )
(substitute-triple 456 '_xo_x_o__) ; 4x6
(substitute-triple 147 '_xo_x_o__) ; 140
(substitute-triple 357 '_xo_x_o__) ; 0x0

; finds all the letters in all eight winning combinations.
(define (find-triples position)
  (every (λ (t) (substitute-triple t position)) WINNING-COMBINATIONS)
  )
(find-triples '_xo_x_o__)

(define (opponent letter)
  (if (eq? letter 'x)
      'o
      'x
      )
  )

(define (my-pair? triple me)
  (and (= (appearances me triple) 2)
       (= (appearances (opponent me) triple) 0)
       )
  )
(my-pair? 'oo7 'o) ; #t
(my-pair? 'xo7 'o) ; #f
(my-pair? 'oox 'o) ; #f


(define (choose-win winning-triples)
  (if (empty? winning-triples)
      #f
      (keep number? (first winning-triples))
      )
  )

(define (i–can–win? triples me)
  (choose-win (keep (λ (t) (my-pair? t me)) triples))
  )
(i–can–win? '(1xo 4x6 o89 14o xx8 o69 1x9 oxo) 'x)
(i–can–win? '(1xo 4x6 o89 14o xx8 o69 1x9 oxo) 'o)


(define (opponent-can-win? triples me)
  (i–can–win? triples (opponent me)))
(opponent-can-win? '(1xo 4x6 o89 14o xx8 o69 1x9 oxo) 'o)