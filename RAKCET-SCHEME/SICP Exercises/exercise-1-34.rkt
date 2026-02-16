#lang racket
(define THRESHOLD 0.001)

(define (average x y)
  (/ (+ x y)
     2)
  )

(define (close-enough? x y)
  (< (abs (- x y)) THRESHOLD)
  )
(close-enough? 1 1.001)

(define (search f neg-point pos-point)
  (let ((mid-point (average neg-point pos-point)))
    (cond [(close-enough? neg-point pos-point) mid-point]
          [else (let ((curr-value (f mid-point) ))
                  (cond [(positive? curr-value) (search f neg-point mid-point)]
                        [(negative? curr-value) (search f mid-point pos-point)]
                        [else mid-point]
                        )
                  )])
    )
  )
(search sqr -5 16)