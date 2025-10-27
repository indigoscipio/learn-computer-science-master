#lang racket

(define p1 (cons 0 1))
(define p2 (cons 5 5))
(define p3 (cons 1 0))
(define p4 (cons 2 2))
(define p5 (cons 50 50))

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

; ======================================================
; TSP CLOSEST PAIR IMPLEMENTATION
; SKIENA 1.1

; look at all cities, connect whichever the closest no matter where they are
; build multiple chain globally

; a Point is a pair of number
; interpretation stores a position of x and y axis
; (cons 10 50)

;(define p1 (cons 0 1))
;(define p2 (cons 5 5))
;(define p3 (cons 1 0))

; a Chain is a list of points
; (define c1 (list p1 p2 p3))

; List-of-chains -> List-of-points
; given a list of chains, return a list with each endpoint chain
(define (get-endpoints loc)
  (define (loop chains result)
    (cond [(null? chains) (reverse result)]
          [else (let* ((c (car chains))
                      (first-point (first c))
                      (last-point (last c)))
                  (loop (cdr chains) (cons (list first-point last-point) result))
                  )])
    )
  (loop loc '())
  )
(get-endpoints (list (list p1 p2 p4 p5) (list p1 p3)))

; given a list of distinct chain pairs (with 2 endpoints), compare their endpoints
; that are the closest between the chains
; List-of-chains -> ????
(define (find-closest-pair loc)
  0
  )
(find-closest-pair (list (list p1 p2) (list p3 p4)))

; a Connection is a list of Chain Chain Point Point
; interpretation...

;given two chains, finds the closest of their four endpoint pairs
; Chain Chain -> Connection
(define (closest-pair c1 c2)
  (define (loop pairs closest)
    (cond
      [(empty? pairs) closest]
      [else
       (let* ((current (first pairs))
             (dist-current (calc-dist (first current) (second current)))
             (dist-closest (calc-dist (first closest) (second closest)))
             )
         (if (< dist-current dist-closest)
             (loop (rest pairs) current)
             (loop (rest pairs) closest))
         )       
       ]
      )
    )
  
  (define endpoints
    (list (list (first c1) (first c2))
          (list (first c1) (second c2))
          (list (second c1) (first c2))
          (list (second c1) (second c2))))
  
  (define closest-pair (loop (rest endpoints) (first endpoints)))
  (list c1 c2 (first closest-pair) (second closest-pair)))
(closest-pair (list p1 p2) (list p3 p4))

; List-of-points -> List-of-points
(define (tsp-cp lop)
  0
  )
(tsp-cp (list p1 p2 p3))