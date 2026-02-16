#lang racket

;exercise 2.19

 (define us-coins (list 50 25 10 5 1))
 (define uk-coins (list 100 50 20 10 5 2 1 0.5))

; List-of-X -> X
; Gets the first item of in the list
(define (first-denomination coin-values)
  (car coin-values)
  )

; List-of-X -> List-of-X
(define (except-first-denomination coin-values)
  (cdr coin-values)
  )

; List-of-X -> Boolean
(define (no-more? coin-values)
  (empty? coin-values)
  )

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination
                 coin-values))
            (cc (- amount
                   (first-denomination
                    coin-values))
                coin-values)))))

(cc 100 us-coins)