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

; ===============================================


; QUIZ 8.5
#|
Consideradirectedacyclicgraphwithnverticesandm
edges.Whataretheminimumandmaximumnumberof
stronglyconnectedcomponentsthatthegraphcouldhave,
respectively?

a) 1and 1
b) 1and n
c) 1and m
d) n and n

answer:
ok so we have a DAG with n vert and m edges
we wanna find min and max number of SCC the graph could have

scc is not acyclic right doesnt this like contradict?
DAG contains zero directed cycles

lets say n=2, m=1
minimum: if each node point to back to each other that counts right? so 1?
maximum: also 1


because  DAG contains 0 cycles, no two vertices can ever blong
to the same SCC. therefore every single vertex in DAG forms
its own individual SCC of size 1
so the answer is d. n and n

|#

; =================================================
#|Quiz8.6
LetGbeadirectedgraphandGrevacopyofGwiththe
directionofeveryedgereversed. HowaretheSCCsofG
andGrev related? (Chooseall thatapply.)

a) Ingeneral, theyareunrelated.
b)EverySCCofGisalsoanSCCofGrev,andconversely.
c)EverysourceSCCofGisalsoasourceSCCofGrev.
d)EverysinkSCCofGbecomesasourceSCCofGrev.

answer:
lets say we have G = A -> B -> C
so it has like 3 SCCs right
so GRev = C -> B -> A

yeah im not sure im seeing the relation here
they are both stil have the same SCC which is 3
in G , C is the 'sink' but hwne it reversed it becomes the 'source'
and vice versa with A

a is incorrect and c is not true since source in scc
when it reversed it becomes a sink
so B and D here i think is the answer??






|#
; =================================================


#|
KOSARAJU
upper -> component with only outgoing edges to other scc
middle -> component with both incoming and outgoing to other scc
sink -> component with only incoming edges

start with the sink lake C -> B -> A
f(v) = finishing time

how it works
1. g-rev: reversed graph
2. call DFS from every vertex of g-rev
3. call DFS from every vertex of g


|#

(define k-sample-graph '((1 (5))
                         (3 (1))
                         (5 (3))
                         (7 (4 5))
                         (11 (3))
                         (8 (9 10 11))
                         (6 (8 11))
                         (4 (2 9))
                         (2 (9))
                         (9 (5 7))
                         (10 (2 6))))


(define k-small-graph '((1 (2))
                        (2 (1 3))
                        (3 ())))


(define (flatten-node node)
  (map (λ (n) (cons (car node) n)) (cadr node))
  )
