#lang racket

;; A BT (Binary Tree) is one of:
;; 1. The empty list, representing an empty branch.
;; 2. A (list of three elements): (list VALUE LEFT-BT RIGHT-BT)
(define bt3 '(15 bt1 bt2))
(define bt1 '(10 () ()))
(define bt2 '(20 () ()))

; get right node
(define (right bt)
  (caddr bt)
  )
; get left node
(define (left bt)
  (cadr bt)
  )

; get value from bst
(define (value bt)
  (car bt)
  )

; BT -> BT
; given a BT, searches a value
(define (search-bt bt)
  0
  )


; BT -> BT
; given a BT, searches that BT's min value
(define (find-min bt)
  0
  )

