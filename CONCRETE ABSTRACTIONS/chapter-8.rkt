#lang racket

; BST - sorted
; some tress aresn't sorted

; a BST is one of the following:
; '()
; (list value left right) where left and right are a type of BST and value is 'sorted'


(define (make-empty-tree)
  '()
  )

(define (make-nonempty-tree root left right)
  (list root left right)
  )

(define empty-tree? null?)
(define root car)
(define left-subtree cadr)
(define right-subtree caddr)

(define sample-bst '(4
                    (2 (1 () ()) (3 () ()))
                    (6 (5 () ()) (7 () ()))))

#|
Exercise 8.1
Write a procedure called minimum that will find the smallest element in a nonempty
binary search tree of numbers.

answer:
|#

(define (minimum tree)
  (cond [(empty-tree? (left-subtree tree)) (root tree)] ;tree is empty, return the value
        [else (minimum (left-subtree tree))] ;keep recursing to the left
        )
  )
(minimum sample-bst)

; ==========================================================

#|
Exercise 8.2
Write a procedure called number-of-nodes that will count the number of elements
in a binary search tree

answer:
|#

(define (number-of-nodes bst)
  (cond [(empty-tree? bst) 0]
        [else (+ 1 (number-of-nodes (left-subtree bst))
                 (number-of-nodes (right-subtree bst))
                 ) ])
  )
(number-of-nodes sample-bst)




; ==========================================================

#|
exercixe 8.3
|#

(define (list-by-key-onto tree list)
  (cond [(empty-tree? tree) list]
        [else (cons (root tree) (list-by-key-onto (left-subtree tree) (list-by-key-onto (right-subtree tree) list)) )]
        )
  )