#lang racket

(define (triangle a b c)
  ; all sides have to be length >0
  (let ((valid? (and (and (> a 0) (> b 0) (> c 0))
                     (and (> (+ a b) c) (> (+ b c) a) (> (+ a c) b )))))

  
    (cond [(not valid?) (error "invalid")]
          [(and (= a b) (= b c) ) 'equilateral] ;equilateral
          [(or (= a b) (= b c) (= a c) ) 'isosceles] ;isoceles (at least 2 have the same length)
          [else 'scalene] ;else it's scalane
          )
    
    )
  )
(triangle 1 1 1)
(triangle 2 2 10)