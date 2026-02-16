#lang racket

; A Leaf is the endpoint of a tree that holds a symbol and its weight
; make-leaf Symbol Number)
; interpretation: a leaf represents a symbol and its frequency (weight)
; Symbol Number -> Leaf
(define (make-leaf symbol weight)
  (list 'leaf symbol weight)
  )
(define leaf0 (make-leaf 'A 0))
(define leaf1 (make-leaf 'B 1))
(define leaf2 (make-leaf 'C 2))

; Any -> Boolean
; Checks if a given item is a leaf
(define (leaf? x)
  (eq? (car x) 'leaf)
  )

; Extracts the leaf's symobl
; Leaf -> Symbol
(define (symbol-leaf leaf)
  (cadr leaf)
  )
(symbol-leaf leaf0)

;Leaf -> Number
;extracts the leaf's weight
(define (weight-leaf leaf)
  (caddr leaf)
  )

; A Tree is one of the following
; A Leaf
; A List-of-[Tree Tree [List-of-Symbol] Number]
; a general tree combines two subtrees (left and right), a list of symbols inside the tree, and the total weight

; Tree -> Tree
; extracts the left branch of a tree
(define (left-branch tree)
  (car tree)
  )

; Tree -> Tree
; extracts the right branch of a tree
(define (right-branch tree)
  (cadr tree)
  )

; Tree -> (listof Symbol)
; Extracts the tree's symbols
(define (symbols tree)
  (cond [(leaf? tree) (list (symbol-leaf tree)) ]
        [else (caddr tree)])
  )

; Tree -> Number
; Extracts a tree's weight
(define (weight tree)
  (cond [(leaf? tree) (weight-leaf tree)]
        [else (cadddr tree) ])
  )



; Tree Tree -> Tree
; Creates a tree/internal node
(define (make-code-tree left right)
  (list left right (append (symbols left) (symbols right)) (+ (weight left) (weight right)))
  )
(define tree0 (make-code-tree leaf0 leaf1))
tree0


;choose a branch from a given bit
(define (choose-branch bit branch)
  (cond [(= bit 0) (left-branch branch)] ; otherwise go left
        [(= bit 1) (right-branch branch)] ; go right if bit = 1
        [else (error "bad bit: CHOOOSE-BRANCH" bit)]
        )
  )

; A Bit is number 1 or 0
; List-of-Bits Tree -> List-of-Symbols
(define (decode bits tree)
  ; List-of-Bits Tree -> List-of-Symbols
  (define (decode-1 bits current-branch)
    (cond [(empty? bits) '()]
          [else (let ((next-branch (choose-branch (car bits) current-branch) ))
                  (cond [(leaf? next-branch) (cons (symbol-leaf next-branch) (decode-1 (cdr bits) tree))] ; found, search next one from the bginning
                        [else (decode-1 (cdr bits) next-branch)] ; keep recursing until a leaf is found.
                        )
                  )])
    )
  (decode-1 bits tree)
  )
;(decode '(1 0 0 1 0 0 0) tree0)

; Tree List-of-Tree (Sorted) -> List-of-Tree (Sorted)
(define (adjoin-set x set)
  (cond [(empty? set) (list x)]
        [(< (weight x) (weight (car set))) (cons x set)]
        [else (cons (car set) (adjoin-set x (cdr set)) ) ])
  )

; List-of-Leafs -> List-of-Leafs (Ordered)
(define (make-leaf-set pairs)
  (cond [(empty? pairs) '()]
        [else (let ((pair (car pairs)))
                (adjoin-set (make-leaf (car pair) (cadr pair) )
                            (make-leaf-set (cdr pairs))
                            )
                )])
  )


(define sample-tre (make-code-tree))

