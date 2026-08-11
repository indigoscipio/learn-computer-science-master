#lang racket

; CHAPTER 14: NODE-BASED DATA STRUCTURES
; LINKED LISTS

; a Node is a Vector (Data Next-Index)
; where end of the list is -1

(define node0 (vector 'once 1))
(define node1 (vector 'upon 2))
(define node2 (vector 'a 3))
(define node3 (vector 'a -1))

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
; this is basically vector-ref right??
(define (read nodes target-index)
  (let ((n (- (vector-length nodes) 1) ))

    ; start at index 0, go next, go next
    ; helper needs curr index and steps left
    
    ; number -> number
    (define (read-helper i)
      (cond [(> i n) ]
            []
            )
      )

    (if (> target-index n)
        (error "Out of boundary")
        (read-helper 0)
        )
    
    )
  )
(read sample-nodes 0)

