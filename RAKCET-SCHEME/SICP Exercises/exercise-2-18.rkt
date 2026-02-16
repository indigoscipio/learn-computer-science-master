#lang racket


;exercise 2.17
; List-of-X -> X
; returns the list that contains only the last element of a given nonempty list
; (last-pair '(1 2 34)) retuurns '(34)
; linear recursion style
(define (last-pair l)
  (cond [(empty? l) '()]
        [(empty? (cdr l)) (list (car l))]
        [else (last-pair (cdr l))])
  )
(last-pair '(1 2 3 4 5))
;(last-pair (list "a" "b" "c"))


;iterative recursion style
; List-of-X -> X
(define (last-pair.v2 l)
  ;accumulator acc accumulates the the ??
  (define (last-pair-iter l acc)
    (cond [(empty? l) (list acc)]
          [else (last-pair-iter (cdr l) (car l) ) ]
          )
    )
  (last-pair-iter l '())
  )
(last-pair.v2 '(1 2 3 4 5))


;Appends an item to the end of the list
(define (append-to-last x l)
  (append l (list x) )
  )
(append-to-last 4 '(1 2 3))

;exercise 2.18
; takes a list l and reverses its order
;List-of-X -> List-of-Y (reversed order)
;linear recursion style
(define (reverse l)
  (cond [(empty? l) '()]
        [else (append-to-last (car l) (reverse (cdr l)))]
        ;[else (append (reverse (cdr l)) (list (car l)) )]
        )
  )
(reverse '(1 2 3 4 5))

;iterative recursion style
(define (reverse.v2 l)
  (define (reverse-iter l0 acc)
    (cond [(empty? l0) acc]
          [else (reverse-iter (cdr l0) (cons (car l0) acc ) ) ])
    )
  (reverse-iter l '())
  )
(reverse.v2 '(1 2 3 4 5))