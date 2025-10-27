#lang racket

(define p1 (cons 0 1))
(define p2 (cons 5 5))
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


; finds the city in points that is closest to p, excluding p itself
; Point List-of-points -> Point
(define (nearest p lop)
  ; List-of-points Number Point -> Point
  (define (loop points closest-dist closest-p)
    ; base case 1: points has 0 points -> return empty list
    ; base case 2: points has 1 point -> return that 1 point
    ; recursive case: compare dist between p and car points. if its < closest, replace closest else go on to the next one
    (cond [(null? points) closest-p]
          [else (let ((curr-dist (calc-dist (car points) p)))
                  (if (< curr-dist closest-dist)
                      (loop (cdr points) curr-dist (car points) )
                      (loop (cdr points) closest-dist closest-p)
                      )
                  )]
          )
    )
  (if (null? lop)
      '()
      ; initialize closest point to p and closest dist to 0
      (loop lop (calc-dist p (car lop)) (car lop) )
      )
  
  )
;(nearest p1 (list p2 p3))
;(nearest p1 '())
;(nearest p1 (list p2))

; Given a point and list of points,
; outputs the same list but without p. if not found return the list as it is
; Point List-of-points -> List-of-points
(define (remove p lop)
  (cond [(null? lop) '()]
        [(equal? p (car lop)) (cdr lop)]
        [else (cons (car lop) (remove p (cdr lop)))])
  )
;(remove p2 (list p1 p2 p3))

; implementation of TSP with nearest neighbour
; from skiena 1.1
; List-of-Points -> List-of-points
; given a list of cities (points), produce a list of cities in visiting order
(define (tsp-nn lop)
  ; find nearest unvisited city
  ; move there and mark as visited
  ; continue until all cities are visited
  
  ; base case: unvisited is empty, return the whole path
  ; recursive case: remove nearest p from unvisited, add curr p to visited
  (define (travel curr-p unvisited visited)
    (cond [(null? unvisited) (reverse (cons curr-p visited)) ]
          [else (let ((nearest-p (nearest curr-p unvisited)))
                  (travel nearest-p (remove nearest-p unvisited) (cons curr-p visited))
                  )]
          )
    )
  (travel (car lop) (cdr lop) '())
  
  )
;(tsp-nn (list p1 p2 p3))