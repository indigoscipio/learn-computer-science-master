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




|#