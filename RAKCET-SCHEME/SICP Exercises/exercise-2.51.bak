#lang racket

(require sicp-pict)
(define wave einstein)



; Exercise 2.49
; a. The painter that draws the outline of the designated frame.
(define pp-outline (segments->painter (list (make-segment (make-vect 0 1) (make-vect 1 1))
                                            (make-segment (make-vect 1 1) (make-vect 1 0))
                                            (make-segment (make-vect 1 0) (make-vect 0 0))
                                            (make-segment (make-vect 0 0) (make-vect 0 1))
                                            )) )
;(paint pp-outline)


; b. the painter that draws an “X” byconnecting opposite corners of the frame.
(define pp-x (segments->painter (list (make-segment (make-vect 0 0) (make-vect 1 1))
                                      (make-segment (make-vect 0 1) (make-vect 1 0))
                                      )) )
;(paint pp-x)

; c. the painter that draws a diamond shape by connecting the midpoints of the sides of the frame.
(define pp-dia (segments->painter (list (make-segment (make-vect 0.5 1) (make-vect 1 0.5))
                                        (make-segment (make-vect 1 0.5) (make-vect 0.5 0))
                                        (make-segment (make-vect 0.5 0) (make-vect 0 0.5))
                                        (make-segment (make-vect 0 0.5) (make-vect 0.5 1))
                                      )) )
;(paint pp-dia)

; d. the wave painter.
; Yeah i think i'm gonna skip this one lol

(define v0 (make-vect 0.5 0.1))
(define v1 (make-vect 0.2 1))
(define v2 (make-vect 0 0))


;exercise 2.50
; transformation flips painters horizontally
;Painter -> Painter
(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1.0 0.0) ; origin: x = 1, y = 0
                     (make-vect 0.0 0.0) ; edge1: x = 0, y = 0
                     (make-vect 1.0 1.0)) ; edge2: x = 1, y = 1
  )

;(paint einstein)
; transformations that rotate painters counterclockwise by 180deg
(define (rotate-180deg painter)
  (transform-painter painter
                     (make-vect 1.0 1.0) ; origin: x = 1, y = 1
                     (make-vect 0.0 1.0) ; edge1: x = , y =
                     (make-vect 1.0 0.0))
  )
;(paint (rotate-180deg wave))

; transformation that rotate painter counterclockwise by 270deg
(define (rotate-270deg painter)
  (transform-painter painter
                     (make-vect 0.0 1.0) ; origin: x = 1, y = 1
                     (make-vect 0.0 0.0) ; edge1: x = , y =
                     (make-vect 1.0 1.0))
  )
;(paint (rotate-270deg wave))

