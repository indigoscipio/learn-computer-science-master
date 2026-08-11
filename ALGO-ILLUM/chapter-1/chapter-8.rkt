#lang racket

; CHAPTER 8
; GRAPH SEARCH AND ITS APPLICATIONS

; why search graph is important?
; find everything 'reachable' from the starting point
; avoid getting stuck in 'infinite' loop
; types : BFS vs DFS

; vertices dont have to be a number of physical location
; they can represent a state

; SAMPLE GRAPH
(define adj-lst-graph '((A (B C))
                  (B (C))
                  (C ())
                  )
  )
adj-lst-graph

(define adj-lst-graph2 '((S (U V))
                  (U (S V W))
                  (V (S U W))
                  (W (U V))
                  (X (Y))
                  (Z ())
                  )
  )

; HELPER FUNCTIONS
; get-neighbors:: Vertex Graph -> Neighbours
(define (get-neighbors v graph)
  (let ((result (assoc v graph)))
    (cadr result)
    )
  )

; has-edge:: Vertex Vertex
; checks if v2 is a neighbor of v1 within graph
(define (has-edge? v1 v2 graph)
  (let ((v1-neighbors (get-neighbors v1 graph)))
    (if (member v2 v1-neighbors) #t #f)
    )
  )

; GENERIC SEARCH
; Vertex Graph -> listof Vertex
#|
When you start the algorithm at a single vertex s
(before looking at any edges or neighbors):
What should be inside your Explored list at the very beginning?
What should be inside your To-Explore list at the very beginning?
|#
(define (generic-search v graph)

  ; visited (explored) = vertices already procesed (acc)
  ; remaining = vertices discovered, but haven't explored
  (define (gs-helper remaining visited)
    (cond [(null? remaining) visited] ;no more vertices
          [else (let* ((fst (car remaining))
                       (rst (cdr remaining))
                       (curr-neighbor (get-neighbors fst graph)))
                  (if (member fst visited)
                      (gs-helper rst visited)
                      (gs-helper (append rst curr-neighbor)
                                 (cons fst visited))                      
                      )
                  )]
          ; if fst is in visited -> leave it
          ; if its not in visited -> add it, but remove fst (since we already see it)
          )
    )
  (gs-helper (list v) '())
  
  )
(generic-search 'A adj-lst-graph)


; =========================================

; BFS
; the 'ripple' strategy
; layer 0 -> start
; layer 1 -> every room 1 door away
; layer 2 -> every room 2 doors away, etc
; expand layer

; DFS
; keep going till hit a dead end
; then backtrack to most recent intersection with unexplored door
; and explore that path

; =========================================



#|
QUIZ 8.1
Consideranundirectedgraphwithn≥2vertices.What
aretheminimumandmaximumnumberofdifferentlayers
thatthegraphcouldhave, respectively?

a. 1 and n-1
b. 2 and n-2
c. 1 and n
d. 2 and n

answer:
ok so we have undirected graph with n>=2 vertices
we wanna find minimum and maximum number of different layers
the graph could have

so lets say n = 2
minimum: we need atleast 1 layer right to explore?
unless if the graph isn't connected? so 0 layer but still 1 layer
maximum: also 1 here??

n = 3
minimum: 1 layer i think
maximum: if the 3 vertices i think if we have
a b c with a connects b and b connects c
then we'd need atleast 2 layers here right

n = 4
minimum: 2 - a directly connects b,c,d
maximum: 4 - a straight path

so minimum = 2, maximum = n

|#

(define (bfs v graph)
  (define (bfs-helper queue visited)
    (cond [(null? queue) visited]
          [else (let* ((fst (car queue))
                      (rst (cdr queue))
                      (curr-neighbor (get-neighbors fst graph))
                      )
                  (if (member fst visited)
                      (bfs-helper rst visited) ; already visited
                      (bfs-helper (append (cdr queue) curr-neighbor) (cons fst visited))
                      ; add to visited
                      )
                  )]
          )
    )
  (bfs-helper (list v) '())
  )
(bfs 'A adj-lst-graph)

; ================================================

; process layer by layer
; BFS RUNNING TIME
; O(m+n)
; NODE COST: N
; each node gets 'stamped' -> move to 'visited'
; each enter and leaves once

; EDGE COST: M
; for each node (car visited), checks for its neighbor
; at most  each edge gets looked twice (goes both ways)
; in undirected graph so 2M = M

; ================================================

; SHORTEST PATH
; AUGMENTED BFS

; Vertex Graph -> listof (cons Vertex Distance)
; i need to know how many hops it took to reach each vertex
; How can you use assoc to check if fst-v is already
; recorded in visited, and how can you transform curr-neighbor
; into pairs of (cons neighbor (+ fst-d 1)) to append to rst-pair?
(define (shortest-path-bfs v graph)
  ; a Queue is a list of pairs (cons Vertex Distance)
  ; a Visited is a list of pairs (cons Vertex Distance)
  (define (bfs-helper queue visited)
    (cond [(null? queue) visited]
          [else (let* ((fst-queue (car queue))
                       (rst-queue (cdr queue))
                       (fst-v (car fst-queue))
                       (fst-d (cdr fst-queue))
                       (curr-neighbor (get-neighbors fst-v graph))
                       (new-visited (cons (cons fst-v fst-d) visited))
                       (new-queue (map (λ (n) (cons n (+ 1 fst-d))) curr-neighbor))
                       )

                  (if (assoc fst-v visited)
                      ; skip it
                      (bfs-helper rst-queue visited)
                      ; add it
                      (bfs-helper (append rst-queue new-queue) new-visited)
                      )
                  )]
          )
    )
  (bfs-helper (list (cons v 0)) '())
  )
(shortest-path-bfs 'A adj-lst-graph)

; ===================================

; CONNECTED COMPONENTS

#|
QUIZ 8.2

Consideranundirectedgraphwithnverticesandmedges.
Whataretheminimumandmaximumnumberofconnected
componentsthatthegraphcouldhave, respectively?

a. 1 and n-1
b. 1 and n
c. 1 and max{m,n}

|#