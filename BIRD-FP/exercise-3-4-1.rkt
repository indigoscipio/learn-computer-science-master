#lang racket

#|
3.4.1
the function filter can be defined in terms of concat and map

filter p = concat . map box
where box x = ...

give definition of box

answer:
ok so on RHS we have 2 operations, map then concat
since its a map operation box must be a list

so box x = if x is true, return '(x), else return '()


-------

3.4.2 what is the type of (map map)

answer:
let see, map expects a proc and a list and returns a list that's transfomred
if we apply a map to that transformed list, that list will get transformed again

so outer map:: (a -> b) [a] -> [b]
inner map:: (c -> d) -> [c] -> [d]
and (map map):: (c -> d) [c] -> [d] -> ?? -> ??


;; Curried map in Scheme:
(define (map f)
  (lambda (xs)
    (if (null? xs)
        '()
        (cons (f (car xs))
              ((map f) (cdr xs))))))

;; Now you can do:
(map add1)           ;; Returns a function: [Num] -> [Num]
((map add1) '(1 2 3)) ;; Apply that function to a list

;; And this makes sense:
(map map)            ;; Returns a function: [(a->b)] -> [[a]->[b]]

|#

3.4.3
using reuls given in section 3.4 convert following expr into combinations of map filter and concat

3.4.4
consider the following two expr