(flatten-node '(2 (1 3))) ;should return '((2 1) (2 3))

; Graph -> Graph
; given a graph, reverses it order/edges
; extract all directed pairs & convert
; into flat list '((2 (1 3))) -> '((2 1)(2 3))
; swap it (u v) -> (v u)
; group by source node that start with same node into (node (neighbors))
(define (reverse-graph graph)
  (let* ((flat-nodes (apply append (map flatten-node graph)))
         (reversed-flat-nodes (map (λ (pair) (cons (cdr pair) (car pair))) flat-nodes)))

    (map (λ (entry)
           (let ((v (car entry)))
             (list v (map cdr (filter (λ (pair)
                                        (equal? (car pair) v))
                                      reversed-flat-nodes))
                   )
             )) graph)
    
    )
  )
(reverse-graph k-small-graph) ; should return '((2 (1)) (1 (2)) (3 (2)) )

; Graph -> listof Vertex
(define (first-pass graph)
  (let ((g-rev (reverse-graph graph)))
    (toposort g-rev)
    )
  )

; Graph -> (listof (listof vertex))
(define (second-pass graph)
  ; pick next vertex v from first pass
  ; if visited -> skip
  ; else: run dfs -> collect -> mark as visited
  ; combine
  (let ((first-pass-result (first-pass graph)))
    ; (listof Vertex) (listof Vertex) -> (listof (listof Vertex))
    (define (second-pass-helper remaining visited result)
      (cond [(null? remaining) result]
            [else (let* ((fst (car remaining))
                         (rst (cdr remaining))
                         (curr-neighbor (get-neighbors fst graph)))
                    (if (member fst visited)
                        ; already visited, skip
                        (second-pass-helper rst visited result)
                        ; run dfs, collect, mark as visited
                        (let* ((dfs-result (dfs-topo fst graph visited '()))
                              (new-visited (car dfs-result))
                              (component (cadr dfs-result))
                              )
                          (second-pass-helper rst
                                              new-visited
                                              (cons component result))
                          )
                        )
                    )]
            )
      )
    (second-pass-helper first-pass-result '() '())
    )
  )
(second-pass k-small-graph) ; '((3 2 1) (3))

; kosaraju : Graph -> (listof (listof Vertex))
; Example Output: '((1 2) (3))
(define (kosaraju graph)
  (second-pass graph)
  )
(second-pass k-small-graph)
(kosaraju k-sample-graph)

; RUNNING TIME
; is a linear time O(m+n)
; first pass + reversal pass

; ==================================================

; THE WEB GRAPH
; 200 million vertices, 1.5 billion edges
; 28% percent composed of SCC

; ==================================================

#|
; TEST YOUR UNDERSTANDING
; PROBLEM 8.1
 (S) Which of the following statements hold? As
usual, n and m denote the number of vertices and edges, respec
tively, of a graph. (Choose all that apply.)

a) Breadth-first search can be used to compute the connected
components of an undirected graph in O(m+n) time.
b) Breadth-first search can be used to compute the lengths of
shortest paths from a starting vertex to every other vertex in
O(m+n)time, where “shortest” means having the fewest number
of edges.
c) Depth-first search can be used to compute the strongly connected
components of a directed graph in O(m+n) time.
d) Depth-first search can be used to compute a topological ordering
of a directed acyclic graph in O(m + n) time

answer:
lets analyze one by one
a. yeahim not sure about the running time here but bfs
checks each layers/neighbors first bu im gonna say its true
b. true
c. true
d. true

; ===================================================
Problem 8.2 (S) What is the running time of depth-first search, as
a function of n and m (the number of vertices and edges), if the input
graph is represented by an adjacency matrix (and NOT adjacency
lists)? You may assume the graph does not have parallel edges.

note: ⇥ is big theta
a) ⇥(m+n)
b) ⇥(m+nlogn)
c) ⇥(n2)
d) ⇥(m·n)

answer:
ok so we have a adjacency matrix data structure

since we are running dfs
it chcecks a vertex -> go in deep into its neighbor until empty
since its a matrix you have to like lookup the row and column

if we have
(define sample-matrix
  '((0 1 0)   ; Row 0: connects to 1
    (0 0 1)   ; Row 1: connects to 2
    (0 0 0)))

and run with dfs row 0 then it would just check
the columns right then move on to next one -> check other columns

for single row/vertex -> inspect all n columns if an edge exists
regardless of how many edges that vertex has
since dfs visits n vertices (rows), scanning all n column for eacch
n row means n . n = n^2

; ===================================================

8.3
This problem explores the relationship between two
definitions concerning graph distances. In this problem, we consider
only graphs that are undirected and connected. The diameter of
a graph is the maximum, over all choices of vertices v and w, of

the shortest-path distance between v and w.48 Next, for a vertex v,
let l(v) denote the maximum, over all vertices w, of the shortest-path
distance between v and w. The radius of a graph is the minimum
value of l(v), over all choices of the vertex v.

Which of the following inequalities relating the radius r to the
diameter d hold in every undirected connected graph? (Choose all
that apply.)

a.) r <= d/2
b) r <= d
c) r ≥ d/2
d) r ≥ d

answer:

; ===================================================

Problem 8.4 When does a directed graph have a unique topological
ordering?

a) Whenever it is directed acyclic.
b) Whenever it has a unique cycle.
c) Whenever it contains a directed path that visits every vertex
exactly once.
d) None of the other options are correct.

