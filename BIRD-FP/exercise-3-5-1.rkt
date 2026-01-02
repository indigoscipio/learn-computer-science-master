#lang racket

#|

⊕

3.5.1
Consider the function all which takes a predicate p and a list xs and 
returns True if all elements of xs satisfy p, and False otherwise. Give a 
formal definition of all which uses foldr.

answer:
ok so we have a function (all p xs) and returns true if all elements of xs satisfy p,
and false otherwise. so its kind of like andmap in scheme but it satisfied a predicate

so smal example
if we have [1,2,3,4]
and p = (even? n acc)
with the base case of #t
since te output is true/false the base case should also be boolean
it checks (p 4) -> (p 3 (#t (p 4))) -> until the end
(and (p 4) #t)
(and (p 3) (and (p 4) #t))
(and (p 2) (and (p 3) (and (p 4) #t)))
(and (p 1) (and (p 2) (and (p 3) (and (p 4) #t))))

all:: (a -> b) [a] -> boolean
all p xs = foldr (⊕) #true xs
where ⊕ = lambda x acc . (and (p x) acc)

======================================

3.5.2
which if any of the following equations are true?

1. foldl (-) x xs = x - sum xs
2. foldr (-) x xs = x - sum xs

answer:

lets analyze these with small examples
let xs = [1,2,3]
and the base case x = 0 since operation is subtraction

1. foldl -> (- (- (- 0 1) 2) 3) -> (- (- -1 2) 3) -> (- -3 3) -> -6
2. foldr -> (- 1 (- 2 (- 3 0))) -> (- 1 (- 2 3)) -> (- 1 -1) -> 0

and lets compare with the sum xs = 6, since we know the base case x = 0 just substitute
x - 6 = 0 - 6 = -6
so it seems the 1st statement, which is foldl is true but the 2nd one is not true

trying x = 10
foldl -> (- (- (- 10 1) 2) 3) = (- (- 9 2) 3) -> (- 7 3) -> 4
10 - 6 = 4 , still matches x - suum xs

mathemtically
(- (x - x1) x2) ...
 = x - (x1 + x2 + x3)


======================================


3.5.3 verify the equation

foldl (⊕) a (xs ++ ys) = foldl (⊕) (foldl (⊕) a xs) ys

using the fact that

reverse (xs ++ ys) = reverse ys ++ reverse xs

and one of the duality laws, derive a similar equation for foldr (⊕) a (xs ++ ys)

answer:

lets start with small example
let xs = [1,2]
let ys = [3,4]
and operation +
with base case of 0

LHS
foldl (⊕) a (xs ++ ys)
= foldl (+) 0 (1,2,3,4)
= (+ (+ (+ (+ 0 1) 2) 3) 4) -> (+ (+ (+ 1 2) 3) 4) -> ... -> 10

RHS
foldl (⊕) (foldl (⊕) a xs) ys
lets evaluate the base case first
(foldl (+) 0 xs)
= (+ (+ 0 1) 2) -> 3

foldl (+) 3 ys
= (+ (+ 3 3) 4) -> ... -> 10

therefore the two sides are equal
so in the LHS it just process the whole list and get the sum from xs to ys
but in RHS it gets the sum from xs first, then use that as the base case to fold function for ys list

foldl is incremental and can pause calculation after xs
foldl (⊕) a reverse ys = foldr (⊕) a ys
foldr (⊕) (foldr (⊕) a ys) xs

foldl (⊕) (foldl (⊕) a xs) ys -> process xs first then use that result as base case for outer foldl
foldr (⊕) (foldr (⊕) a ys) xs -> process ys first then use that result as base case for outer foldr

======================================

3.5.4
consider the following definition of a function insert:

insert x xs = takewhile(<=x) xs ++ [x] ++ dropwhile (<= x) xs
show that if xs is a list in nondecreasing order, then so is (insert x xs)
using insert, define a function isort for sorting a list into non-decreasing order

answer:
lets start with small example
since xs is a list in nondecreasing order,
xs = [1,2,3]
and x = 4

RHS
takewhile (<=x) xs ++ [x] ++ dropwhile (<= x) xs

1st item = 1
= takewhile (<=x) xs ++ [4] ++ dropwhile (<= x) xs
since 1 <= 4 its [1] ++ [4] ++ [2,3]

2
since 2 <= 4 its [1,2] ++ [4] ++ [3,4]

3
since 3 <= 4 its [1,2,3] ++ [4] ++ []

final result = [1,2,3,4]

so insert its basically like sorted insert


|#

; insert: a [a] -> [a]
; given an item x and a sorted list xs,
; inserts x into its correct order
(define (insert x xs)
  ; base case: list is empty, just put x into xs
  ; case 1: x <= (car xs), put it on the left
  ; case 2: x > (car xs), put it on the right
  ; else build the list
  (cond [(null? xs) (list x)]
        [(<= x (car xs)) (cons x xs) ]
        [else (cons (car xs) (insert x (cdr xs))) ]
        )
  )

; isort: xs -> xs
(define (isort xs)
  (foldr (λ (x acc) (insert x acc) ) '() xs)
  )
;(isort '(5 3 4 -10 -89 88))

; (insert 88 '())
; (insert -89 (insert 88 '()))
; (insert -10 (insert -89 (insert 88 '())))
; (insert 4 (insert -10 (insert -89 (insert 88 '()))))
; (insert 3 (insert 4 (insert -10 (insert -89 (insert 88 '())))))
; (insert 5 (insert 3 (insert 4 (insert -10 (insert -89 (insert 88 '()))))))
; (insert 5 (insert 3 (insert 4 (insert -10 (insert -89 '(88) )))))
; (insert 5 (insert 3 (insert 4 (insert -10 (-89 88)))))
; (insert 5 (insert 3 (insert 4 '(-89 -10 88) )))
; (insert 5 (insert 3 '(-89 -10 4 88) ))
; (insert 5 '(-89 -10 3 4 88) )
; '(-89 -10 3 4 5 88)

 
#|

3.5.5
The function remdups removes adjacent duplicates from a list. For ex
ample, remdups [1, 2, 2, 3,3,3, 1, 1] = [1, 2, 3, 1]. Define remdups using either 
foldl or foldr.

|#

; remdups: xs -> xs
; given a list xs, removes adjacent duplicate from the list
(define (remdups xs)
  (foldr (λ (x acc) (if (null? acc)
                        (cons x acc)
                        (cond [(= x (car acc)) acc] ; skip it
                              [else (cons x acc)] ;put it in front
                              )
                        ) ) '() xs)
  ;with foldr, check if x = ????, if so don't cons it
  )
(remdups '()) ; no duplicates found just return '()
(remdups '(1 2 2)) ; '(1 2)
(remdups '(3 3 3 2 3)) ; '(3 2 3)

; small trace
; (? 1 (? 2 (2 '()) ) )
; the operator ? compares if theyre equal