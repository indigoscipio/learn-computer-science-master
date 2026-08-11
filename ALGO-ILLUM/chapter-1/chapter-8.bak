#lang racket

; CHAPTER 7: GRAPHS

; G = (V,E)
; n = |V| -> vertices/nodes
; m = |E| -> edges
; parallel edge = 2/more edge that connect to same pair of vertices

; ==================================

; QUIZ 7.1
#|
Consider an undirected graph with n vertices and no parallel
edges. Assume that the graph is connected, meaning “in
one piece.” What are the minimum and maximum numbers
of edges, respectively, that the graph could have?

a) n-1 and n(n1)/2
b) n-1 and n^2
c) n and 2^n
d) n and n^n

answer:
my mathisshit but let me try to solve this intutively
so we have a undirected graph with n vertices
so at most each vertex can connect to the oter vertices
except for itself so thats n-1

so if we have 3 vertices
minimm edges should be 2
maximm edge should be like 3?
theyall need to be conected right?but they do like 'handskhake'
only 1 time

if we have 4 vercies
minimum forthem to connect each other is 3
and maximum islike 6

so it seems a is the answer here, n-1 and n(n-1)/2

------------

MINIMUM EDGE
n = island
0 bridge -> n seperate island
add 1 bridge -> n-1 seperate island

for all 'island' to be connected it needs at least n-1 edge
a tree is an example

MAXIMUM EDGE
- handshake
; p1 -> shakes hand with n-1 pepole
; p2 -> shakes hand with n-2 people

sum everything up
(n-1)+ (n-2) ... -> n (n-1) / 2

|#


; ==============================

; SPARSE VS DENSE GRAPHS
; sparse -> n
; dense -> n^2

; ==============================

#|
; ADJACENCY LISTS
; 2 arrays (vertex and edge array)
; vertex array -> master list of all nodes
; edge array -> master list of all connections
; EtoV pointers (edge 1 connects person A and person B)
; VtoE pointers (person A participates in edge A and edge B)

|#

; a Vertex is a symbol
; a Neighbours is a (listof Vertex)
; an Entry is a (list Vertex Neighbours)
; an Adjacency List is a (listof Entry)
; lets say a simple graph with vertices A, B, and C
(define adj-lst-graph '((A (B C))
                  (B (C))
                  (C ())
                  )
  )
adj-lst-graph

; get-neighbors:: Vertex Graph -> Neighbours
(define (get-neighbors v graph)
  (let ((result (assoc v graph)))
    (cadr result)
    )
  )
