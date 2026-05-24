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


(define (inorder tree)
    (if (empty-tree? tree)
        '()
        (append (inorder (left-subtree tree))
                (cons (root tree)
                (inorder (right-subtree tree))))))

; ==========================================================


#|
Exercise 8.4
Again, eliminate append by using an “onto” parameter
|#


(define (inorder-onto tree lst)
  ; lst is the accumulator
  (cond [(empty-tree? tree) lst]
        [else (inorder-onto (left-subtree tree) (cons (root tree) (inorder-onto (right-subtree tree) lst)) )]
        )
  )
(inorder-onto sample-bst '())


; ==========================================================


#|
Exercise 8.5
The third standard way of traversing a tree is called a postorder traversal. Here, you
enumerate the left subtree, then the right subtree, and finally the root. Write a
procedure that takes a binary search tree and produces the list of nodes that describe
a postorder traversal of the tree.
|#

(define (postorder tree)
  ;rebuild the tree on each iteratio
  (cond [(empty-tree? tree) '()]
        [else (append (postorder (left-subtree tree))
                      (postorder (right-subtree tree))
                      (list (root tree))
                      ) ] ; L -> R -> C
        )
  )
(postorder sample-bst) ;(1 3 2 5 7 6 4)

(define (postorder-onto tree lst)
  (cond [(empty-tree? tree) lst]
        [else (postorder-onto (left-subtree tree) (postorder-onto (right-subtree tree) (cons (root tree) lst) ) ) ])
  )
(postorder-onto sample-bst '())

; ==========================================================

#|
Exercise 8.6
Suppose we want to create a new binary search tree by adding another element to
an already existing binary search tree. Where is the easiest place to add such an
element? Write a procedure called insert that takes a number and a binary search
tree of numbers and returns a new binary search tree whose elements consist of the
given number together with all of the elements of the binary search tree. You may
assume that the given number isn’t already in the tree.
|#


(define (insert n tree)
  ;is root empty? insert it with make-nonempty-tree
  ;is curr root < n? traverse left
  ;is root > n? traverse right
  (cond [(empty-tree? tree) (make-nonempty-tree n '() '()) ]
        [(> n (root tree)) (make-nonempty-tree (root tree) (left-subtree tree) (insert n (right-subtree tree))) ]
        [else (make-nonempty-tree (root tree) (insert n (left-subtree tree)) (right-subtree tree))]
        )
  )
(insert 100 sample-bst)

; ==========================================================

#|
Exercise 8.7
Using the procedure insert, write a procedure called list->bstree that takes a
list of numbers and returns a binary tree whose elements are those numbers. Try this
on several different lists and draw the corresponding tree diagrams. What kind of list
gives you a short bushy tree? What kind of list gives a tall skinny tree?

;im guessing 'bushy' is where the numebrs are evenly distrubuted (maybe even randomt)
; and the tall skinny is when it's weighted/ balanced on one side (like sorted) maybe
|#

; list-of-number -> BST
(define (list->bstree lon)
  (cond [(empty? lon) (make-empty-tree)] ;no more number in the list, done 
        [else (insert (car lon) (list->bstree (cdr lon)) )]
        )
  )
(list->bstree '(1 2 3))


#|
tree having single node -> depth = 0
emptty tree -> depth undefined
assume all trees are nonempty
Exercise 8.8
Write a predicate that will return true if the root node of a tree is a leaf (i.e., the tree
has only one node).
|#

(define (is-leaf? tree)
  ; a tree is a leaf it its childrens left subtree is empty and its right subtree is empty
  (and (empty-tree? (left-subtree tree))
       (empty-tree? (right-subtree tree))
       )
  )

#|
Exercise 8.9
Write a procedure that will compute the height of a tree.
|#

(define (tree-height tree)
  ; base case: tree is a leaf, return 0
  (cond [(is-leaf? tree) 0]
        [else (+ 1 (max (tree-height (left-subtree tree)) (tree-height (right-subtree tree))) )  ]
        )
  )
(tree-height sample-bst)