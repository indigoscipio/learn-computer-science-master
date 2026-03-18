#lang racket

#|
Exercise 5.1
Write a linear iterative version of together-copies-of

answer:
|#

#|
(define (together-copies-of combine quantity thing)

  (define (loop count acc)
    (cond [(= count 1) acc] ;last one
          [else (loop (- count 1) (combine thing acc) )]
          )
    )
  (loop quantity thing)
  
  )
(together-copies-of + 3 10)
|#

#|
(define (together-copies-of combine quantity thing)
  (cond [(= 1 quantity) thing]
        [else (let ((new-quantity (quotient quantity 2)))
                (if (even? quantity)
                    (let ((result (together-copies-of combine new-quantity thing)))
                      (combine result result)
                      )
                    
                    (combine (together-copies-of combine (- quantity 1) thing) thing)
                    )
                )]
        )
  )
(together-copies-of + 3 10)
|#
