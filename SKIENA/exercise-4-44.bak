#lang racket

#|
mergesort
+ stable, never changes the order
- needs to make copy of data

quicksort
+ fastest
- worst case "subtract" and conquer instead of divide and conquer

heapsort
+ guarantees peed and use no extra memory
- slower than quicksort

binary sort
+ great for dynamic data
- risky if tree isn't balanced

selection srot


|#

; list-of-number -> list-of-number
(define (dedup lst)

  #|
  ;; naive way/check everyone = N^2
  (define (loop xs)
    (cond [(empty? xs) '()]
          [(member (car xs) (cdr xs)) (loop (cdr xs))]
          [else (cons (car xs) (loop (cdr xs)))]
          )
    )
  (loop lst)
  |#

  #|
  ;; sort first = N log n
  (let ((sorted-xs (sort lst <)))
    (define (loop xs)
      (cond [(empty? xs) '()]
            [(empty? (cdr xs)) '()] ;1 item left
            [else (let ((curr-item (car xs))
                        (next-item (cadr xs))
                        )
                    (if (equal? curr-item next-item)
                        (loop (cdr xs)) ; skip it
                        (cons (car xs) (loop (cdr xs))); add it
                        )
                    )])
      )
    (loop sorted-xs)
    )
  |#

  ;;most efficient
  (let ((seen (mutable-set)))
    (define (loop xs)
      (cond [(empty? xs) (set->list seen)]
            [(set-member? seen (car xs)) (loop (cdr xs))]
            [else (begin (set-add! seen (car xs))
                         (loop (cdr xs))
                         )]

            )
      )
    (loop lst)
    )
  )
(dedup '(5 2 5 1 2 8))
