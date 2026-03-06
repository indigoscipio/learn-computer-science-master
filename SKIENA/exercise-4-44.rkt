#lang racket

;; a stack is a list of pairs
;; where each pair holds curr value . min value

(define (push pair stack)
  (cons pair stack)
  )

;; pops a pair into a stack
(define (pop stack)
  (cdr stack)
  )

;; gets the minumum
(define (min stack)
 (cdr (car stack))
  )