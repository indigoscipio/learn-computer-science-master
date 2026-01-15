#lang simply-scheme



#|
Classify each of these problems as a pattern (every, keep, or accumulate), if possible, and then write the 
procedure recursively. In some cases we've given an example of invoking the procedure we want you to write, instead 
of describing it.

14.1
> (remove–once 'morning '(good morning good morning))
(GOOD GOOD MORNING)
(It's okay if your solution removes the other MORNING instead, as long as it removes only one of them.)
|#

; this is a classic keep/scan pattern
; where we look into the list until the first wd is found, then return the sent without that wd
(define (remove-once wd sent)
  (cond [(null? sent) '()] ;no wd found
        [(eq? (first sent) wd) (bf sent) ]
        [else (se (first sent) (remove-once wd (bf sent))) ])
  )
(remove-once 'morning '(good morning good morning))

; ==================================

#|
14.2
> (up 'town)
(T TO TOW TOWN)
|#

; this one follows an every pattern, basicall recurse for each letter in 'town
(define (up wd)
  (cond [(empty? wd) '()]
        [else (se (up (bl wd)) wd ) ])
  )
(up 'town)
; this is a fold-right behaviour
; but left associacitivty

; ==================================

#|
14.3
>  (remdup '(ob la di ob la da))             ;; remove duplicates
(OB LA DI DA)

(It's okay if your procedure returns (DI OB LA DA) instead, as long as it removes all but one instance of each 
duplicated word.)
|#

; this one is a keep pattern, with amix of every since we wanna check each one by one
(define (remdup sent)
  ; if sentence is empty, return empty
  ; if first sentence is a member of the bf se, remove it
  ; else keep recursing
  (cond [(empty? sent) '()]
        [(member? (first sent) (bf sent)) (remdup (bf sent))]
        [else (se (first sent) (remdup (bf sent)))]
        )
  )
(remdup '(ob la di ob la da))

; ==================================

#|
14.4
> (odds '(i lost my little girl))
(I MY GIRL)
|#

; this one follows a keep pattern
(define (odds sent)
  (cond [(null? sent) '()]
        [(null? (bf sent)) sent]
        [else (se (first sent) (odds (bf (bf sent))) )]
        )
  )
(odds '(i lost my little girl))

; ==================================


#|
14.5 [8.7] Write a procedure letter–count that takes a sentence as its argument and returns the total number of 
letters in the sentence:
> (letter–count '(fixing a hole))
11
|#


; answer
; pattern is a mix of keep and accumulate/combine
(define (letter-count sent)
  (cond [(empty? sent) 0]
        [(word? (first sent)) (+ (count (first sent)) (letter-count (bf sent)))]
        [else (letter-count (bf sent))]
        )
  )
(letter-count '(fixing a hole))

#|
14.6
write member?
|#

; answer
; which is a keep pattern
(define (my-member? x xs)
  (cond [(empty? xs) #f]
        [(equal? (first xs) x) #t]
        [else (my-member? x (bf xs))])
  )
(my-member? 3 '())

#|
14.7 Write differences, which takes a sentence of numbers as its argument and returns a sentence containing the 
differences between adjacent elements. (The length of the returned sentence is one less than that of the argument.)
> (differences '(4 23 9 87 6 12))
(19 –14 78 –81 6)
|#

; answer:

(define (differences sent)
  ...
  )