(get-neighbors 'A adj-lst-graph)

; add-edge:: Vertex Vertex Graph -> Vertex
(define (add-edge vertex value graph)
  (let ((result (assoc vertex graph)))
    (if result
        (map (λ (entry) (let ((v (car entry))
                              (neighbours (cadr entry)))
                          (if (equal? v vertex)
                              (list v (cons value neighbours)) ;update
                              entry ;keep
                              )
                          ) ) graph) ; add it!
        (error "Not found") ; not found
        )
    )
  )
(add-edge 'A 'D adj-lst-graph)
(add-edge 'B 'F adj-lst-graph)

; add-vertex:: Vertex Graph -> Vertex
; its backward but shuold be fine
; dont wanna spend time with append doesntmatter i think
(define (add-vertex v graph)
  (cons (list v '()) graph)
  )
(add-vertex 'D adj-lst-graph)

; has-edge:: Vertex Vertex
; checks if v2 is a neighbor of v1 within graph
(define (has-edge? v1 v2 graph)
  (let ((v1-neighbors (get-neighbors v1 graph)))
    (if (member v2 v1-neighbors) #t #f)
    )
  )
(has-edge? 'A 'C adj-lst-graph) ;#t
(has-edge? 'B 'C adj-lst-graph) ;#t
(has-edge? 'C 'X adj-lst-graph) ;#f


; ==============================
#|
Quiz 7.2
Howmuchspacedoestheadjacencylistrepresentationofa
graphrequire,asafunctionofthenumbernofverticesand
thenumbermofedges?

a. Big theta(n)
b. Big theta(m)
c. Big theta(m+n)
d. Big theta(n^2)

answer:
yeah idont think i understand the question here
it asks for how much space the adj list requires

since each vertex has like a neighbor
it depends on the amount of neighbour right?
each entry has vertex which can pair with lots of neighbour or even no
neighbour at all

so at most if we have 3 vertices
and each vertice can have at most 2 edges

so n = 3, m = 2
'((A (B C)) (B (A C)) (C (B A)))
so the total is like .. not sure here, 9 items?
or maybe it doesnt want me to find the total items
yeah not sure

PART 1 -> vertices (n)
if i have n vertices, store as entry
total vertices = n

PART 2 -> neighbours (m)
every single edge has atmost 2 connection
so shows up as neighbour twice (2m) -> m
each vertices have heighbor = 2 -> m


total = O(n + m)

|#

; =============================================

#|
ADJACENCY MATRIX


|#

;; Example 3x3 matrix graph:
;; Vertex 0 points to Vertex 1
;; Vertex 1 points to Vertex 2
;; Vertex 2 has no outgoing edges
(define sample-matrix
  '((0 1 0)   ; Row 0: connects to 1
    (0 0 1)   ; Row 1: connects to 2
    (0 0 0))) ; Row 2: connects to nothing

; m-has-edge? Integer Integer Graph -> Boolean 
(define (m-has-edge? u v graph)
  (let ((r (list-ref graph u)))
    (not (zero? (list-ref r v)))
    )
  )
(m-has-edge? 0 1 sample-matrix) ;#t
(m-has-edge? 1 2 sample-matrix) ;#t
(m-has-edge? 2 0 sample-matrix) ;#f

; m-get-neighbors:: Integer Graph -> listof Integer
(define (m-get-neighbors u graph)
  (let ((r (list-ref graph u) ))

 
    (define (loop xs i result)
      (cond [(null? xs) result] ;lets not reverse for simplicity
            [(equal? (car xs) 1) (loop (cdr xs) (+ i 1) (cons i result)) ]
            [else (loop (cdr xs) (+ i 1) result)]
            )
      )
    (loop r 0 '())
 

    #|
    ; FOR/LIST version
    (for/list ([i (in-range (length r))]
               #:when (= (list-ref r i) 1)
               )
      i
      )
    |#
    
    )
  )
(m-get-neighbors 1 sample-matrix)

;; m-add-edge: Integer Integer Graph -> Graph
(define (m-add-edge u v graph)
  (let ((row (list-ref graph u)))

    row
    
    )
  )
(m-add-edge 2 0 sample-matrix)


#|
Quiz 7.3
Howmuchspacedoes theadjacencymatrixof agraph
require,asafunctionofthenumbernofverticesandthe
numbermofedges?

a. big theta (n)
b. big theta (m)
c. big theta (m+n)
d. big theta (n^2)

answer:
lets say we have n=3 and m=3
for the adjancency matrix we'd have to construct
the rows and columns first right?

so thats 3.3 = 3^2 = 9 cells
and fill the cells

so thats like n^2? whichis more demanding than adjanceny list

|#

; =============================================

#|
problem 7.1
(S)LetG=(V,E)beanundirectedgraph. Bythe
degreeofavertex v E V,wemeanthenumberof edges inEthat
areincidenttov(i.e., thathavevasanendpoint).15Foreachofthe
followingconditionsonthegraphG, istheconditionsatisfiedonly
bydensegraphs,onlybysparsegraphs,orbybothsomesparseand
somedensegraphs?Asusual,n=|V|denotesthenumberofvertices.
Assumethatnislarge(say,atleast10,000).

a. at least one vertex of G has adegree at most 10
b. every vertex of g has degree at most 10
c. at least one vertex of G has degree n-1
d. every vertex of G has degree n-1

answer:
ok so we have a undirected graph G
and assume n is a large (10000)

letscheck one by one
a. at least one vertex of G has degree at most 10
if n is large then for sparse the minimum is n-1 right?
so 10000 - 1 = 9999

and atmost its like n(n-1) / 2 = 10000(9999) / 2 = 49,995,000
im not sure if this is even relevant

so we wanna find the degree thing
degree is number of edges that have v as the same endpoint

sparse test: pass
dense test: pass

b. only sparse
c. satisfies both
d. only dense graphs

__________________________________

Problem 7.2

(S)ConsideranundirectedgraphG=(V,E)thatis
representedasanadjacencymatrix.Givenavertexv2V,howmany
operationsarerequiredtoidentifytheedges incidenttov? (Letk
denotethenumberof suchedges. Asusual, nandmdenotethe
numberofverticesandedges, respectively.)

a. big theta(1)
b. big theta(k)
c. big theta(n)
d. big theta(m)

answer:
ok so we have an adjacency matrix
we wanna find the degree thing again
let k = total number of edges
n = vertex, m = edges

lets start simple, 2 vertices and 1 edge
total number edge is 1 -> k = 1
so if we have 2x2 adjacency matrix
the space is like 2^2

we wanna find the degree
walk through each col
check (0,0) -> true/false?
check (0,1)...

walk through each row
(1,0) -> ...
(1,1) -> ...

so thatslike.. just check that vertex (row)'s colun
so just do big theta(n)

__________________________________


Problem 7.3
Consider a directed graph G =(V,E) represented
with adjacency lists, with each vertex storing an array of its outgoing
edges (but not its incoming edges). Given a vertex v 2 V ,howmany
operations are required to identify the incoming edges of v? (Let k
denote the number of such edges. As usual, n and m denote the
number of vertices and edges, respectively).

a. big theta(1)
b. big theta(k)
c. big theta(n)
d. big theta(m)

answer:
ok so we have directed graph
each vertex stores array of outgoing edgess
so no duplicate like the one in directed graph

we wanna know how many operations requried to identify incoming
edges of v, where k = number of edges

n = vertices, m = edges

so if we have
'((A (B C)) (B (A C)) (C (A B)))
the neighbor only store outgoing edges instead of incoming
we wanne find incoming edges of A
thatmeans we have to travel to each vertex a -> b -> c
and check its neighbour, and for each of those check if
does it point back to a? something likethat maybe, notsure

O(m) -> check all of the edges 


|#