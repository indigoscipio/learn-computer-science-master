#lang racket

(require sicp-pict)

;exercise 2.46
; data structure for a vector
; a Vector is a Pair of Number, where each number represents position in x and y axis
; make-vector (Number Number)
; creates a vector based on a given x and y coordinate
; Number Number -> Vector
(define (make-vect x y)
  (cons x y)
  )

(define v0 (make-vect 1 2))
(define v1 (make-vect 3 4))
(define v2 (make-vect 5 6))

; Vector -> Number
; extracts the x-coord of a vector
(define (xcor-vect v)
  (car v)
  )
;(xcor-vect v0)

; Vector -> Number
; extracts the y-coord of a vector
(define (ycor-vect v)
  (cdr v)
  )
;(ycor-vect v0)

; Vector Vector -> Vector
; adds two vectors
(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1) (xcor-vect v2) ) (+ (ycor-vect v1) (ycor-vect v2)) )
  )

; Vector Vector -> Vector
; subtracts two vectors
(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1) (xcor-vect v2) ) (- (ycor-vect v1) (ycor-vect v2)) )
  )

; Number Vector -> Vector
; scale a vector by s
(define (scale-vect s v)
  (make-vect (* s (xcor-vect v) ) (* s (ycor-vect v)) )
  )

;exercise 2.47
; provide selector for each constructor
(define (make-frame.v1 origin edge1 edge2)
  (list origin edge1 edge2)
  )

(define (make-frame.v2 origin edge1 edge2)
  (cons origin (cons edge1 edge2))
  )

(define frame0 (make-frame.v1 v0 v1 v2))
(define frame1 (make-frame.v2 v0 v1 v2))

; Frame -> Vector
; Extracts the frame's origin vector
(define (frame-origin.v1 frame)
  (car frame)
  )
;(frame-origin.v1 frame0)

(define (frame-origin.v2 frame)
  (car frame)
  )
;(frame-origin.v2 frame1)

; Frame -> Vector
; Extracts the frmae's edge1 vector
(define (frame-edge1 frame)
  (cadr frame)
  )
;(frame-edge1 frame0)

(define (frame-edge1.v2 frame)
  (cadr frame)
  )
;(frame-edge1.v2 frame1)


;Frame -> Vector
; Extracts the frame's edge2 vector
(define (frame-edge2 frame)
  (caddr frame)
  )
;(frame-edge2 frame0)

(define (frame-edge2.v2 frame)
  (cddr frame)
  )
;(frame-edge2.v2 frame1)

;exercise 2.48
; A Segment is a Pair-of-Vector
; make-segment Vector Vector
; Interpretation is a data structure for a segment where v1 is the start vector and v2 is the end vector
(define (make-segment v1 v2)
  (cons v1 v2))
  

(define seg0 (make-segment v0 v1))

; Segment -> Vector
; Extracts the start vector of a segment
(define (start-segment segment)
  (car segment)
  )
;(start-segment seg0)

; Segment -> Vector
; Extracts the end vector of a segment
(define (end-segment segment)
  (cdr segment)
  )
;(end-segment seg0)

; Exercise 2.49
; a. The painter that draws the outline of the designated frame.
(define outline (segments->painter (list (make-vect 0 1)
                                         (make-vect 1 1)
                                         (make-vect 1 0)
                                         (make-vect 0 0)) ))


; b. the painter that draws an “X” byconnecting opposite corners of the frame.
; c. the painter that draws a diamond shape by connecting the midpoints of the sides of the frame.
; d. thwave painter.