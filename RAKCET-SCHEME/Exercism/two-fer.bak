#lang racket

; [X -> Y] List-of-X -> List-of-y
;given a collection and an operation to perform on each element of the collection,
;returns a new collection containing the result of applying that operation to each element of the input collection.
(define (accumulate f xs)
  ; iteration 1, build the transformed list using recursion
  (cond [(empty? xs) '()]
        [else (cons (f (car xs)) (accumulate f (cdr xs)))])

  ; Iteration 2, using accumulator
  (define (iter l acc)
    (cond [(empty? l) (reverse acc)]
          [else (iter (cdr l) (cons (f (car l)) acc))])
    )
  (iter xs '())

  ; iteration 3, using map
  (map f xs)

  ; iteration 4, using fold
  (foldr (lambda (x acc) (cons (f x) acc ) ) '() xs)
  )
(accumulate sqr '(1 2 3 4 5))