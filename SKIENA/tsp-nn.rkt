#lang racket

(define p1 (cons 0 1))
(define p2 (cons 2 5))
(define p3 (cons 1 0))

; given point 1 and point 2, calculates its distance
; using pythagoren theorem
(define (calc-dist p1 p2)

  )

; a Point is a pair of number
; interpretation stores a position of x and y axis
; (cons 10 50)

; implementation of TSP with nearest neighbour
; from skiena 1.1
; List-of-Points -> List-of-points
; given a list of cities (points), produce a list of cities in visiting order
(define (tsp-nn points)
  0
  )
;(tsp-nn (list (cons 0 1) (cons 0 2)))

; finds the city in points that is closest to p, excluding p itself
; Point List-of-points -> Point
(define (nearest p lop)
  (define (loop points closest)
    ; base case 1: points has 0 points -> return empty list
    ; base case 2: points has 1 point -> return that 1 point
    ; recursive case:
    (cond [(null? points) '()]
          [(null? (cdr points)) (car points)]
          [else 0]
          )
    )
  (loop lop ...)
  )
(nearest p1 (list p2 p3))