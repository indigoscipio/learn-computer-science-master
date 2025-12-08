#lang racket

;; A BT (Binary Tree) is one of:
;; 1. The empty list, representing an empty branch.
;; 2. A (list of three elements): (list VALUE LEFT-BT RIGHT-BT)
(define bt1 (list 10 '() '()))
(define bt1.5 (list 17 '() '()))
(define bt2 (list 20 bt1.5 '()))
(define bt3 (list 15 bt1 bt2))
(define bt4 (list 50 '() '()))

; get right node
(define (right bt)
  (if (null? bt) '() (caddr bt))
  )
; get left node
(define (left bt)
  (if (null? bt) '() (cadr bt))
  )

; BT -> Number
; get current node value from bt
(define (value bt)
  (car bt)
  )

;; Number BT (Sorted) -> BT
;; searches bst and return BST found, if not found return false
(define (search-bt target bt)
  ; no more children to check, not found
  ; target found
  ; keep searching
  (cond [(null? bt) #f]
        [(= target (value bt)) bt]
        [else (if (< target (value bt))
                  (search-bt target (left bt) ) ;less than target, recurse left
                  (search-bt target (right bt)) ;greater than targer, recurse right
                  )]
        )
  )
(search-bt 10 bt3)

; BT -> Number
; given a sorted bt/bst, finds the minimum value
(define (find-min bt)
  (cond [(null? (left bt)) (value bt)]
        [else (find-min (left bt))])
  )
(find-min bt3)
(find-min bt2)

; inorder : BT -> (listof Number)
; given a sorted bt/bst, list all values in sorted order
(define (inorder bt)
  (cond [(null? bt) '()]; nothing to check/leaf reached
        [else (append (inorder (left bt))
                      (list (value bt))
                      (inorder (right bt))
                      ) ])
  ; get value of current node
  ; check if thres any smalller value
  )
(inorder bt3)


;; Number BT -> BT
; given a number and a sorted bt/bst, inserts a number inot the correct position
(define (insert-bt n bt)
  (cond [(null? bt) (list n '() '()) ] ;empty tree, insert the node
        [else (cond [(< n (value bt)) (list (value bt) (insert-bt n (left bt)) (right bt) ) ]
                    [(> n (value bt)) (list (value bt) (left bt) (insert-bt n (right bt))) ]
                    [else bt])] ;non empty tree
        )
  )
(insert-bt 20 bt1)

;; delete-bt : Number BT -> BT
;; removes the target number while maintaining BST structure
;; on each iteration, rebuild the tree structure
(define (delete-bt n bt)
  (cond [(null?  bt) (list n '() '())] ; nothing to delete
        [(< n (value bt)) (list (value bt) (delete-bt n (left bt)) (right bt)) ]
        [(> n (value bt)) (list (value bt) (left bt) (delete-bt n (right bt))) ]
        [else (cond [(and (null? (left bt)) (null? (right bt))) '() ]; no children, just delete
                    [(null? (left bt)) (right bt) ] ; one children (right), ??
                    [(null? (right bt)) (left bt) ] ; one children (left), ??
                    [else (let* ((min-val (find-min (right bt)))
                                (new-right (delete-bt min-val (right bt)))
                                )
                            (list min-val (left bt) new-right)
                            )] ;two children, ??
                    )]
        )
  )
(delete-bt 11 bt1)
