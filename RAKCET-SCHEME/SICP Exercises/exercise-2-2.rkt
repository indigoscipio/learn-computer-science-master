#lang racket

(define (average x y)
  (/ (+ x y) 2)
  )

; a Point is a pair of number (x, y)
; Interpretation x coordinate and y coordinate of the point

; Number Number -> Point
; main constructor for the Point structure
(define (make-point x y) (cons x y))

; Point -> Number
; extracts the x coordinate of a point
(define (x-point p) (car p) )

; Point -> Number
; extracts the y coordinate of a point
(define (y-point p) (cdr p))


(define point1 (make-point 0 0))
(define point2 (make-point 5 5))

; Point -> String
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")")
  )

; a Segment is a pair of point ( (x1, y1) , (x2, y2) )
; Point Point -> Segment
; main constructor for the Segment structure
(define (make-segment p1 p2)
  (cons p1 p2))

; Segment -> Point
; extracts the start of a segment
(define (start-segment segment)
  (car segment)
  )

; Segment -> Point
; extracts the end of the segment
(define (end-segment segment)
  (cdr segment)
  )
(define segment1 (make-segment point1 point2))

; Segment -> Point
; calculates the midpoint of a segment
(define (midpoint-segment segment)
  (define p1 (start-segment segment))
  (define x1 (x-point p1))
  (define y1 (y-point p1))
  (define p2 (end-segment segment))
  (define x2 (x-point p2))
  (define y2 (y-point p2))
  (make-point (average x1 x2) (average y1 y2) )
  )
;(midpoint-segment segment1)


;A Rectangle is a pair of points
;(make-rectangle p1 p2) where p1 is the bottom left corner and tr is the top right corner
(define (make-rectangle p1 p2)
  (cons p1 p2)
  )
(define rec1 (make-rectangle point1 point2))

; Rectangle -> Point
(define (bottom-left rec) (car rec))

; Rectangle -> Point
(define (top-right rec) (cdr rec))

; Rectangle -> Number
(define (calculate-perimeter rec)
  (define p1 (bottom-left rec))
  (define p2 (top-right rec))
  (define width (- (x-point p2) (x-point p1)))
  (define height (- (y-point p2) (y-point p1)))
  (* 2 (+ width height))
  )
(calculate-perimeter rec1)

; Rectangle -> Number
(define (area rec)
  (define p1 (bottom-left rec))
  (define p2 (top-right rec))
  (define width (- (x-point p2) (x-point p1)))
  (define height (- (y-point p2) (y-point p1)))
  (* width height)
  )
(area rec1)
