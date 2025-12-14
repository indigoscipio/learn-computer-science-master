#lang racket

; a BT is one of the following:
; '()
; (listof Node BT BT)
; where node is te parent followed by left bt and right bt
(define bt1 (list 2 '() '()))
(define bt2 (list 5 4 6))
(define bt3 (list 2 '() '()))
(define bt4 (list '() 5 10))

; BT -> Value
(define (value bt)
  (car bt)
  )

; BT -> Value
(define (right bt)
  (caddr bt)
  )

; BT -> Value
(define (left bt)
  (cadr bt)
  )

; if one has a left child, the other has a left child
; BT BT -> Boolean
(define (is-identical? bt1 bt2)
  (cond  [(and (null? bt1) (null? bt2))  #t ] ;both null
         [(or (null? bt1) (null? bt2)) #f] ;one is null
         [else (and (is-identical? (left bt1) (left bt2))
                                             (is-identical? (right bt1) (right bt2))) ] ;compare node value
         )
  )
(is-identical? bt1 bt2) ;should return false
(is-identical? bt1 bt3) ;should return true