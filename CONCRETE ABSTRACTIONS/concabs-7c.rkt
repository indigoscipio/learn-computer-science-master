#lang racket

; REVIEW PROBLEMS
; Exercise 7.39
; Prove using induction on n that the following procedure produces a list of length n.
(define (sevens n)
  (if (= n 0)
      '()
      (cons 7
            (sevens (- n 1)))
      )
  )


#|
answer:

BASE CASE
n = 0 -> return '() which is a list of length 0
therefore the base case is true

INDUCTIVE HYPOTHESIS
assume that (sevens k) returns a list of length k.

INDUCTIVE STEP
we must show that (sevens k+1) returns a list of length k + 1

since k is >0 it goes into the else case

(cons 7 (sevens (- k 1))) ->
(cons 7 (sevens (- (+ k 1) 1))) ->
(cons 7 (sevens k))

since we assume (sevens k) returns a list of length k
(cons 7 (sevens k)) returns  a list of length k plus the operation cons add 1
so it returns a list of length k + 1

QED.

|#


; ==================================================================================

#|
Exercise 7.40

Suppose that f1,f2,...,fn are all functions from real numbers to real numbers. The
functional sum of f1,f2,...,fn is the function that, when given a number x, returns
the value f1(x) f2(x) 
fn(x). Write a procedure function-sum that takes a
list of functions and returns the functional sum of those functions. For example

(define square
  (lambda (x) (* x x)))
(define cube
  (lambda (x) (* x (* x x))))
((function-sum (list square cube)) 2)
12


answer:
|#

(define (cube x)
  (* x (* x x))
  )

(define (function-sum lof)
  ; apply each function to n first
  ; then just sum the result using fold
  (λ (n) 
    (foldr + 0 (map (lambda (f) (f n)) lof)))
  )
((function-sum (list sqr cube)) 2) ;should return 12

; ==================================================================================


#|
Exercise 7.41
Write an iterative version of the following procedure:

(define square-sum
  (lambda (lst)
    (if (null? lst)
        0
        (+ (square (car lst))
           (square-sum (cdr lst))))))
|#

(define (square-sum-iter lst)
  (define (loop xs  result)
    (cond [(null? xs) result]
          [else (loop (cdr xs) (+ (sqr (car xs)) result))]
          )
    )
  (loop lst 0)
  )
