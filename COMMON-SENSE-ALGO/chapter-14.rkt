#lang racket

; CHAPTER 14: NODE-BASED DATA STRUCTURES
; LINKED LISTS

; a Node is a Vector (Data Next-Index)
; where end of the list is -1

(define node0 (vector 'once 1))
(define node1 (vector 'upon 2))
(define node2 (vector 'a 3))
(define node3 (vector 'time -1))

(define sample-nodes (vector node0 node1 node2 node3))

; SELECTORS
(define (node-data node)
  (vector-ref node 0)
  )

(define (node-next node)
  (vector-ref node 1)
  )

; CORE FUNCTIONS
; read:: Node Number -> Number
(define (read nodes target-index)
  (let ((n (- (vector-length nodes) 1) ))

    ; start at index 0, go next, go next
    ; helper needs curr index and steps left
    
    ; number -> number
    ; physical location does not equal position in seq
    (define (read-helper i steps-left)
      (cond [(zero? steps-left) (node-data (vector-ref nodes i)) ]
            [else (let* ((curr-node (vector-ref nodes i))
                         (next-index (node-next curr-node)))
                    (read-helper next-index (- steps-left 1))
                    )]
            )
      )

    (if (> target-index n)
        (error "Out of boundary")
        (read-helper 0 target-index)
        )
    
    )
  )
(read sample-nodes 3)

; ========================================


(define node-a    (vector 'a 2))     ; Slot 0 -> points to Slot 2
(define node-once (vector 'once 3))  ; Slot 1 (HEAD) -> points to Slot 3
(define node-time (vector 'time -1)) ; Slot 2 -> end of list (-1)
(define node-upon (vector 'upon 0))  ; Slot 3 -> points to Slot 0
(define scrambled-nodes (vector node-a node-once node-time node-upon))

; search:: Node Number -> Number
(define (search nodes head-idx value)
  ; logical position (list index)
  ; memory position (actual box number)
  (define (search-helper mem-idx lst-idx)
    (cond [(equal? mem-idx -1) #f] ; not found??
          [else (let* ((curr-node (vector-ref nodes mem-idx))
                       (next-index (node-next curr-node))
                       (curr-value (node-data curr-node))
                       )
                  (if (equal? curr-value value)
                      lst-idx
                      (search-helper next-index (+ lst-idx 1))
                      )
                  )]
          )
    )
  (search-helper head-idx 0)
  )
(search scrambled-nodes 1 'once)


; ========================================

; LL insertion best case: O(1) -> insert at front of the list
; LL insertion worst case: O(n) -> insert at the end (has to traverse each item)
; opposite of array

; insert:: Node Number -> Node
(define (insert index value nodes head-idx)
  (let ((n (- (vector-length nodes) 1)) )
    (define (insert-helper mem-idx lst-idx)
      (cond [(= mem-idx -1) #f] ;index not found 
            [else (let* ((curr-node (vector-ref nodes mem-idx))
                         (next-idx (node-next curr-node)))
                    (if (= lst-idx (- index 1))
                        (let ((new-node (vector value next-idx))
                              (new-curr-node (vector (node-data curr-node)
                                                     (vector-length nodes)))
                              )
                          (vector-set! nodes mem-idx new-curr-node)
                          (vector-append nodes (vector new-node))

                          )
                        (insert-helper next-idx (+ 1 lst-idx))
                        )
                    )]
            )
      )

    (if (= index 0)
        (let ((updated-nodes (vector-append nodes (vector (vector value head-idx)))))
          updated-nodes )
        (if (> index n)
            (error "Out of bound")
            (insert-helper head-idx 0) )
        
        )
    )
  
  )
scrambled-nodes
;(insert 1 'hello scrambled-nodes 1) ;insert 'hello at index 0


; ========================================

; delete:: Number Nodes Number -> (Pair New-Head-Index Updated-Nodes)
(define (delete target-index nodes head-idx)
  (let ((n (- (vector-length nodes) 1)))

    (define (delete-helper mem-idx lst-idx)
      (cond [(= mem-idx -1) #f] ;not found? doineed this guard
            [else (let* ((curr-node (vector-ref nodes mem-idx))
                         (next-idx (node-next curr-node)))

                    (if (= lst-idx (- target-index 1))
                        ; delete it.
                        ; curr-node is predecessor
                        ; next-idx is the thing we wanna delete
                        ; find next-next-idx
                        (let* ((next-node (vector-ref nodes next-idx))
                               (next-next-idx (node-next next-node))
                               (new-curr-node (vector ... ...))
                               (new-next-next-node (vector ... ...))
                               )
                          ...
                          )
                        (delete-helper next-idx (+ lst-idx 1)); keep searching
                        )

                    )]
            )
      )

    (if (zero? target-index)
        (let ((head-node (vector-ref nodes head-idx)))
          (cons (node-next head-node) nodes)
          )
        (if (> target-index n)
            (error "Out of bound")
            (delete-helper head-idx 0)            
            )
        )
    
    )
  )
(delete 1 scrambled-nodes 1) ; delete 'a