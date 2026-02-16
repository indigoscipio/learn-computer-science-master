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
;(symbol-leaf leaf0)

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

; Tree List-of-Tree (Sorted) -> List-of-Tree (Sorted)
(define (adjoin-set x set)
  (cond [(empty? set) (list x)]
        [(< (weight x) (weight (car set))) (cons x set)]
        [else (cons (car set) (adjoin-set x (cdr set)) ) ])
  )

; List-of-[Symbol Weight Pair] -> List-of-Leafs (Ordered)
(define (make-leaf-set pairs)
  (cond [(empty? pairs) '()]
        [else (let ((pair (car pairs)))
                (adjoin-set (make-leaf (car pair) (cadr pair) )
                            (make-leaf-set (cdr pairs))
                            )
                )])
  )

;exercise 2.67
(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree
                    (make-leaf 'D 1)
                    (make-leaf 'C 1)))))
(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))
(define sample-message2 '(A D A B B C A))
;(decode sample-message sample-tree)


;exercise 2.68

; A Message is a List of Symbols

; Symbol Tree -> List-of-Bits
(define (encode-symbol symbol tree)
  ;Symbol Tree -> List-of-Bits
  ; Helper function for encode, builds up a list of bit on each iteration
  (define (encode-1 symbol current-branch)
    (cond [(empty? current-branch) (error "Current tree is empty")]
          [(and (leaf? current-branch) (equal? (symbol-leaf current-branch) symbol))  '()] ;base case: current branch is a leaf, return empty '()
          [else (let ((left (left-branch current-branch))
                      (right (right-branch current-branch))
                      )
                  (cond [(member symbol (symbols left)) (cons 0 (encode-1 symbol left))]
                        [(member symbol (symbols right)) (cons 1 (encode-1 symbol right)) ]
                        [else (error "Symbol not found")]
                        )
                  )] ;else handle an internal node
          )
    )
  (encode-1 symbol tree)
  )
;(encode-symbol 'E sample-tree)

; List-of-Symbols Tree -> List-of-Bits
(define (encode message tree)
  (cond [(empty? message) '()]
        [else (append (encode-symbol (car message) tree)
                      (encode (cdr message) tree))])
  )

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs) )
  )

; List-of-leafs -> Tree
(define (successive-merge pairs)
  ; define a smallest weight (car pairs)
  ; merge the next smallest one and add the total weight
  (cond [(empty? (cdr pairs)) (car pairs)] ; base case: if there's one node left, return th result
        [else (let* ((first-el (car pairs))
                     (second-el (cadr pairs))
                     (rest-els (cdr (cdr pairs)))
                     (new-tree (make-code-tree first-el
                                               second-el))
                     (new-pairs (adjoin-set new-tree rest-els))
                     )
                (successive-merge new-pairs)
               )]
       )
  )
(successive-merge (list (make-leaf 'A 1) (make-leaf 'B 2) (make-leaf 'C 3)))