(square-sum-iter '(1 2 3)) ;1^2 + 2^2 + 3^2 = 1+4+9 = 14

; ==================================================================================

#|
Exercise 7.42
Write a procedure called apply-all that, when given a list of functions and a
number, will produce the list of the values of the functions when applied to the
number. For example,

(apply-all (list sqrt square cube) 4)
(2 16 64)

|#

(define (apply-all lof n)
  ; map version
  ;(map (λ (f) (f n) ) lof)

  ; recursive version
  (cond [(null? lof) '()]
        [else (cons ((car lof) n) (apply-all (cdr lof) n)) ])
  )
(apply-all (list sqrt sqr cube) 4)


; ==================================================================================

#|
Exercise 7.43
Prove by induction on n that the following procedure produces a list of 2n seventeens

(define (seventeens n)
  (if (= n 0)
      '()
      (cons 17 (cons 17 (seventeens (- n 1))))))

answer:

BASE CASE
n = 0 -> goes into the first case and return and empty list
2(0) -> 0 therefore true

INDUCTIVE HYPOTHESIS
lets assume the function (seventeens k) produces a list of 2k seventeens

INDUCTIVE STEP
we must show that (seventeens (k+1)) produces a list of a list of 2(k+1) seventeens

since k > 0 it goes to the else case
(seventeens (+ k 1))
-> (cons 17 (cons 17 (seventeens (- (+ k 1) 1))))
-> (cons 17 (cons 17 (seventeens k)))

since we assumed (seventeens k) returns a list of 2k seventeens
therefore seventeens 2(k+1) returns 2k seventeens + the 2 seventeens so
2k + 2 -> 2(k+1)

therefore proven


|#
 

; ==================================================================================

#|
Exercise 7.44
Consider the following two procedures. The procedure last selects the last element
from a list, which must be nonempty. It uses length to find the length of the list.

(define (last lst)
  (if (= (length lst) 1)
      (car lst)
      (last (cdr lst))))


(define (length lst)
  (if (null? lst)
      0
      (+ 1 (length (cdr lst)))))

a. how many cdrs does (length lst) do when lst has n elements?
b. how many calls to length does (last lst) make when lst has n elements?
c.  Express in big theta notation the total number of cdrs done by (last lst), including
cdrs done by length, again assuming that lst has n elements.
d. give an exact formula for the total number of cdrs done by (last lst), including
cdrs done by length, again assuming that lst has n elements.

answer:

ok let me try to answer this it will probably be wrong but ill give this a shot

a. 
lets do small example where n = 3 items
(length 3) -> n = 3 items in the list
is list empt? false
goes into else case -> (+ 1 (length (cdr lst))) -> 1 cdr

(length 2) -> n = 2
goes into else case -> (+ 1 (length (cdr lst))) -> 1 cdr

(length 1) -> n = 1
goes into else case -> (+ 1 (length (cdr lst))) -> 1 cdr

(length 0) -> n = 0, list is empty
return 0

so total cdr occurence is 3 for n =3
so it seems when lst has elements, it does exactly n cdrs

0 element -> 0 cdr
1 eelement -> 1 cdr, etc

-----

b. ok so we wanna know how many calls to length does (last lst) make when lst has n elements
lets do small example where lst n = 3

(last lst) -> n = 3 elements
(last 3)
check is length 1 ? -> +1 call -> false
goes to else case -> (last (cdr lst))

(last 2) -> n = 2 elmeents
check is length 1 ? -> +1 call -> false
goes to else case -> (last (cdr lst))

(last 1) -> n = 1 elmeents
check is length 1 ? -> +1 call -> true
return (car lst)

so total calls to length when last has n=3 is also 3
so same as a, calls n times

-----

c. 
ok so this one since we know

(length lst) -> calls (cdr lst) n times where n is the length of lst
(last lst) -> calls (length lst) n times + the cdr else case

and cdrs from length clals = n + n-1 + n-2 + ... + 1

so the total is
(cdrs from all length calls) + (cdrs from last's own recursion)
n(n+1)/2 + n
(n^2 +n)/2 + n

therefore the big theta is O(n^2)

|#

; ==================================================================================

#|

Exercise 7.45
Lists are collections of data accessible by position. That is, we can ask for the first
element in a list, the second, ..., the last. Sometimes, however, we’d prefer to have
a collection of data accessible by size. In other words, we’d like to be able to ask for
the largest element, the second largest, ..., the smallest.
In this problem, we’ll simplify this goal by restricting ourselves to collections
containing exactly two real numbers. Thus the two selectors will select the smaller
and larger of the two numbers. Here are some examples of this data abstraction
in use; the constructor is called make-couple. Note that the order in which the
argument values are given to the constructor is irrelevant, because selection is based
on their relative size.

(define x (make-couple 2 7))
(define y (make-couple 5 3))
(define z (make-couple 4 4))

(smaller x)
2
(smaller y)
3
(smaller z)
4
(larger x)
7
(larger y)
5
(larger z)
4

Write two versions of make-couple, smaller, andlarger. One version should
have make-couple compare the two numbers, and the other version should leave
that to smaller and larger

answer:
|#

; VERSION 1: make-couple compare the two numbers
(define (make-couple-v1 x y)
  (cond [(> x y) (cons y x)] ;x is larger
        [else (cons x y)] ;x is smaller
        )
  )

(define (smaller-v1 couple)
  (car couple)
  )

(define (larger-v1 couple)
  (cdr couple)
  )


; VERSION 2: smaller and larger compare the two numbers
(define (make-couple-v2 x y)
  (cons x y)
  )

(define (smaller-v2 couple)
  (cond [(> (car couple) (cdr couple)) (cdr couple)] ; x > y
        [else (car couple)] ; x < y
        )
  )

(define (larger-v2 couple)
  (cond [(> (car couple) (cdr couple)) (car couple)] ; x > y
        [else (cdr couple)] ; x < y
        )
  )

; ==================================================================================


#|
Exercise 7.46
Write a higher-order procedure make-list-scaler that takes a single number scale
and returns a procedure that, when applied to a list lst of numbers, will return the
list obtained by multiplying each element of lst by scale. Thus, you might have the
following interaction:

(define scale-by-5 (make-list-scaler 5))
(scale-by-5 '(1 2 3 4))
(5 10 15 20)

answer:
|#

(define (make-list-scaler scale)
  (λ (lst) (map (λ (x) (* x scale)) lst) )
  )
(define scale-by-5 (make-list-scaler 5))
(scale-by-5 '(1 2 3 4)) ; should return (5 10 15 20)

; ==================================================================================

#|
Exercise 7.47

Write a procedure map-2 that takes a procedure and two lists as arguments and
returns the list obtained by mapping the procedure over the two lists, drawing the
two arguments from the two lists. For example, it would yield the following results

(map-2 + '(1 2 3) '(2 0-5))
(3 2 -2)
(map-2 * '(1 2 3) '(2 0-5))
(2 0 -15)

Write this procedure map-2. You may assume that the lists have the same length.
|#

(define (map-2 op xs ys)
  ;recursive version
  (cond [ (null? xs) '()] ;both is empty
        [else (cons (op (car xs) (car ys)) (map-2 op (cdr xs) (cdr ys)) )]
        )
  )

(map-2 + '(1 2 3) '(2 0 -5))
(map-2 * '(1 2 3) '(2 0 -5))

; ==================================================================================


#|
Exercise 7.48
Given the following procedure:

(define sub1-each (nums)
  
  (define (help nums results)
    (if (null? nums)
        (reverse results)
        (help (cdr nums) (cons (- (car nums) 1) results))))
  
  (help nums '())
  )

Evaluate the expression (sub1-each '(5 4 3)) using the substitution model of
evaluation. Assume reverse operates in a single “black-box” step, but otherwise
show each step in the evolution of the process. What kind of process is generated by
this procedure?

answer:

ok let me trace this carefully
we start with nums = '(5 4 3)  so a list of length 3
then inside we call a helper function

(help nums '()) -> nums = nums, results = '()

1st iteration
nums = '(5 4 3), results = '()
is nums empty? false
goes to else case -> (help (cdr nums) (cons (- (car nums) 1) results)) ->
(help '(4 3) (cons (- 5 1) results)) -> (help '(4 3) (cons 4 '()))

2nd interation
nums = '(4 3), results = '(4)
is nums empty? false
goes to else case -> (help (cdr nums) (cons (- (car nums) 1) results)) ->
(help '(3) (cons (- 4 1) results)) -> (help '(3) (cons 3 (cons 4 '())))

3nd interation
nums = '(3), results = '(3 4)
is nums empty? false
goes to else case -> (help (cdr nums) (cons (- (car nums) 1) results)) ->
(help '() (cons (- 3 1) results)) -> (help '() (cons 2 (cons 3 (cons 4 '()))))

4th interation
nums = '(), results = '(2 3 4)
is nums empty? true. stop and reverse the final result
reverses the result -> '(4 3 2)

the process is iterative
the procedure is tail recursive
no call stack, carries over the value to the 'resulsts'

|# 




; ==================================================================================


#|
Exercise 7.49

Given a predicate that tests a single item, such as positive?, we can construct an
“all are” version of it for testing a list; an example is a predicate that tests whether all
elements of a list are positive. Define a procedure all-are that does this; that is, it
should be possible to use it in ways like the following:

((all-are positive?) '(1 2 3 4))
#t
((all-are even?) '(2 4 5 6 8))
#f

answer: ok so this is basically like andmap thing
|#

(define (all-are pred)
  (λ (lst) (cond [(null? lst) #t]
                 [else (and (pred (car lst)) ((all-are pred) (cdr lst)))]
                 ))
  )
((all-are positive?) '(1 2 3 4))
((all-are even? )'(2 4 5 6 8))




; ==================================================================================

#|
Exercise 7.50
Consider the following procedure (together with two sample calls):
(define (repeat num times)
  (if (= times 0)
      '()
      (cons num (repeat num (- times 1))))))
(repeat 3 2) ;(3 3)
(repeat 17 5) ;(17 17 17 17 17)

a. explain why repeat generates a recursive process
b. write an iterative version of repeat

a. because on the else case cons is waiting on the result of (repeat num (- times 1)) before it can do anything
and inside of that its waiting for another recursive functio nagain
so it waits until it reaches the base case and 'wraps up' and gets evaluated/build the chain of cons from there
so the pending work accumulates on the call stack then unwinds

|#

; PART B
(define (repeat-iter num times)
  (define (helper counter result)
    (cond [(zero? counter) result]
          [else (helper (- counter 1) (cons num result))])
    )
  ; initialize counter to num
  (helper times '())
  )
(repeat-iter 3 2)
(repeat-iter 17 5)