answer:
ok so we wanna find out when
directed graph have unique topological ordering

if iremmebr topoligcal is like based on orders
so something needs to be completed first in certain order left to right thing
and cannot go 'back' to the left

im not sure what unique topological ordering meanshere
they always have to make thing so clusterfuckingly complicated question
not sure


a. false
b. false i think a cycle breaks the topological meaning thing
c. true
d. false

; ===================================================

Problem 8.5 Consider running the TopoSort algorithm (Section 8.5)
on a directed graph G that is not directed acyclic. The algorithm will
not compute a topological ordering (as none exist). Does it compute
an ordering that minimizes the number of edges that travel backward
(Figure 8.20)? (Choose all that apply.)

a) The TopoSort algorithm always computes an ordering of the
vertices that minimizes the number of backward edges.
b) The TopoSort algorithm never computes an ordering of the
vertices that minimizes the number of backward edges.

c) There are examples in which the TopoSort algorithm computes
an ordering of the vertices that minimizes the number of back
ward edges, and also examples in which it doesn’t.
d) The TopoSort algorithm computes an ordering of the vertices
that minimizes the number of backward edges if and only if the
input graph is a directed cycle.
v 
s 
w 
t 
Figure 8.20: A graph with no topological ordering. In the ordering s, v,
w, t,theonlybackwardedgeis(t,s).


s = (v,w)
v = (t,w)
t = (s)
w = (t)

answer:
dfs choooses which neighbor arbitraryily
when it works -> 1 backward edge
when it fails -> unecessary backward edge

; ===================================================

8.6
Problem 8.6 If you add one new edge to a directed graph G,then
the number of strongly connected components...(Choose all that
apply.)

a) ...might or might not remain the same (depending on G and
the new edge).
b) ...cannot decrease.
c) ...cannot increase.
d) ...cannot decrease by more than 1.

answer:

if the vertices are like 1 way then
1 node is just counted as 1 scc right? depending on the edge

lets start simple example
if we have G =  (A -> B,  C)
so a points to b and c is island
all 3 is basically scc
and we wanna add 1 edge lets say B now poins to (A -> B -> C)
the scc count is still 3

A -> B -> C -> A
SCC = 1 so decrease of 2

a. true
b. false
c. true
d. false


; ===================================================

Problem 8.7 (S) Recall the Kosaraju algorithm from Section 8.6,
which uses two passes of depth-first search to compute the strongly
connected components of a directed graph. Which of the following
statements are true? (Choose all that apply.)

a) The algorithm would remain correct if it used breadth-first
search instead of depth-first search in both its passes.
b) The algorithm would remain correct if we used breadth-first
search instead of depth-first search in its first pass.
c) The algorithm would remain correct if we used breadth-first
search instead of depth-first search in its second pass.
d) The algorithm is not correct unless it uses depth-first search in
both its passes.

answer:
1st pass -> tracks finishing time
DFS can do this, with BFS the ordering is messed up

2nd pass ->  can be bfs or dfs
since the goal is to collect all reachable vertices
starting from top vertex of the pass 1 ordering

; ===================================================

Problem 8.8 (S) Recall that in the Kosaraju algorithm, the first
pass of depth-first search operates on the reversed version of the input
graph and the second on the original input graph. Which of the
following statements are true? (Choose all that apply.)

a) Thealgorithm would remain correct if in the first pass it assigned
vertex positions in increasing (rather than decreasing) order and
in the second pass considered the vertices in decreasing (rather
than increasing) order of vertex position.
b) The algorithm would remain correct if it used the original input
graph in its first pass and the reversed graph in its second pass.
c) The algorithm would remain correct if it used the original input
graph in both passes, provided in the first pass it assigned vertex
positions in increasing (rather than decreasing) order.
d) The algorithm would remain correct if it used the original input
graph in both passes, provided in the second pass it considered
the vertices in decreasing (rather than increasing) order of vertex
position.

answer:



|#