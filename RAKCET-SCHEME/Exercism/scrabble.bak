#lang racket

(define (collatz n)

  #|
  ; Number Number -> Number
  ; acc hods the total number of steps
  ; iteration 1: iter accumulator
  (define (iter num acc)
    (cond [(= 1 num) acc]
          [(even? num) (iter (/ num 2) (+ 1 acc))]
          [else (iter (+ (* num 3) 1) (+ 1 acc) )]
          )
    )
  (iter n 0)
  |#

  ; iteration 2, using plain/structural recursion
  (cond [(= n 1 ) 0]
        [(even? n) (+ 1 (collatz (/ n 2)))]
        [else (+ 1 (collatz (+ (* n 3) 1) ))]
        )

  ; iteration 3, named loop
  (let loop ([x 10] [y 0])
    ;; body using x and y
    (if (= x 0)
        y
        (loop (- x 1) (+ y x))))

  
  )

(collatz 12) ;returns 9
(collatz 1) ; return 0
(collatz 16) ; return 4