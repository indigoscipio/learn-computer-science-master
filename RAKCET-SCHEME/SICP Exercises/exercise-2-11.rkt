#lang racket

(define list1 (list 1 2 3 4 5 6 7 8))
; List-of-X X -> X
; returns the nth item of the list
(define (list-ref l n)
  (cond [(zero? n) (car l) ]
        [else (list-ref (cdr l) (sub1 n))])
  )
(list-ref list1 0)
(list-ref list1 3)


(define odds '(1 3 5 7 9))
(define (length l)
  (cond [(empty? l) 0]
        [else (+ 1 (length (cdr l)) ) ])
  )
(length odds)

(define (length.v2 l)
  (define (length.v2/acc l0 acc)
    (cond [(empty? l0) acc]
          [else (length.v2/acc (cdr l0) (+ 1 acc) ) ])
    )
  (length.v2/acc l 0) 
  )

(define (append l1 l2)
  (cond [(empty? l1) l2]
        [else (cons (car l1) (append (cdr l1) l2 ) )])
  )
(append '(1 2 3) '(4 5 6))


(define (append.v2 l1 l2)
  (define (append-iter l acc)
    (cond [(empty? l) acc]
          [else (append-iter (cdr l) (cons (car l) acc ) ) ]
          )
    )
  (append-iter l1 l2)
  )
(append.v2 '(1 2 3) '(4 5 6))
