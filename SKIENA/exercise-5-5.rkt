#lang racket

; CHROMATIC GRAPH

; graph -> integer
; alternatig 2 colors
; even cycles
; odd needs 3 colors

; traverse graph
; assign alternating colors
; detect conflicts
; determine output
; not rquired to be bipartite, we can have odd cycles

'((A (B)) (B (A C)) (C (B))) ; 2