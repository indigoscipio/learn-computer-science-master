#lang racket

;Exercise 7.3
;Write a procedure that will generate the list of even integers from a to b

(define (even-ints-from a b)
  ;increment the a/acts like the counter
  (cond [(> a b) '()]
        [(zero? (remainder a 2)) (cons a (even-ints-from (+ 2 a) b)) ] ;add it to the list
        [else (even-ints-from (+ a 1) b)]
        )
  )

; ===========================================

; Exercsise 7.4
;We could rewrite integers-from-to so that it generates an iterative process. Con
; sider the following attempt at this:
; faulty version

#|
(define (integers-from-to low high)
  (define (iter low lst)
      (if (> low high)
          lst
          (iter (+ 1 low)
                (cons low lst))))
  (iter low '())
  )

(integers-from-to 1 3)
|#

;What happens when we evaluate (integers-from-to 2 7)? Why? Rewrite this
;procedure so that it generates the correct list.

#|
ok lets try a small example
(integers-from-to 1 3)

1st iter
low = 1, high = 3, lst = '()
low > high? false -> goes to else case
(iter (+ 1 low) (cons low lst)) -> (iter (+ 1 1) (cons 1 '()) )

2nd iter
low = 2, high = 3, lst = (cons 1 '())
low > high? false -> goes to else case
(iter (+ 1 low) (cons low lst)) -> (iter (+ 1 2) (cons 2 (cons 1 '())) )

3rd iter
low = 3, high = 3, lst = (cons 2 (cons 1 '()))
low > high? false -> goes to else case
(iter (+ 1 low) (cons low lst)) -> (iter (+ 1 3) (cons 3 (cons 2 (cons 1 '())) ) )

final iter
low = 4, high = 3, lst = (cons 3 (cons 2 (cons 1 '())))
low > high? true, return lst

so we have something like '(3 2 1)
the issue is that the list is reversed
the corrected version, just reverse the final acc
or just start from high value first, then lowest value (eg set the counter to high)


V1: with reverse
(define (integers-from-to low high)
  (define (iter n acc)
    (cond [(> n high) acc]
          [else (iter (+ 1 n) (cons n acc))])
    )
  (iter low '())
  )
(integers-from-to 2 7)


V2: with n initialized to high
(define (integers-from-to low high)
  ; initialize n=high, keep decreasing until n reaches low
  (define (iter n acc) 
    (cond [(< n low) acc]
          [else (iter (- n 1) (cons n acc))])
    ) 
  (iter high '())
  )
(integers-from-to 2 7)
|#

; ===========================================

#|
Exercise 7.5
Generalize sum to a higher-order procedure that can accumulate together the ele
ments of a list in an arbitrary fashion by using a combining procedure (such as +)
specified by a procedural parameter. When the list is empty, sum returned 0, but this
result isn’t appropriate for other combining procedures. For example, if the com
bining procedure is *, 1 would be the appropriate value for an empty list. (Why?)
Following are two possible approaches to this problem:

a. Write the higher-order procedure so that it only works for nonempty lists. That
way, the base case can be for one-element lists, in which case the one element
can be returned.

b. Write the higher-order procedure so that it takes an additional argument, beyond
the list and the combining procedure, that specifies the value to return for an
empty list.

|#

; approach a, assume its nonempty list
(define (accum lst proc)
  (cond [(null? (cdr lst)) (car lst)]
        [else (proc (car lst) (accum (cdr lst) proc) ) ]
        )
  )
(accum '(1 2 3 4 5 6) +)
(accum  '(1 2 3) cons)


; approach b, with specified base case and additional proc arg
(define (accumulate lst base proc)
  (if (null? lst)
      base
      (proc (car lst) (accumulate (cdr lst) base proc))
      )
  )
(accumulate '(1 2 3 4 5 6) 0 +)
(accumulate '(1 2 3) '() cons)

; ===========================================

#|
Exercise 7.6
a.  Write a procedure that will count the number of times a particular element occurs
in a given list

b. Generalize this procedure to one that will count the number of elements in a
given list that satisfy a given predicate

answer:
|#

; PART A
(define (count-occurences target xs)
  (cond [(null? xs) 0]
        [(equal? target (car xs)) (+ 1 (count-occurences target (cdr xs)))]
        [else (count-occurences target (cdr xs))]
        )
  )
(count-occurences 1 '(1 2 3 4 5 1 1 1))

; PART B
(define (count-occurences2 xs pred)
  (cond [(null? xs) 0]
        [(pred (car xs)) (+ 1 (count-occurences2 (cdr xs) pred))]
        [else (count-occurences2 (cdr xs) pred)]
        )
  )
(count-occurences2 '(1 2 3 4 5 1 1 1) even?)

; ===========================================

#|
Exercise 7.7
In addition to the procedure length, Scheme has a built-in procedure list-ref
that returns a specified element of a list. More precisely, a call of the form
(list-ref lst n) will return the (n 1)st element of lst, because by convention
n 0returns the first element, n 1 returns the second, etc. Try this procedure
for various parameter values. Write this procedure yourself.


(list-ref '(1 2 3 4 5) 2) ; returns the 2+1 = 3rd element
(list-ref '(a b c) 0) ; returns the 0+1 = first element
(list-ref '(1 2 3) 3) ; index too large
|#



; assume index is nonnegative
;my-list-ref:: list-of-x number -> x
(define (my-list-ref xs n)
  ; stop when n reaches zero
  (cond [(null? xs) (error "Index out of bounds")]
        [(zero? n) (car xs)]
        [else (my-list-ref (cdr xs) (- n 1))]
        )
  )
;(my-list-ref '(a b c) 0)
;(my-list-ref '(1 2 3 4 5) 2)
;(my-list-ref '(1 2 3) 3)


; ======================================
#|

Exercise 7.8
Here are some more exercises in cdring down a list:
a. Write a predicate that will determine whether or not a particular element is in a
list.
b. Generalize this to a predicate that will determine whether any element of a list
satisfies a given predicate.
c. Write a procedure that will find and return the first element of a list that satisfies
a given predicate.
d. Write a procedure that will determine whether all elements of a list satisfy a given
predicate.
e. Write a procedure that will find the position of a particular element in a list. For
example,
(position 50 '(10 20 30 40 50 3 2 1))
4
Notice that we are using the same convention for position as is used in list-ref,
namely, the first position is 0, etc. What should be returned if the element is not
in the list? What should be returned if the element appears more than once in
the list?
f. Write a procedure that will find the largest element in a nonempty list.
g. Write a procedure that will find the position of the largest element in a nonempty
list. Specify how you are breaking ties.

answer:


|#

; PART A
(define (f1 x xs)
  (cond [(empty? xs) #f]
        [(equal? x (car xs)) #t]
        [else (f1 x (cdr xs))]
        )
  )
(f1 3 '(1 2 3 4 5))


; PART B
(define (f2 xs pred)
  (cond [(empty? xs) #f]
        [(pred (car xs)) #t]
        [else (f2 (cdr xs) pred)]
        )
  )
(f2 '(1 2 3 4 5) even?)

; PART C
(define (f3 xs pred)
  (cond [(empty? xs) '()]
        [(pred (car xs)) (car xs)]
        [else (f3 (cdr xs) pred)]
        )
  )
(f3 '(1 2 3 4) even?)

; PART D
(define (f4 xs pred)
  (cond [(empty? xs) #t]
        [(pred (car xs)) (and (f4 (cdr xs) pred))]
        [else #f]
        )
  )
(f4 '(1 2 3 4) even?)
(f4 '(2 4 6 8) even?)

; PART E
(define (f5 x xs)

  (define (loop idx lst)
    (cond [(null? lst) #f]
          [(equal? x (car lst)) idx]
          [else (loop (+ 1 idx) (cdr lst))]
          )
    )
  (loop 0 xs)
  
  )
(f5 50 '(10 20 30 40 50 3 2 1))
(f5 0 '(10 20 30 40 50 3 2 1 50))

; PART F
; input is nonempty
(define (f6 xs)

  (define (loop curr-largest lst)
    (cond [(null? lst) curr-largest]
          [(> (car lst) curr-largest ) (loop (car lst) (cdr lst))] ;1st is larger then 2nd, update curr largest
          [else (loop curr-largest (cdr lst))]
          )
    )
  
  ; initialize (car xs) as curr-largest
  (loop (car xs) (cdr xs))
  
  )
(f6 '(1 2 3 4 5 6 7 8 9))

(define (f6b xs)
  (cond [(null? (cdr xs)) (car xs) ]
        [else (let ((max-rest (f6b (cdr xs))))
                (if (> (car xs)  max-rest)
                    (car xs)
                    max-rest
                    )
                )])
   
  )
(f6b '(1 2 3 4 5 6 7 8 9))

#|
g. Write a procedure that will find the position of the largest element in a nonempty
list. Specify how you are breaking ties.

|#
; PART G
; finds index of largest element in inonempty list
; how it break ties: it reutrns whichever is larger than previous
(define (f7 xs)
  (define (loop lst largest-element largest-idx curr-idx)
    (cond [(null? lst) largest-idx] ;no more to check, return largest index
          [(> (car lst) largest-element) (loop (cdr lst) (car lst) curr-idx (+ 1 curr-idx) )] ; update the index & largest element
          [else (loop (cdr lst) largest-element largest-idx (+ 1 curr-idx) )]
          )
    )
  (loop (cdr xs) (car xs) 0 1)
  )
(f7 '(123456 1 3 8 0 9 55 7 999))

; PART G, recursive style
; a result is a (cons value index)
; xs -> result
(define (f7b xs)
  (cond [(null? (cdr xs)) (cons (car xs) 0)] ;one item left
        [else (let ((max-rest (f7b (cdr xs)) ))
                (if (> (car xs) (car max-rest))
                    (cons (car xs) 0)
                    (cons (car max-rest) (+ 1 (cdr max-rest)))
                    )
                )]
        )
  )
(f7b '(5 8 2))
(f7b '(5 8 99 0 564 99999))


; ===========================================================

#|
Exercise 7.9
This exercise involves cdring down two lists
a.  Write a procedure that gets two lists of integers of the same size and returns true
when each element in the first list is less than the corresponding element in the
second list. For example,

(list-< '(1 2 3 4) '(2 3 4 5))
#t

b. eneralize this procedure to one called lists-compare?. This procedure should
get three arguments; the first is a predicate that takes two arguments (such as <)
and the other two are lists. It returns true if and only if the predicate always
returns true on corresponding elements of the lists. We could redefine list-< in
the following manner:

(define list-<
  (lambda (l1 l2)
    (lists-compare? < l1 l2)))

answer:
|#

; with iter
; list-of-x list-of-y -> boolean
; walk through xs
(define (list< xs ys)
  (cond [(null? xs) #t] 
        [(< (car xs) (car ys)) (list< (cdr xs) (cdr ys))]
        [else #f]
        )
  )
(list< '(1 2 3 4) '(2 3 4 5))

; PART B
(define (lists-compare? pred xs ys)
  (cond [(empty? xs) #t]
        [(pred (car xs) (car ys)) (lists-compare? pred (cdr xs) (cdr ys))]
        [else #f]
        )
  )
(lists-compare? < '(1 2 3 4) '(2 3 4 5))


; ============================



#|
Exrecise 7.10
Write the procedure list-tail, that gets a list and an integer n and returns the
list of all but the first n elements in the original list. (List-tail is actually already
built into Scheme.)

answer:
|#

; given a list, returns all but thefirst leemnets in the original list
; basically like drop
(define (list-tail n xs)
  (cond [(empty? xs) '()]
        [(zero? n) xs]
        [else (list-tail (- n 1) (cdr xs))]
        )
  )
(list-tail 3 '(1 2 3 4 5 6)) ;should return '(4 5 6)
(list-tail 0 '(1 2 3)) ; nothing to drop, keep as it is
(list-tail 7 '(1 2 3)) ; exceeds, reutrn empty list?


; =========================

; assume list is same length and nonempty
;; zip: list-of-x list-of-y -> list-of-z
; interweaves two list into one with alternating
(define (zip xs ys)
  (define (iter lst1 lst2  result)
    (cond [(and (empty? lst1) (empty? lst2)) (reverse result)]
          [else (iter lst2 (cdr lst1) (cons (car lst1) result))] ; weave right

          )
    )
  (iter xs ys '())
  
  )
(zip '(1 2 3) '(4 5 6))


; recursive version
(define (zip-rec xs ys)
  (cond [(and (empty? xs) (empty? ys)) '()]
        [else (cons (car xs) (zip-rec ys (cdr xs)) )]
        )
  )
(zip-rec '(1 2 3 4) '(5 6 7 8))

; =========================

#|
Exercise 7.11
We have written shuffle so that it can operate on decks of any size. In fact, decks
of all sizes have the property that after a certain number of perfect shuffles, the
deck is returned to its original order. In this exercise you will write procedures that
will automate the process of finding the number of shuffles, which we call the
shuffle-number, required for a deck of a given size.

a. Given that you start with an ordered deck, the first thing you will need is a
predicate, called in-order?, that determines whether a list of integers is in
increasing order. Write this procedure.

b.  Using in-order?, write a procedure shuffle-number that, when passed a pos
itive integer n, returns the shuffle-number for n. You should start off with an
ordered deck of size n and repeatedly shuffle until the deck is in order.

answer:
|#


(define (in-order? xs)
  ; check if curr item is greater than the previous
  ; ifso, move and keep checking
  ; else return false
  (cond [(null? xs) #t] ; no more item to check; allin correct order
        [(null? (cdr xs)) #t] ; lastone on the list
        [else (let ((curr (car xs))
                    (next (cadr xs))
                    (rest (cdr xs))
                    )
                (and (< curr next)
                    (in-order? rest))
                    
                )]

        )
  )
(in-order? '(1 2 3 4 5))


; PART B
; xs number -> xs
(define (shuffle deck size)
  (let ((half (quotient (+ size 1) 2)))
    (zip (take deck half) (drop deck half))))
(shuffle '(1 2 3 4 5 6 7 8) 8)


; number -> number
(define (shuffle-number n)
  (let* ((original-deck (range 1 (+ 1 n)))
        (original-shuffled-deck (shuffle original-deck n))
        ) ;create var for orignal deck
    (define (loop deck count)
      (cond [(in-order? deck) count] ;base case: deck is in order
            [else (loop (shuffle deck n) (+ 1 count)) ] ; else keep shuffling and increase the count
            )
      )
    (loop original-shuffled-deck 1)
    )
  
  )
(shuffle-number 52)

; ======================================================

#|
Exercise 7.12
Throughout this section on perfect shuffles, we’ve been passing in the size of the
deck as well as the list representing the deck itself in order to avoid computing the
length of the list when we already knew it. Another approach would be to create a
new compound data type for decks, with two selectors: one to get the list of elements
and the other to get the length. That way we could pass in just a single thing,
the deck, but could still find the length without counting. Flesh out the remaining
details of this idea, implement it, and try it out.

answer:

a deck is a pair
(cons deck length)
;interpretation list of deck and length of deck
;example (cons '(1 2 3 4) 4)


|#

; CONSTRUCTOR
; number -> pair-of deck number
(define (make-deck deck)
  (cons deck (length deck))
  )

; SELECTORS
(define (deck-length deck)
  (cdr deck)
  )


(define (deck-content deck)
  (car deck)
  )


; ======================================================

#|
Exercise 7.13
The procedure map is extraordinarily handy for creating lists of all sorts. Each of the
following problems can be solved by using map.

a.  Write a procedure that, when given a positive integer n, returns a list of the first
n perfect squares
b. Write a procedure that, when given a positive integer n, returns a list of the first
n even integers.
c.  Write a procedure called sevens that, when given a positive integer n, returns a
list of n sevens. For example
 (sevens 5)
(7 7 7 7 7)

d.  Write a procedure that, when given a list of positive integers, returns a list of lists
of integers. Each of these lists should be the positive integers from 1 to whatever
was in the original list. For example,

(list-of-lists '(1 5 3))
((1) (1 2 3 4 5) (1 2 3))

answer:
|#

; PART A
; returns the list of the first n perfect squares given a positive integer n
(define (fun1 n)
  (map sqr (range 1 (+ n 1)))
  )
(fun1 10) (fun1 1)


; PART B
; idontthink we even need mapforthis
(define (fun2 n)
  (range 2 (*(+ n 1) 2) 2) 
  )
(fun2 10)

(define (fun2b n)
  (map (λ (x) (* x 2)) (range 1 (+ n 1)))
  )
(fun2b 3)


; PART C
(define (sevens n)
  (map (λ (x) 7) (range 1 (+ n 1)))
  )
(sevens 1)


; PART D
(define (list-of-lists xs)
  (map (λ (n) (range 1 (+ n 1)) ) xs)
  )
(list-of-lists '(0))




; =================================================================

; Exercise 7.14
; Even though map is built into Scheme, it is a good exercise to write it yourself. Do so.

;; my-map: [x -> y] list-of-x -> list-of-y
(define (my-map f xs)
  (cond [(null? xs) '()]
        [else (cons (f (car xs)) (my-map f (cdr xs)))]
        )
  )
(my-map sqr '(1 2 3 4 5))


; =================================================================



; 7.4
; adds x to the every end of the list xs
(define (add-to-end x xs)
  (cond [(null? xs) (cons x xs)] ; list is empty, just cons it with the empty list
        [else (cons (car xs) (add-to-end x (cdr xs)))])
  )
(add-to-end 3 '(1 2))
(add-to-end 1 '())


(define (my-reverse xs)
  (cond [(null? xs) '()]
        [else (add-to-end (car xs) (my-reverse (cdr xs)) )]
        )
  )
(my-reverse '())
(my-reverse '(1))
(my-reverse '(1 2))
(my-reverse '(1 2 3 4 5))

(define (my-reverse2 xs)
  (define (loop lst result)
    (cond [(null? lst) result]
          [else (loop (cdr lst) (cons (car lst) result))])
    )
  (loop xs '())
  )
(my-reverse2 '(1 2 3 4 5))

#|
first take 1 and put it to the end of the list.
new list = 2 3 4 5 1
next take 2 and put it to the end of the list
new list = 3 4 5 1 2

|#

; TREE LIST RECURSION

