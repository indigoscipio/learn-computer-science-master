#lang racket




;A Tree is a ??
; Number Tree Tree -> Tree
(define (make-tree entry left right)
  (list entry left right)
  )
(define tree3 (make-tree 3 '() '()))
(define tree1 (make-tree 1 '() '()))
(define tree2 (make-tree 2 tree1 tree3))



; Tree -> Number
(define (entry tree) (car tree))

; Extracts the left branch of a tree
; Tree -> Tree
(define (left-branch tree) (cadr tree))


; Extracts the left branch of a tree
; Tree -> Tree
(define (right-branch tree) (caddr tree))


; Entry Tree -> Boolean
(define (element-of-set? x set)
  (cond [(empty? set) #f]
        [(= x (entry set)) #t]
        [(< x (entry set)) (element-of-set? x (left-branch set) ) ] ;recurse to the left
        [(> x (entry set)) (element-of-set? x (right-branch set))] ; else recurse to the right
        )
  )


; Number Tree -> Tree
(define (adjoin-set x set)
  (cond [(empty? set) (make-tree x '() '())]
        [(= x (entry set)) set ]
        [(< x (entry set)) (make-tree (entry set) (adjoin-set x (left-branch set)) (right-branch set)) ]
        [else (make-tree (entry set) (left-branch set) (adjoin-set x (right-branch set)) ) ]
        )
  )
;(adjoin-set 1 tree2)

;exercise 2.63
; Converts binary tree into a list
(define (tree->list-1 tree)
  (cond [(empty? tree) '()]
        [else (append (tree->list-1 (left-branch tree))
                      (cons (entry tree) (tree->list-1 (right-branch tree))) ) ])
  )
;(tree->list-1 tree2)
; tree->list1 tree2 how each call works
; tree = (make-tree 2 tree1 tree3)
; tree left = tree1, tree right = tree3
;(append (tree->list tree1) (cons 2 (tree->list-1 tree3) ) )
; tree left = (make-tree 1 '() '()), tree right = (make-tree 3 '() '())
;(append (tree->list (make-tree 1 '() '()) ) (cons 2 (append '() (cons 3 (tree->list-1 '()) ) ) ) )

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (cond [(empty? tree) result-list]
          [else (copy-to-list (left-branch tree) (cons (entry tree) (copy-to-list (right-branch tree) result-list) ) ) ])
    )
  (copy-to-list tree '())
  )
;(tree->list-2 tree2)
; in this version it uses tail recursion/iterative style with accumulator
; each step build the list inside the result-list accumulator.
; tree->list-2 how each call works
; (copy-to-list tree1 (cons 2 (copy-to-list tree3 '()) ) )
; (copy-to-list (make-tree 1 '() '()) (cons 2 (copy-to-list (make-tree 3 '() '()) '()) ) )
; (copy-to-list (list 1 '() '()) (cons 2 3) ) -> tree is empty, return accumulator

; answer to part a:
; the 2 procedures inputs the same data but outputs different result. the 1st one has empty list inside '(1 () ()  2 3)
; whereas the second one removes the empty list '(1 2 3)

; answer to part b:
; the one for the 2nd is more efficient because it uses accumulator/tail recursive;
; it doesn't build up stack and doesn't calculate at the end but at every iteration (eg conses the accumulator at every call)
; 1st version is slower because its linear recursion and builds up stack and append at the end

;exercise 2.64
; Converts list into binary tree
(define (list->tree elements)
  (car (partial-tree elements) (length elements) )
  )
(define (partial-tree elts n)
  (cond [(= n 0) (cons '() elts)]
        [else (let* ((left-size (quotient (- n 1) 2) )
                     (left-result (partial-tree elts left-size))
                     (left-tree (car left-result) )
                     (non-left-elts (cdr left-result) )
                     (right-size (- n (+ left-size 1)))
                     (this-entry (car non-left-elts) )
                     (right-result (partial-tree (cdr non-left-elts) right-size) )
                     (right-tree (car right-result))
                     (remaining-elts (cdr right-result))
                     )
                (cons (make-tree this-entry left-tree right-tree) remaining-elts )
                )])
  )

; what does partial tree do? write a short paragraph
; answer: it creates a version of a tree where the arrangement is balanced
; takes a ordered list of element

(partial-tree '(1 3 5 7 9 11) 2)
; 1st call
; left size = (quotient (- 6 1) 2) = (quotient 5 2) = 2
; left subtree built from first 2 elmeent 1 3
; recursive = (partial-tree '(1 3 5 7 9 11) 2)
; left size = (quotient 2 2) = 0
; build left subtree from 0 elements = emtry tree
; reached base case -> returns (cons '() '(1 3 5 7 9 11))
; this entry = 0

; exercise 2.65
; O(n) implementation of union set and intersection-set implemented as balanced binary tree
; Tree Tree -> Tree
(define (union-set-balanced tree1 tree2)
  ; flatten two inputs into ordered list

  ;
  )