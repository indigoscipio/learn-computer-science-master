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
(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (cond [(empty? tree) result-list]
          [else (copy-to-list (left-branch tree) (cons (entry tree) (copy-to-list (right-branch tree) result-list) ) ) ])
    )
  (copy-to-list tree '())
  )

;exercise 2.64
; Converts list into binary tree
(define (list->tree elements)
  (car (partial-tree elements (length elements)) )
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

; exercise 2.65
; O(n) implementation of union set  as balanced binary tree
; Tree Tree -> Tree
(define (union-set-balanced tree1 tree2)
  ; flatten two inputs into ordered list
  (let ((list-tree1 (tree->list-2 tree1))
        (list-tree2 (tree->list-2 tree2))
        )

    ;List-of-Number List-of-Number -> List-of-Number
    ;Creates a union of two sorted ordered list 
    (define (union-sorted-lists l1 l2)
      (cond [(empty? l1) l2]
            [(empty? l2) l1]
            [(= (car l1) (car l2)) (cons (car l1) (union-sorted-lists (cdr l1) (cdr l2)) )] ;car list1 = car list2
            [(< (car l2) (car l1)) (cons (car l2) (union-sorted-lists l1 (cdr l2) )) ]
            [else (cons (car l1) (union-sorted-lists (cdr l1) l2) ) ]
            )
      )
    (list->tree (union-sorted-lists list-tree1 list-tree2))
    )
  )
;(union-set-balanced tree1 tree3)


;Tree Tree -> Tree
; O(n) implementation of intersection set as balanced binary tree
(define (intersection-set-balanced tree1 tree2)
  (let ((list-tree1 (tree->list-2 tree1))
        (list-tree2 (tree->list-2 tree2))
        )

    ; List-of-Number List-of-Number -> List-of-Number
    ; Creates a interseciton of two sets of sorted ordered list
    (define (intersection-sorted-lists l1 l2)
      (cond [(or (empty? l1) (empty? l2)) '()]
            [(= (car l1) (car l2)) (cons (car l1) (intersection-sorted-lists (cdr l1) (cdr l2))) ]
            [(< (car l1) (car l2)) (intersection-sorted-lists (cdr l1) l2)]
            [else (intersection-sorted-lists l1 (cdr l2))]
            )
      )

    ;calls intersection sorted list and turn into tree
    (list->tree (intersection-sorted-lists list-tree1 list-tree2))
    )
  )
(intersection-set-balanced tree1 tree1)