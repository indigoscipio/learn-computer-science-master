#lang racket

; DIJKSTRA'S SHORTEST PATH


; =======================

#|
QUIZ 9.1
Considerthefollowinginputtothesingle-sourceshortest
pathproblem,withstartingvertexsandwitheachedge
labeledwithitslength:

What are the shortest-pathdistances tos, v, w, and t,
respectively?
a) 0,1,2,3
b) 0,1,3,6
c) 0,1,4,6
d) 0,1,4,7

ANSWER:
ok so we have the source s 
s -> s is 0
s -> v 1
s -> w
this one we have 2 way either takes s -> v -> w which takes
1 + 2 = 3 or s -> w directly which is 4 so the shortest is
1+2 = 3

s -> t
we have multiple ways here
s -> v -> t = 1 + 6 = 7
s -> w -> t = 4 + 3 = 7
s -> v -> w -> t = 1+2+3 = 6

so should be 6
so the answer is 0,1,3,6


|#

; ============================
; versus BFS
; bfs counts the number of edges traversed
; reduction -> weighted graph to unweighted graph
; chop edge into 1 minig segments

; REDUCTION
; task A reduces to task B
; if i have a black box that solves B, i can use it to solve A
; problem B is the broader, more general (powerful) form of problem
; problem a -> find median
; problem b -> sort list of number
; if you can sort b, finding a just grab the middle.
; B is at least as hard as A (or even harder)
; B = more general
; A = more specific


; ============================


; dijkstra shortest path
; no path at all -> infinity?? not sure how thatworks in racke
; example: in graph where every edge has length 1,
; the length of a path is just number of edges in it
; the shortest path from a to v is one with min length among all paths

; Sample graph from Quiz 9.1
(define sample-graph
  '((s ((v 1) (w 4)))
    (v ((w 2) (t 6)))
    (w ((t 3)))
    (t ())))

; dijkstra:: Graph Vertex -> Association List
; X = like visited but its solved and locked in
; s = starting vertex
; V-X = remaining vertex
; v = conquered node (vertex inside set X)
; w = target node
; (v,w) = crossing bridge

; 1. visited/locked. s = 0, inf for the rest
; 2. look at all edges crossing from X to unvisited
; for each potential edge where v is locked and w unvisited,
; calculate candidate distance (dist to v + weight of edge (v,w))
; 3. pick single unvisited vertex that has smallest distance
; put into set x permanently and record distance
; 4. repeat until finished

(define (dijkstra graph v)

  ; conquered = (Listof (Cons Symbol Number))
  ; unvisited = (Listof Symbol)
  ; result = (Listof (Cons Symbol Number))
  (define (dijkstra-helper conquered unvisited result)
    (cond [(null? unvisited) conquered]
          [else (let* ((curr-node (car conquered))
                      (curr-v (car curr-node))
                      (curr-dist (cdr curr-node))
                      (candidates (filter (λ (x)
                                            (member (car x) unvisited)) graph) )
                      )
                  ; collect cand edges that cross from conq - unvisited
                  ; compute and compare
                  conquered
                  unvisited
                  candidates
                  )]
          )
    )
  (dijkstra-helper (list (cons (caar graph) 0) )
                   (cdr (map car graph))
                   '())


  )
(dijkstra sample-graph 's) ;'((s . 0) (v . 1) (w . 3) (t . 6))

