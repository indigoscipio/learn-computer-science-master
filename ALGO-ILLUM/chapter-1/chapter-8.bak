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
d. 2 and max{m,n}

answer:
ok so if we have 1 vertice and 0 edge
n=1
min = 1 connected
max = 1

n=2
min = 1 -> connect each node
max = 2 -> we can just split this in two right, like
two island but with no edge so m=0

n=3
min = 1 -> connect all nodes with each other
max = 3, with all 3 nodes having no connection at all?

n=4
min = 1 -> connect all nodes with each other
max = 4, asme as n=3?? so just four island/indiviudal dot with no edge

so the answer is b - 1 and n

|#

; ===================================

#|
; WHY USE CONNECTED COMPONENT
; 1. detect network failure
; everyone gets same power from center -> run search on graph
; if it find 1 connected component, entire grid is still running
; if it finds >= 1 connected component, grid is broken

; 2. data viz -> draw island with networks
; 3. clustering
|#

; ===================================

; 3 connected component
(define cc-sample-graph2 '((1 (3 5))
                           (3 (1 5))
                           (5 (1 3 7 9))
                           (7 (5))
                           (9 (5))
                           (2 (4))
                           (4 (2))
                           (6 (8 10))
                           (8 (6))
                           (10 (6))
                           )
  )

; UCC ALGORITHM (undirected connected components)
; give every single vertex an island number (cc) value
; vertices on the same 'island' gets same number
; vertices on different island gets different number

;; ucc:: Graph -> (listof (listof vertex))
; version 1: returns the list of list
(define (ucc graph)
  (define (ucc-helper unexplored explored components)
    (cond [(null? unexplored) components ] ; unexplored is empty
          [(member (car unexplored) explored)
           (ucc-helper (cdr unexplored) explored components) ] ; already explored
          [else (let* ((fst (car unexplored))
                       (bfs-result (bfs fst graph)))

                  (ucc-helper (cdr unexplored)
                              (append explored bfs-result)
                              (cons bfs-result components))
                  
                  )
                ]
          )
    )
  (ucc-helper (map car graph) '() '())  
  )
(ucc cc-sample-graph2) ;((1 3 5 7 9)(2 4)(6 8 10))

; ucc:: Graph -> listof Components
; a Component is a (cons Number NCC), where NCC is the 'island' number
; example: '((1 . 1)(3 . 1)(5 . 1)(2 . 2))
; version2 : association list
(define (ucc-v2 graph)
  (define (ucc-helper unexplored explored components ncc)
    (cond [(null? unexplored) components]
          [(member (car unexplored) explored)
           (ucc-helper (cdr unexplored) explored components ncc)]
          [else (let* ((fst (car unexplored))
                       (bfs-result (bfs fst graph))
                       (new-components (map (λ (c) (cons c ncc)) bfs-result) )
                       )
                  (ucc-helper (cdr unexplored)
                              (append explored bfs-result)
                              (append new-components components)
                              (+ 1 ncc) )
                  )]
          
          )
    )
  (ucc-helper (map car graph) '() '() 0)
  )
(ucc-v2 cc-sample-graph2)

; =======================================

#|
CORRECTNESS AND RUNNING TIME OF UCC
outer loop -> checks all vertices -> O(n)
inner loop -> basically bfs -> only called when vertex is unexplored
atmost inner loop is called a constant number of time
|#

; =======================================


; DEPTH FIRST SEARCH
(define dfs-sample-graph '((S (A B))
                           (A (C S))
                           (B (C D S))
                           (C (A B D E))
                           (D (B C E))
                           (E (C D))
                           )
  )


