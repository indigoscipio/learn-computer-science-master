#lang racket

#|
BFS IMPLEMENTATION
|#

;; A Vertex is a Symbol (e.g., 'A, 'B, 'C)
;; An Adjacency-Entry is a (List Vertex (Listof Vertex))
;; A Graph is a (Listof Adjacency-Entry)


(define my-graph
  '((A (B C))
    (B (A D E))
    (C (A E))
    (D (B))
    (E (B C))))


; SELECTORS
; vertex graph -> list-of-vertex
(define (neighbors v graph)
  (second (assoc v graph))
  )

; graph vertex -> list-of-vertex
;; Performs a Breadth-First Search traversal starting from a node
(define (bfs graph start)
  ; list-of-vertex list-of-vertex
  ; build the list with cons on very iteration
  (define (bfs-helper queue visited)
    (cond [(null? queue) '()]
          [else (let* ((curr (car queue))
                      (rest-queue (cdr queue))
                      (all-neighbors (neighbors curr graph))
                      (new-neighbors (filter (λ (n) (not (member n visited)) ) all-neighbors) )
                      ;neighbors that hasn't been visited
                      )
                  (cons curr
                        (bfs-helper (append rest-queue new-neighbors) ; put new neighbor to basck back of queue
                                    (append visited new-neighbors) ;put new neighbor to visited
                                    )
                        )
                  )]
          )
    )

  ;; 1. Get neighbors that have NOT been visited yet
  ;; 2. Cons the current vertex onto the rest of the traversal
  ;; 3. Enqueue: Put new neighbors at the BACK of the queue
  ;; 4. Mark Visited: Add new neighbors to our visited list

  ; init
  ;; Start the search with the start node in the queue and visited list
  (bfs-helper (list start) (list start))
  )
(bfs my-graph 'A)


; CONNECTED COMPONENT
; how many isolated islands exist in an archipelago?

; DFS
; graph vertex -> list-of-vertex
(define (dfs graph start)
  (define (dfs-helper stack visited)
    (cond [(null? stack) '()]
          [else (let* ((curr (car stack))
                       (rest-stack (cdr stack))
                       (all-neighbors (neighbors curr graph))
                       (new-neighbors (filter (λ (n) (not (member n visited)) ) all-neighbors) )
                       ;neighbors that hasn't been visited
                       )
                  (cons curr
                        (dfs-helper (append new-neighbors rest-stack ) ; put new neighbor to basck back of queue
                                    (append new-neighbors visited ) ;put new neighbor to visited
                                    )
                        )
                  )]
          )
    )
  (dfs-helper (list start) (list start))
  )
(dfs my-graph 'A)

#|

|#

