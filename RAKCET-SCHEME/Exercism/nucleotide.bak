#lang racket

(define (keep pred seq)
  #|
  ; iteration 1, build the filtered list using recursion
  (cond [(null? seq) '()]
        [(pred (car seq)) (cons (car seq) (keep pred (cdr seq)))]
        [else (keep pred (cdr seq))])

  ; iteration 2, using accumulator
  ; keep the filtered list inside acc
  (define (iter l acc)
    (cond [(empty? l) (reverse acc)]
          [(pred (car l)) (iter (cdr l) (cons (car l) acc))]
          [else (iter (cdr l) acc)])
    )
  (iter seq '())
  |#
  (filter pred seq)
  )

(define (discard pred seq)
  #|
  ; iteration 2, build the filtered list using recursion
  (cond [(null? seq) '()]
        [(pred (car seq)) (discard pred (cdr seq))]
        [else (cons (car seq) (discard pred (cdr seq)) )])

  ; iteration 2, using accumulator
  ; keep the discarded list inside acc
  (define (iter l acc)
    (cond [(empty? l) (reverse acc)]
          [(pred (car l)) (iter (cdr l) acc)]
          [else (iter (cdr l) (cons (car l) acc))])
    )
  (iter seq '())
  |#
  (filter (lambda (x) (if (pred x)
                          #f
                          #t)) seq)
  )

(keep even? '(1 2 3 4 5))
(discard even? '(1 2 3 4 5))

