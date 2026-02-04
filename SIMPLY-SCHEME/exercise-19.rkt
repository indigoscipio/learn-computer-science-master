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
  (cond [(empty? xs) (last xs)]
        [(empty? (cdr xs)) xs] ;last item on the list
        [else (op (left-accumulate op (cdr xs)) (car xs))]
        )
  )
(left-accumulate  - '(2 3 4 5))