; dfs:: Vertex Graph -> listof Vertex
; iterative version
(define (dfs v graph)
  ; remaining is a stack
  ; list-of-vertex list-of-vertex -> listof vertex
  (define (dfs-helper remaining visited)
    (cond [(null? remaining) visited]
          [else (let* ((fst (car remaining))
                       (rst (cdr remaining))
                       (curr-neighbor (get-neighbors fst graph)))
                  (if (member fst visited)
                      ; skip
                      (dfs-helper rst visited)
                      ; add to stack
                      (dfs-helper
                       (append curr-neighbor rst)
                       (cons fst visited))
                      )
                  )]
          )
    )
  (dfs-helper (list v) '())
  )
(dfs 'A dfs-sample-graph)


; recursive implmeentation/version
; Vertex Graph -> listof Vertex
(define (dfs-recursive vertex graph)
  
  ; listof Vertex listof Vertex -> listof Vertex
  ; explores each neighbor one by one,
  ; udpates visited from each 'deep dive'
  (define (visit-neighbors neighbors visited)
    (cond [(null? neighbors) visited]
          [else (let* ((fst (car neighbors))
                      (updated-visited (visit-vertex fst visited))
                      ; updated-visited -> deep dive and keep exploring
                      )
                  (visit-neighbors (cdr neighbors) updated-visited)
                  )]
          )
    )
  
  ; Vertex Listof Vertex -> listof Vertex
  ; marks one vertex and gets its neighbor list
  (define (visit-vertex v visited)
    (cond [(member v visited) visited] ; seen -> backtrack
          ; vertex has no neighbor -> return as is/backtrack
          ; vertex has multiple neighbor -> visit each one
          [else (let ((curr-neighbor (get-neighbors v graph)))
                  ; mark v as visited, hand list of neighor and visited
                  ; to visit neighbors
                  (visit-neighbors curr-neighbor (cons v visited))
                  )]
          )
    )
  (visit-vertex vertex '())
  
  )
(dfs-recursive 'A dfs-sample-graph)

; =======================================================

#|
DFS RUNNING TIME
- never stops till it reaches 'dead end'
- O(m+n)
- n -> vertices. Initialze all rooms to unvisited and marks once
- m -> edges. looks atmost twice in undirected

|#

; =======================================================

; TOPOLOGICAL SORT
; cannot start some of the tasks until you have completed the others
; course in university degree program

#|
Quiz 8.3
Howmanydifferenttopologicalorderingsdoesthefollowing
graphhave?Useonlythelabels{1,2,3,4}.

a.0
b.1
c.2
d.3

answer:
so we have 2 path here
s -> v -> t
so the top path itmust first take s, v, then go to t
and the bottom path
s -> w -> t
must take s,w,t

so theres 2 orderingsr right??

; THE RULE
; goes from left to right ->
; A -> B -> C -> A
; is mathematically impossible
; points back to A again, breaks the '<' rule

; DAG
; is a graph that doesn't 'point back' at the beginning
- must have a source vertex (task with 0 prereq, at the beginning),
aka the origin
- find source -> rmove and delete outgoing arrow. next vertex
is the new source vertex.
- every step removes its 'source vertex'

example:
A -> B
C -> B

step 1: remove a
step 2: remove c
step 3: b

|#

; outer loop -> single dfs pass
; a label that keeps track where we are
; example: A -> B. a visits b. b has no neighbor. b finishes dfs first
; whoever finish first, cons into result

; Sample DAG representation
(define sample-dag
  '((s (v w))
    (v (t ))
    (w (t))
    (t ())))

; A graph with two completely disconnected parts:
; Component 1: A -> B
; Component 2: C -> D
(define sample-dag-2
  '((a (b))
    (b ())
    (c (d))
    (d ())))


; dfs-topo:: Vertex Graph Listof Vertex Listof Vertex -> ???
(define (dfs-topo vertex graph visited finished)
  
  ; listof Vertex listof Vertex -> listof Vertex
  ; explores each neighbor one by one,
  ; udpates visited from each 'deep dive'
  (define (visit-neighbors neighbors visited finished)
    (cond [(null? neighbors) (list visited finished)]
          [else (let* ((fst (car neighbors))
                       (res (visit-vertex fst visited finished))
                       (updated-visited (car res))
                       (updated-finished (cadr res)))
                  (visit-neighbors (cdr neighbors)
                                   updated-visited
                                   updated-finished)
                  )]
          )
    )
  
  ; Vertex Listof Vertex -> listof Vertex
  ; marks one vertex and gets its neighbor list
  (define (visit-vertex v visited finished)
    (cond [(member v visited) (list visited finished)]
          [else (let* ((curr-neighbor (get-neighbors v graph))
                       (res (visit-neighbors curr-neighbor
                                             (cons v visited)
                                             finished))
                       (new-finished (cadr res))
                       (new-visited (car res))
                       )
    
                  (list new-visited (cons v new-finished))
                  
                  )]
          )
    )
  (visit-vertex vertex visited finished)
  )
(dfs-topo 's sample-dag '() '())
(dfs-topo 'a sample-dag-2 '() '())

; X -> Z
; Y -> Z
(define sample-dag-3
  '((x (z))
    (y (z))
    (z ())))

(dfs-topo 'x sample-dag-3 '() '())

; toposort:: Graph -> Listof Vertex
; Given a DAG, returns a list of vertices in valid topological order.
(define (toposort graph)
  (define (toposort-helper remaining visited ordering)
    (cond [(null? remaining) ordering]
          [else (let ((fst (car remaining))
                      (rst (cdr remaining)))
                  (if (member fst visited)
                      (toposort-helper rst
                                       visited
                                       ordering)
                      ; call
                      (let* ((res (dfs-topo fst graph visited ordering))
                             (new-visited (car res))
                             (new-ordering (cadr res)))
                        (toposort-helper rst new-visited new-ordering)
                        )
                      )
                  
                  )]
          )
    )
  (toposort-helper (map car graph) '() '())
  )
(toposort sample-dag-2)

; ===============================================

#|
quiz 8.4

WhathappenswhentheTopoSortalgorithmisrunona
graphwithadirectedcycle?
a)Thealgorithmmightormightnotloopforever.
b)Thealgorithmalwaysloopsforever.
c)The algorithmalways halts, andmayormaynot
successfullycomputeatopologicalordering.
d)Thealgorithmalwayshalts, andnever successfully
computesatopologicalordering.
(SeeSection8.5.7forthesolutionanddiscussion.)

answer:
since we store visited if we see the same vertex again
it wont be visited right? so maybe it stops? not sure

DFS -> post-order processing
; on compleition (after all neighbors finish) (cons v new-finished)

d. algorithm always halts and never sucesfully computte
topological ordering

|#

; ===============================================


; STRONGLY CONNECTED COMPONENTS (SCC)
; scc is not acyclic - has a cyclic structure
; inside scc -> cyclic
; outside scc (zoom out) -> acyclic. shrink down scc = create DAG
