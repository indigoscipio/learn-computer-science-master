#lang racket

;A Pair is a Number
; make-pair N N -> Number
(define (make-pair x y)
  (* (expt 2 x) (expt 3 y) )
  )
(define pair1 (make-pair 2 3))

;Number -> Number
; counts how many times a number n can be divided by 2 before its no longer divisible
(define (div-by-2 n acc)
  (cond [(zero? (modulo n 2)) (div-by-2 (/ n 2) (+ 1 acc))]
        [else acc])
  )

;Number -> Number
; counts how many times a number n can be divided by 3 before its no longer divisible
(define (div-by-3 n acc)
  (cond [(zero? (modulo n 3)) (div-by-3 (/ n 3) (+ 1 acc))]
        [else acc])
  )

;Pair -> Number
; how many times is n divisible by 2? gives back a
(define (car p)
  (div-by-2 p 0)
  )
(car pair1)

;Pair -> Number
; how many times is n divisible by 3? gives back b
(define (cdr p)
  (div-by-3 p 0)
  )
(cdr pair1)