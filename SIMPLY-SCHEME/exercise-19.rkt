#lang simply-scheme

; zero trip philosophy
; if starting condition already exceeds the end cond,
; loop should not execute at all ; aka check at the beginning
 
; HOF
; accumulate - last element is the base case in simply scheme

; ==========================
; BORING EXERCISES

#|
19.1 What happens if you say the following?
(every cdr '((john lennon) (paul mccartney)
             (george harrison) (ringo starr)))
How is this different from using map, and why? How about cadr instead of cdr?

; answer:
the procedure every extracts the rest of hte list of each item and put it in a list
; so its '(lennon) + (mccartney) + ... and since every just put it ina sentence it appends it
; so it should return '(lennon mccartney harrison starr)
; if we use a cadr it would reutrn just the word itself so 'lennon + 'mccartney
; and because every also acceps word it turn the word into a sentence so the result should be the samea

and if we use map intead, it would reutrn a list of something liek '((lennon)(mccartney)...)
; and if we use map cadr it would reutrn a list of '(lennon mccartney...)
|#
(every cdr '((john lennon) (paul mccartney)
                           (george harrison) (ringo starr)))


(map cadr '((john lennon) (paul mccartney)
                           (george harrison) (ringo starr)))


; =================================
; REAL EXERCISE

#|
19.2 Write keep. Don't forget that keep has to return a sentence if its second argument is a sentence, and a word if its 
second argument is a word.
(Hint: it might be useful to write a combine procedure that uses either word or sentence depending on the types 
of its arguments.)
|#

(define (combine x xs)
  (cond [(word? xs) (word x xs)]
        [else (se x xs)]
        )
  )

; a->b word/sent -> word/sent
(define (my-keep pred xs)
  ; case: xs is empty - return '()
  ; case: word - use word proc
  ; case: sentence - use se proc
  (cond [(empty? xs) xs]
        [else (if (pred (first xs))
                  (combine (first xs) (my-keep pred (bf xs)))
                  (my-keep pred (bf xs))
                  )]
        )
  )
