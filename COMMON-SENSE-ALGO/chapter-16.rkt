#lang racket

 (require data/heap)

(define a-heap-of-strings (make-heap string<=?) )

(heap-add! a-heap-of-strings "z" "b")
(heap->vector a-heap-of-strings)


; priority queue -> just like queue
; example: severity ranking in ER
; constraints:
; 1. when we insert data, maintain proper order
; 2. data can be removed from the end
; weakness is the O(n) adding stuff


; HEAPS
; binary heap (binary tree)
; max heap, min heap

; COND1:
; - value of each node must be greater than each of its descendant
; - also known as 'heap condition'.
; - absolute max value sits at the top
; - compared to bst (horizontal data order), heaps order data vertically

; COND2: tree must be complete.
; - the tree must be completely filled with nodes
; - fill higher row first (cant put in row 3 till 1&2 are full)
; - only the bottom row can have empty positions
; - left to right only

; HEAP INSERTION O(n)
; 1. insert at rightmost spot in the bottom level
; (this will be the new last node)
; 2. compare it with its parent node
; 3. if greater -> swap. else keep
; 4. repeat until it 'bubbles' up and in correct position
; (also called 'trickling' the node up)

; SEARCH LAST NODE
; why is heap dependant on last node?
; why is heap dependant on complete tree?
; because it ensures the heap remains well balanced.
; it ensures O(log n) running time
; 1.

; HEAP DELETION
; only ever delete the root node!
; 1. mode last node to root node (remove original root node)
; 2. trickle root node down:
; 2a. checkb oth children see which one is larger
; 2b. if trickle node < larger of the 2 nodes, swap it with the larger
; 2c. repeat until tricle node has no children who are greater than it.

; RUNNING TIME
; HEAP INSERTION: O(log n)
; HEAP DELETION: O(log n)

; ===============================================

; a Heap is a BT
; a BT is a (listof Value Left Right) or '()
; where Left and Right is a BT

; CONSTRUCTOR
(define (make-heap value left right) (list value left right))

; SELECTORS

; OP: HEAP INSERTION

; OP: SEARCH LAST NODE

; OP: HEAP DELETION

