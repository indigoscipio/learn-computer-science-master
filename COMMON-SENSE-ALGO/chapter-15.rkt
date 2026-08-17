#lang racket


; CHAPTER 15
; BST

; BT -> tree in which each node has 0, 1, or 2 children
; BST -> can have at most 1 left child and 1 right child
; left descendant should be less than the node itself

; a BST is a (listof Root Left Right)
; or an empty list '()
; where Left and Right is a BST (children nodes)
; and Root/Value is a Number

(define (make-bst root left right)
  (list root left right)
  )

(define bst0 (make-bst 5 (make-bst 3 '() '()) (make-bst 7 '() '()) ))
(define bst1 (make-bst 20 (make-bst 15 '() '()) '()))
(define bst2 (make-bst 10 bst0 bst1))

; SELECTORS
(define empty-bst '())
(define (bst-empty? bst) (null? bst))
(define (bst-root bst)(car bst))
(define (bst-left bst)(cadr bst))
(define (bst-right bst) (caddr bst))


; SEARCH
; list/functional style
; BST Number -> MaybeNumber
(define (bst-search bst target)
  (cond [(bst-empty? bst) #f] ;checked all of the nodes
        [(= target (bst-root bst)) (bst-root bst)] ; found it
        [(< target (bst-root bst)) (bst-search (bst-left bst) target)] ; go left
        [else (bst-search (bst-right bst) target) ] ; go right
        )
  )
(bst-search bst2 11)

; INSERT
; take O(log n + 1) steps
(define (bst-insert bst val)
  ; rebuild with make-bst recursive call
  ; no chidlren? check if its > or < than root,
  ; then insert accordidngly
  (cond [(bst-empty? bst) (make-bst val empty-bst empty-bst) ]
        [(< val (bst-root bst))
         (make-bst (bst-root bst)
                   (bst-insert (bst-left bst) val)
                   (bst-right bst)) ] ;go left
        [else (make-bst (bst-root bst)
                        (bst-left bst)
                        (bst-insert (bst-right bst) val) ) ]
        )
  )
(bst-insert bst2 13)

; DELETE
; case: 0 children -> just remove
; case: 1 children -> children 'step up' and becomes root, delete prev root
; case: 2 children -> choose only 1 replacement root
; the root must be bigger than anyone in left and smaller than right
; aka smallest value in right side. move 1 step right then find smallet
(define (bst-delete bst val)
  (cond [(bst-empty? bst) empty-bst] ;bst is empty
        [(< val (bst-root bst)) (make-bst (bst-root bst)
                                          (bst-delete (bst-left bst) val)
                                          (bst-right bst)) ] ; go left
        [(> val (bst-root bst)) (make-bst (bst-root bst)
                                          (bst-left bst)
                                          (bst-delete (bst-right bst) val)) ] ; go right
        [else (cond [(and (bst-empty? (bst-left bst))
                          (bst-empty? (bst-right bst))) empty-bst] ; no child
                    [(bst-empty? (bst-left bst)) (bst-right bst) ] ; 1 child (left empty)
                    [(bst-empty? (bst-right bst)) (bst-left bst)] ; 1 child (right empty)
                    [else ...] ; 2 child
                    )] ; found the node
        )
  )
bst2 ;'(10 (5 (3 () ()) (7 () ())) (20 (15 () ()) ()))
(bst-delete bst2 15)
(bst-delete (make-bst 3 '() '()) 3) ; no child
(bst-delete (make-bst 3 (make-bst 1 '() '()) '()) 3) ; 1 child
(bst-delete (make-bst 3 '() (make-bst 5 '() '())) 3) ; 1 child

; helper: find successor thing, not sure if this is
; different from imperative style like the book or if we need this
; BST ?? -> ???
(define (find-successor bst)
  0
  )


; ==========================================================

; VBST CONSTRUCTOR
(define (make-vbst root left right)
  (vector root left right)
  )

; VBST SELECTOR
(define (vbst-empty? vbst) (null? vbst))
(define (vbst-root vbst)(car vbst))
(define (vbst-left vbst)(cadr vbst))
(define (vbst-right vbst) (caddr vbst))


; imperative/vector style
(define (vbst-search bst val)
  0
  )
