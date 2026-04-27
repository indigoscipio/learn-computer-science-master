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
(define (my-member x xs)
  (cond [(empty? xs) #f]
        [(equal? x (car xs)) #t]
        [else (my-member x (cdr xs))]
        )
  )
(my-member 3 '(1 2 3 4 5))


; PART B
(define (my-member2 xs pred)
  (cond [(empty? xs) #f]
        [(pred (car xs)) #t]
        [else (my-member2 (cdr xs) pred)]
        )
  )
(my-member2 '(1 2 3 4 5) even?)

; PART C
(define (my-member3 xs pred)
  (cond [(empty? xs) '()]
        [(pred (car xs)) (car xs)]
        [else (my-member3 (cdr xs) pred)]
        )
  )
(my-member3 '(1 2 3 4) even?)

; PART D
(define (my-member3 xs pred)
  (cond [(empty? xs) '()]
        [(pred (car xs)) (car xs)]
        [else (my-member3 (cdr xs) pred)]
        )
  )
(my-member3 '(1 2 3 4) even?)