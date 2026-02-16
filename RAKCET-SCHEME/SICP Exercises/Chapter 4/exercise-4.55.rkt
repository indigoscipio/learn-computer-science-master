#lang sicp

; Imperative
; How to do it
; Step by step
; square each 

; Declarative
; What is it?
; Describe it

; Normal programming languages
; the flow goes from input -> output

; Logic programing langauge (prolog)
; you describe what's true (the rules)
; and the systme tries to figure out all of the possibilities
; eg mostly filtering and gray out all of the possibilities

; Exercise 4.55

; give simple queries that retreive the following information from the data base

;1. all people supervised by Ben Bitdiddle
;2. the name & jobs of all people in the accounting division
;3. the names and addresses of all people who live in slumerville

;answer
;1. (supervisor ?x (Bitdiddle Ben))
;2. (job ?x (accounting . ?type))
;3. (address ?x (Slmmerville . ?type) )

; ======================