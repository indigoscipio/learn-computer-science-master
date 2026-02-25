#lang racket

(define (find-majority lst)
  (define n (length lst))

  ; Pass 1: find candidate via Boyer-Moore
  (define (vote xs count curr)
    (cond
      [(null? xs) curr]
      [(zero? count) (vote (cdr xs) 1 (car xs))]
      [(equal? curr (car xs)) (vote (cdr xs) (+ count 1) curr)]
      [else (vote (cdr xs) (- count 1) curr)]))

  ; Pass 2: verify candidate is actual majority
  (define candidate (vote (cdr lst) 1 (car lst)))
  (define freq (length (filter (lambda (x) (equal? x candidate)) lst)))

  (if (> freq (quotient n 2))
      candidate
      '()))

(find-majority '(a b a c a a d)) ; returns a
(find-majority '(a b c d e f g)) ; returns '(), no majority