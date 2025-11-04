#lang racket

; given base a and exponent n, compute a^n
; using fast exp method
; Number Number -> Number
(define (fast-exp a n)
  (cond [(= n 0) 1]
        [(even? n) (sqr (fast-exp a (quotient n 2))) ] ; even case
        [else (* a (sqr (fast-exp a (quotient (- n 1) 2) ))) ] ;odd case
        )
  
  )
(fast-exp 2 2) ;return 4
(fast-exp 2 0) ; return 1
(fast-exp 1 3) ; return 1
(fast-exp 2 3) ;return 8


; version 2
(define (fast-exp2 a n)
  (cond [(< n 0) (fast-exp2 (quotient 1 a) (- n) )]
        [(= n 0) 1 ]
        [(even? n) (fast-exp2 (sqr a) (quotient n 2) )]
        [else (* a (fast-exp2 (sqr a) (quotient (- n 1) 2) ))]
        )
  )
(fast-exp2 2 2) ;return 4
(fast-exp2 2 0) ; return 1
(fast-exp2 1 3) ; return 1
(fast-exp2 2 3) ;return 8