#lang racket

; a BST is one of the following:
; '()
; (listof Node BST BST)
; where node is te parent followed by left bt and right bt in SORTED ORDER
(define bst1 (list 2 '() '()))
(define bst2 (list 5 '() '()))
(define bst3 (list 5 '() '()))
(define bst4 (list 100 99 101))
(define bst5 (list 3 bst1 bst3))

; BST -> Value
(define (value bst)
  (car bst)
  )

; BST -> Value
(define (right bst)
  (caddr bst)
  )

; BST -> Value
(define (left bst)
  (cadr bst)
  )

; converts BST into a linked list
; BST -> List-of-x
(define (bst->ll bst)
  (cond [(null? bst) '()] ;reached leaf
        [else (append (bst->ll (left bst))
                      (list (value bst))
                      (bst->ll (right bst)) ) ]
        )
  )
(bst->ll bst5)


#|
(define (bst-to-list-helper node)
  ; 1. Base Case: Stop at empty subtrees
  (if (null? node)
      '() ; Nothing to do
      (begin
        ; A. Traverse Left Subtree (L-step)
        (bst-to-list-helper (left node))

        ; B. Process Current Node (N-step) - THIS IS WHERE WE STITCH!

        ; C. Traverse Right Subtree (R-step)
        (bst-to-list-helper (right node))
        )
      ))
|#