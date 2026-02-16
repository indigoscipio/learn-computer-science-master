#lang racket


;; estimate-integral : (Number Number -> Boolean) Number Number Number Number Number -> Number
;; Estimate the area under predicate P, inside rectangle [x1,x2] x [y1,y2] using n trials.
(define (estimate-integral p x1 y1 x2 y2 trials)
  (monte-carlo trials (lambda ()
                        (let ([x (random-in-range x1 x2)]
                              [y (random-in-range y1 y2)])
                          (p x y)))
               )
  )



; Number (Number Number -> Boolean)
(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond [(= trials-remaining 0) (/ trials-passed trials)]
          [(experiment) (iter (sub1 trials-remaining) (add1 trials-passed) ) ]
          [else (iter (sub1 trials-remaining) trials-passed) ])
    )
  experiment
  )



; Number Number -> Number
; Generates random number range
(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))
;(random-in-range 10 20)

; Checks if a point is in the unit circle
; Number Number -> Boolean
(define (in-unit-circle? x y)
  (<= (+ (expt x 2) (expt y 2)) 1)
  )


;Exercise 3.6
;; rand : 'generate -> Number
;;        'reset -> (Number -> Void)
(define rand
  (let ((seed 0))
    
    (lambda (x) (cond [(eq? x 'generate) (begin (set! seed (rand-update seed)) seed) ]
                      [(eq? x 'reset) (lambda (x) (set! seed new-seed) )]
                      [else (error "Unknown Operation")]
                      ))
    )
  )

(rand 'generate) ; produces a new random number
((rand 'reset) 100) ; resets the internal state variable to the designated new value