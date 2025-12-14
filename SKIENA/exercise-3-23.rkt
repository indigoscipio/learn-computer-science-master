#lang racket

(define (rev-ll ll)
  (define (helper list result)
    (cond [(null? list) result]
          [else (helper (cdr list) (cons (car list) result))]
          )
    )
  (helper ll '())
  )
(rev-ll '(1 2 3 47 5))