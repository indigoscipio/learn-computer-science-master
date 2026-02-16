#lang racket

;(define l1 (cons '(1 2) '(3 4)))
;l1
;(length l1)
;(list '(1 2) '(3 4))

; counts the total number of leaves of a tree (excluding the branch)
; Tree -> Number
(define (count-leaves x)
  (cond [(empty? x) 0]
        [(not (pair? x)) 1] 
        [else (+ (count-leaves (car x))
                 (count-leaves (cdr x))) ])
  )
;(count-leaves l1)
;(list? (cons 1 2))


;(list 1 (list 2 (list 3 4)))
;(cons 1 (cons (list 2 (list 3 4)) '()) )

;exercise-2-25
; give combinations of cars and cdrs that will pick 7 from each of the following lists

;(define list1 '(1 3 (5 7) 9))
;(car (cdr (car (cdr (cdr list1)))))
;(define list2 '((7)))
;(car (car list2))
;(define list3 '(1 (2 (3 (4 (5 (6 7)))))))
;(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr list3)))))))))) ))


;exercise-2-26
;(define x (list 1 2 3))
;(define y (list 4 5 6))

;(append x y);should return '(1 2 3 4 5 6)
;(cons x y); should return (list (list 1 2 3) 4 5 6)
;(list x y); should return (list (list 1 2 3) (list 4 5 6))

;exercise-2.27
; modify reverse to produce deep-reverse that takes a list as argument and returns
; as its value the list with its elements reversed with all sublists deep reversed as well
(define x (list (list 1 2) (list 3 4)))

;List-of-X -> List-of-Y (reversed order)
; takes a list l and reverses its order
;linear recursion style
(define (deep-reverse l)
  (cond [(empty? l) '()]
        [else (append (deep-reverse (cdr l)) (list (cond [(pair? (car l)) (deep-reverse (car l))]
                                                         [else (car l)]) ))]
        )
  )
(deep-reverse x)


;iterative recursion style
(define (reverse.v2 l)
  (define (reverse-iter l0 acc)
    (cond [(empty? l0) acc]
          [else (reverse-iter (cdr l0) (cons (car l0) acc ) ) ])
    )
  (reverse-iter l '())
  )
(reverse.v2 '(1 2 3 4 5))

;; Tree-of-X is one of:
;; – X
;; – (listof Tree-of-X)

; Tree-of-X -> Tree-of-X
; Returns the reversed tree with all subtrees also deep-reversed
(define (deep-reverse.v2 l)
  ;; Tree-of-X -> Tree-of-X
  ;; Reverses the elements of the tree and deep-reverses all subtrees
  (define (deep-reverse-on-each x)
    (cond [(pair? x) (deep-reverse.v2 x)]
          [else x])
    )
  (map deep-reverse-on-each (reverse l))
  )
(deep-reverse.v2 x)