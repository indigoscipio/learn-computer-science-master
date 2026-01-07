#lang racket

#|
3.6.1 In how many ways can [1 . . n] be expressed as the concatenation of 
two non-empty lists?

answer:
small example, lets say the list is [1,2,3,4]
so it has 4 items

we can do
1. [1] ++ [2,3,4]
2. [1,2] ++ [3,4]
3. [1,2,3] ++ [4]

so thats 4-1 = 3 ways to represent concatenantion with nonemopty list

generally
first. [1] ++ [..n]
middle. whatever in-between values which can range
last. [1,2,..] ++ [n]

therefore we can define this as n-1 ways to split two non-empty lists

=================================================
(cons 1 2) since 2 is not a list it will return a pair
(cons 1 '(2)) this returns a list of '(1 2)
=================================================



3.6.2
which of the following equations are true?

1. [] : xs = xs
2. [] : xs [[], xs]
3. xs : [] = xs
4. xs : [] = [xs]
5. x : y = [x,y]
6. (x : xs) ++ ys = x : (xs ++ ys)

answer:
1. [] : xs = xs
ok so this one we want to cons an empty list with a non empty list
(cons '() '(1 2 3)) this one should return (() 1 2 3) with the empty list appended to the front and the cdr is xs
so the answer is false, it should be [[],xs]

2. [] : xs [[], xs]
same as previous answer, we know that this returns a new list with all elements of xs as cdr
(cons '() '(1 2  3)) should return '(() 1 2 3)
this one represents a list with just 2 elemnt: one an empty list and 2nd one a list of item
like '(() '(1 2 3)) so its incorrect it should be '(() 1 2 3)

3. xs : [] = xs
ok so this want its performing a cons operation with a list of item with an empty list
so its like (cons '(1 2 3) '()) this one should return '((1 2 3)) which is the same as [xs]
therefore its incorrect

4. xs : [] = [xs]
this one is the same as 3, it performs cons with xs and empty list
so (cons '(1 2 3) '()) should return '((1 2 3)) or [xs] so this one is correct

5. x : y = [x,y]
this performs cons operation with x and y
since y is one element it is invalid

6. (x : xs) ++ ys = x : (xs ++ ys)
let x = a, xs = '(b c), ys = '(1 2 3)
LHS
(cons a '(b c)) => '(a b c)
'(a b c) ++ '(1 2 3) =>
'(a b c 1 2 3)

RHS
x : (xs ++ ys)
(cons a '(b c 1 2 3)) =>
'(a b c 1 2 3)

therefore this is correct,
basically in LHS you append x + xs with ys
and in RHS you append only x (first of xs) with xs and ys concatted

============================

3.6.3
Using pattern matching with (:), define a function rev2 that reverses 
all lists of length 2, but leaves others unchanged. Ensure that the patterns 
are exhaustive and disjoint.

|#

; empty
; exactly one item
; exactly 2 item
; 3 or more item
(define (rev2 xs)
  ; a list has 2 element if its:
  ; not empty
  ; does not have 1 item
  ; does not have 3 or more item
  (cond [(and (pair? xs)
              (pair? (cdr xs))
              (null? (cddr xs))) (list (cadr xs) (car xs))]
        [else xs])
  )
;(pair? '(1))
;(pair? '(1 2))
;(null? (cddr '(1 2)))
;(cdr '(1 2))
;(cddr '(1 2))
;(pair? '(1 2 3))


; ============================

#|
3.6.4
Consider the function insert of Exercise 3.5.4. Another way to define 
insert is in terms of a function swap:

insert x = foldr swap [x]

The function (swap x) applied to a non-empty list xs adds x as either the 
first or second element. Using pattern matching, give a definition of swap. 
Estimate the cost of sorting by this method. 

|#


(define (swap x xs)
    (cond [(null? xs) (list x)]
          [(> x (car xs)) (cons (car xs) (cons x (cdr xs)))]
          [else (cons x xs)])

  )
(swap 2 '(1 3 5)) ; '(1 2 3 5)
(swap 1 '()) ; '(1)
(swap 0 '(1 2 3)) ; '(0 1 2 3)

(define (insert x xs)
  (foldr swap (list x) xs)
  )

(define (my-sort xs)
  (foldr insert '() xs)
  )
(my-sort '(9 5 4 8 -5 11))


#|
2nd part: cost of sorting
how many times the swap operation is called

'(5 -8 0)
element 1
my-sort -> call insert
insert -> call swap
swap -> linear
2 function calls for each elemnt
x . x = x^2 = O(n^2)


|#