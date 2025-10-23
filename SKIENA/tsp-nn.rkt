#lang racket

(define p1 (cons 0 1))
(define p2 (cons 2 5))
(define p3 (cons 1 0))

; given point 1 and point 2, calculates its distance
; using pythagoren theorem
(define (calc-dist p1 p2)
  (let ((x1 (car p1))
        (y1 (cdr p1))
        (x2 (car p2))
        (y2 (cdr p2))
        )
    (sqrt (+ (sqr (- x2 x1) ) (sqr (- y2 y1))) )
    )
  )
;(calc-dist p1 p2)

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
  (define (loop points closest-dist closest-p)
    ; base case 1: points has 0 points -> return empty list
    ; base case 2: points has 1 point -> return that 1 point
    ; recursive case: compare dist between p and car points. if its < closest, replace closest else go on to the next one
    (cond [(null? points) '()]
          [(null? (cdr points)) (car points)]
          [else (let ((curr-dist (calc-dist (car points) p)))
                  (if (< curr-dist closest-dist)
                      closest-dist
                      (loop (cdr points) closest-dist closest-p)
                      )
                  )]
          )
    )
  ; initialize closest point to p and closest dist to 0
  (loop lop (calc-dist p (car lop)) (car lop) )
  )
(nearest p1 (list p2 p3))
;(nearest p1 '())
;(nearest p1 (list p2))