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
;(make-rectangle Point Number Number) where:
; p is the main corner point
; w is the rectangle's width
; h is the rectangle's height
(define (make-rectangle p w h)
  (cons p (cons w h))
  )

(define rec1 (make-rectangle point1 10 15))

;Rectangle -> Number
; extracts the width of a rectangle
(define (rec-width r)
  (car (cdr r))
  )

;Rectangle -> Number
;extracts the height of a rectangle
(define (rec-height r)
  (cdr (cdr r))
  )

; Rectangle -> Point
(define (rec-point r)
  (car r)
  )

;Rectangle -> Number
;calcualtes the are aof a rectangle
(define (area r)
  (* (rec-width r) (rec-height r))
  )
(area rec1)

(define (calculate-perimeter r)
  (* 2 (+ (rec-width r) (rec-height r)))
  )
(calculate-perimeter rec1)