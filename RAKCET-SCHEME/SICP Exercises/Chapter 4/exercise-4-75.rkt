#lang sicp

; Exercise 4.75
; Unique should succeed if there  is precisely one item in
; the data base satisfying a specified query.
(unique (job ?x (computer wizard)))
; should print the following one item strean
(unique (job (Bitdiddle Ben) (computer wizard)))