(my-keep even? '()) ;return '()
(my-keep even? '(1 2 3 4 5 6 7 8 9)); should keep even numbers
(my-keep even? '1234567890)

; =================================

#|
19.3 Write the three-argument version of accumulate that we described.
> (three–arg–accumulate + 0 '(4 5 6))
15
> (three–arg–accumulate + 0 '())
0
> (three–arg–accumulate cons '() '(a b c d e))
(A B C D E)
|#

(define (three-arg-accumulate op a xs)
  ; if xs is empty, return the base case a
  ; else perform the combine with first item of xs with the accumulated result
  (cond [(empty? xs) a]
        [else (op (car xs) (three-arg-accumulate op a (cdr xs)))])
  )
(three-arg-accumulate + 0 '(4 5 6))
(three-arg-accumulate + 0 '())
(three-arg-accumulate cons '() '(a b c d e))



; =================================

#|
19.4 Our accumulate combines elements from right to left. That is,
(accumulate – '(2 3 4 5))
computes 2 – (3 – (4 – 5)). Write left–accumulate, which will compute ((2 – 3) – 4) – 5 instead.
(The result will be the same for an operation such as +, for which grouping order doesn't matter,
but will be different for –.)
|#

(define (left-accumulate op xs)
  #|
  (cond [(empty? (bl xs)) (first xs)]
        [else (op (left-accumulate op (bl xs)) (last xs))]
        )
  |#

  (define (acc ls result)
    (cond [(empty? ls) result]
          [else (acc (cdr ls) (op result (car ls))) ])
    )
  (acc (cdr xs) (first xs))
  )
(left-accumulate  - '(2 3 4 5))

; =========================================

#|
19.5 Rewrite the true–for–all?
procedure from Exercise 8.10. Do not use every, keep, or accumulate.
|#

(define (true-for-all? pred xs)
  ; list is empty? true
  ; else check if the pred satisfiest each xs
  (cond [(empty? xs) #t]
        [(pred (car xs)) (true-for-all? pred (cdr xs))]
        [else #f]
        )
  )
(true-for-all? even? '()) ;vacuously true?
(true-for-all? even? '(2 4 6 8)) ;true
(true-for-all? even? '(2 6 3 4)) ;false

; =========================================

#|
19.6 Write a procedure true–for–any–pair? that takes a predicate and a sentence as arguments. The predicate 
must accept two words as its arguments. Your procedure should return #t if the argument predicate will return true for 
any two adjacent words in the sentence:
> (true–for–any–pair? equal? '(a b c b a))
#F
> (true–for–any–pair? equal? '(a b c c d))
#T
> (true–for–any–pair? < '(20 16 5 8 6))     ;; 5 is less than 8
#T
|#

(define (true-for-any-pair? pred sent)
  ; sent is empty - return true
  ; else check each pair and if theres any that satisfies, return true. else return false 
  (cond [(empty? sent) #f]
        [(empty? (bf sent)) #f] ;one item remaining
        [else (let ((fst (first sent))
                    (sec (first (bf sent)))
                    )
                (or (pred fst sec)
                    (true-for-any-pair? pred (bf sent)))
                )]
        )
  )


; =====================================================

#|
19.7 Write a procedure true–for–all–pairs? that takes a predicate and a sentence as arguments. The predicate 
must accept two words as its arguments. Your procedure should return #t if the argument predicate will return true for 
every two adjacent words in the sentence:
> (true–for–all–pairs? equal '(a b c c d))
#F
> (true–for–all–pairs? equal? '(a a a a a))
#T
> (true–for–all–pairs? < '(20 16 5 8 6))
#F
> (true–for–all–pairs? < '(3 7 19 22 43))
#T
|#

#|
(define (true-for-all-pairs? pred sent)
  (cond [(empty? sent) #t]
        [(empty? (bf sent)) #t] ;one item remaining
        [else (let ((fst (first sent))
                    (sec (first (bf sent)))
                    )
                (and (pred fst sec)
                     (true-for-all-pairs? pred (bf sent)))
                )]
        )
  )
(true-for-all-pairs?  equal? '(a b c c d))
(true-for-all-pairs?  equal? '(a a a a a))
(true-for-all-pairs?  < '(20 16 5 8 6))
(true-for-all-pairs?  < '(3 7 19 22 43))
|#

; =====================================================

#|
19.8 Rewrite true–for–all–pairs? (Exercise 19.7) using true–for–any–pair? (Exercise 19.6) as a helper 
procedure. Don't use recursion in solving this problem (except for the recursion you've already used to write true
for–any–pair?). Hint: You'll find the not procedure helpful.
|#


(define (true-for-all-pairs? pred sent)
  (not (true-for-any-pair? (λ (a b) (not (pred a b))) sent))
  )
(true-for-all-pairs?  equal? '(a b c c d))
(true-for-all-pairs?  equal? '(a a a a a))
(true-for-all-pairs?  < '(20 16 5 8 6))
(true-for-all-pairs?  < '(3 7 19 22 43))

; =====================================================
#|
19.9 Rewrite either of the sort procedures from Chapter 15 to take two arguments, a list and a predicate. It should sort 
the elements of that list according to the given predicate:
> (sort '(4 23 7 5 16 3) <)
(3 4 5 7 16 23)
> (sort '(4 23 7 5 16 3) >)
(23 16 7 5 4 3)
> (sort '(john paul george ringo) before?)
(GEORGE JOHN PAUL RINGO)
|#


; inserts x to an already sorted xs based on pred
; x list-of-x a->b -> list-of-x
(define (insert x xs pred)
  (cond [(empty? xs) (list x)] ; x is empty: just insert
        [(pred x (car xs)) (cons x xs)] ;insert it at front
        [else (cons (car xs) (insert x (cdr xs) pred))]
        )
  )
(insert 5 '(1 2 3) <) ;'(1 2 3 5)

(define (my-sort xs pred)
  (cond [(empty? xs) '()] ;already sorted
        [else (insert (car xs) (my-sort (cdr xs) pred) pred)]
        )
  )
(my-sort '(4 23 7 5 16 3) <)
(my-sort '(23 16 7 5 4 3) >)

; ========================================================================

#|
19.10 Write tree–map, analogous to our deep–map,
but for trees, using the datum and children selectors.
|#

(define (leaf? bt) (null? bt))
(define (make-node d c)
  (cons d c))
(define (datum node)
  (car node))
(define (children node)
  (cdr node))
(define (leaf datum)
  (make-node datum '()))
(define (cities name–list)
  (map leaf name–list))

(define (tree-map f tree)
  (cond [(leaf? tree) (f (datum tree))] ;it's a branch
        [else (make-node (datum tree) (forest-map f (children tree))) ]
        )
  )

(define (forest-map f forest)
  (cond [(empty? forest) '()] ;no more children
        [else (tree-map f (cdr forest))])
  )

(tree-map (leaf 5) (λ (x) (* x 10))) ;should reutrn '(50 '())
(tree-map (make-node 1 (list (leaf 2) (leaf 3))) (λ(x) (* x 10))) ;(10 ((20 ()) (30 ())))

