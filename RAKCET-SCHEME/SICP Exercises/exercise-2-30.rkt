#lang racket

#|
; A Tree is:
; - a number (leaf), or
; - a pair where the car is the node's value and the cdr is a list of subtrees (each subtree is also a Tree).
; Tree -> Tree
; Scale each number in the tree by the given factor

(define (scale-tree tree factor)
  (cond [(empty? tree) '()]
        [(number? tree) (* tree factor)]
        [else (cons (scale-tree (car tree) factor) (scale-tree (cdr tree) factor) )]
        )
  )
(scale-tree '(1 2 (3 3) 4 5) 10)


(define (scale-tree.v2 tree factor)
  (map (lambda (node) (cond [(number? node) (* node factor)]
                            [else (scale-tree.v2 node factor) ])

         ) tree)
  )
|#


;exercise 2.30

; A Tree is:
; - a Number (leaf), or
; - a List-of-Tree (subtrees)

; Tree -> Tree
; using linear recursion
(define (square-tree tree)
 (cond [(empty? tree) '()]
       [(number? tree) (sqr tree) ]
       [else (cons (square-tree (car tree)) (square-tree (cdr tree)) ) ]
       )
  )
;(square-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))
;(square-tree 4)


;computes sum of squares of tree that are odd
; Tree -> Number
(define (sum-odd-square tree)
 (cond [(empty? tree) 0]
       [(number? tree) (cond [(odd? tree) (sqr tree)]
                             [else 0]) ] ;check if its a number, if so check if its odd and sum them
       [else ( + (sum-odd-square (car tree)) (sum-odd-square (cdr tree)) )] ;else its a pair
       )
  )
(define tree1 (list 1 (list 2 (list 3 4) 5) (list 6 7)))

; Tree -> List-of-X
(define (enumerate-leaves tree)
  (cond ((null? tree) '())                 ; Empty tree → empty list
        ((not (pair? tree)) (list tree))   ; Leaf → wrap in list
        (else (append (enumerate-leaves (car tree)) 
                      (enumerate-leaves (cdr tree))))))
(define enum-tree1 (enumerate-leaves tree1))


;[X -> Boolean] List-of-X -> List-of-Y
(define (filter f l)
  (cond [(empty? l) '()]
        [(f (car l)) (cons (car l) (filter f (cdr l)) ) ]
        [else (filter f (cdr l)) ]
        )
  )
;(filter odd? enum-tree1)

; [X -> Y] List-of-X -> List-of-Y
(define (map f l)
  (cond [(empty? l) '()]
        [else (cons (f (car l) ) (map f (cdr l)) ) ])
  )

(define (accumulate op init l)
  (define (acc-iter l0 acc)
    (cond [(empty? l0) acc]
          [else (acc-iter (cdr l0) (op (car l0) acc) ) ])
    )
  (acc-iter l init)
  #|
  (cond [(empty? l) init]
        [else (op (car l) (accumulate op init (cdr l))) ])
  |#
  )
(accumulate + 0 enum-tree1)

(define (sum-odd-square.v3 tree)
  (accumulate + 0 (map sqr (filter odd? (enumerate-leaves tree)))) 
  )
;(sum-odd-square.v3 tree1)