#lang racket
#|
(define (scale-list l f)
  (cond [(empty? l) l]
        [else (cons (* (car l) f) (scale-list (cdr l) f) ) ])
  )

(define (scale-list.v2 l f)
  ; accumulator acc stores the list of items that's applied by factor f on each computation
  (define (scale-list-iter l0 acc)
    (cond [(empty? l0) (reverse acc)]
          [else (scale-list-iter (cdr l0) (cons (* (car l0) f) acc) )])
    )
  (scale-list-iter l '())
  )
(define (my-map f l)
  (cond [(empty? l) '()]
        [else (cons (f (car l)) (my-map f (cdr l)) ) ]
        )
  )

(define (scale-list.v3 l f)
  (my-map (lambda (x) (* x f)) l )
  )
|#

;exercise 2.21
;square list takes a list of numbers
; and returns a list of the squares of those numbers
; List-of-Numbers -> List-of-Numbers
(define (square-list.v1 l)
  (cond [(empty? l) '()]
        [else (cons (sqr (first l)) (square-list.v1 (rest l)) ) ])
  )

(define (square-list.v2 l)
  (map (lambda (x) (sqr x)) l)
  )


(square-list.v1 (list 1 2 3 4)) ;should return '(1 4 9 16)
(square-list.v2 (list 1 2 3 4 ))

;Exercise 2.22

(define (square-list.v3 items)
  (define (iter things answer)
    (if (empty? things)
        answer
        (iter (cdr things) (cons (sqr (car things))  answer))))
  (iter items '()))
(square-list.v3 '(1 2 3 4 5))

(define (square-list.v4 items)
  (define(iter things answer)
    (if(empty? things)
       answer
       (iter (cdr things) (cons answer (sqr (car things))))))
  (iter items '()))
(square-list.v4 '(1 2 3 4 5))

; In the first one, (square-lsit.v3), The list is reversed because of the way iterative recursion processes each items in the list
; it processes the last item of the list as the first one (5) -> (25) because cons adds the first item to the front
; 1st call: (cons 1 '()), then (cons 9 (cons 1 '()))
; to fix this the answer needs to be reversed on the first if case, so instead os answer it needs to be (reverse answer)

;in the second one (square-list.v4), the cons puts the accumulator answer in as the first item of the list
; so on 1st call, '('() 1), 2nd call: '('('() 1) 4), etc so it puts an empty list on each call inside the cons