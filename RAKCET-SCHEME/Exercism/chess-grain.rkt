#lang racket


; how many grains were ona given square
; Number -> MaybeNumber
(define (square n)

  #|
  (define (iter init acc)
    (cond [(>= init n) acc]
          [else (iter (+ 1 init) (* 2 acc)) ])
    )
  |#
  
  (if (or (zero? n)
          (> n 64)
          (< n 0)
          )
      (error "N size must be nonnegative integer up to 64")
      (expt 2 (- n 1))
      )
  )
(square 1)
(square 1)
(square 32)

; Number Number -> Number
(define (sum-total-square n acc)
  (cond [(zero? n) acc]
        [else (sum-total-square (sub1 n) (+ (square n) acc))])
  )

; the total number of grains on the chessboard
; Number
(define total
  ;(foldr (lambda (x acc) (+ (square (add1 x)) acc) ) 0 (build-list 64 +))
  (sum-total-square 64 0)
  )
