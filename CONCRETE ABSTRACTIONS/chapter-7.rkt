#lang racket



; LIST ADT
; a list is either:
; empty '()
; first item in the list and list of remaining item

#|
Exercise 7.1

You also can’t get the list (+ 2 3) by evaluating (list + 2 3)
a. What do you get if you evaluate that expression? Explain why.
b. What expression can you evaluate that will produce the list (+23),which starts
with the symbol +?

answer:
a. we'd get a list with the 1st item being the + procedure. so '(proc 2 3)
b. (list '+ 2 3)


|#
