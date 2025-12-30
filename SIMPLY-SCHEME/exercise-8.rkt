#lang simply-scheme

(define (vowel? x) (member x '(a e i o u)))
(define (square n) (* n  n))

#|
;8.1
;whta does scheem return as value of each folowing expression? figure it out before trying it on computer
(every last '(algebra purple spaghetti tomato gnu))
'(a e i o u)

(keep number? '(one two three four))

(accumulate * '(6 7 13 0 9 42 17))
0

(member? 'h (keep vowel? '(t h r o a t)))

(every square (keep even? '(87 4 7 12 0 5)))

(accumulate word (keep vowel? (every first '(and i love her))))
; '(a i l h) -> '(a i) 'ai

((repeated square 0) 25)

(every (repeated bl 2) '(good day sunshine))
; go d sunshi
|#

;8.2
(keep vowel? 'birthday)
(every first '(golden slumbers))
(first '(golden slumbers))
(every last '(little child))
(accumulate word (every last '(little child)))
(every + '(2 3 4 5))
(accumulate + '(2 3 4 5))

;8.3
;Describe each of the following functions in English. Make sure to include a description of the domain and range of 
;each function. Be as precise as possible; for example, "the argument must be a function of one numeric argument" is 
;better than "the argument must be a function."

(define (f a)
  (keep even? a))
; this function takes the list of number and only keeps each item in a that are even
; input: list of number
; output: list of number (filtered)

(define (g b)
  (every b '(blue jay way)))
; this function takes an operator/function b and applies that function to 3 words: blue, jau, and way
; input: (x -> y)
; output: list of y

(define (h c d)
  (c (c d)))
; function h takes a function c and any type of d
; it applies c to d 2 times: (c d) and then apply again (c (c d))
; example: h square 7 - performs (square (square 7))


(define (i e)
  (/ (accumulate + e) (count e)))
; this is an average function
; it takes a list e and performs the sum of e divided by the length of e
; i '(1 2 3)
; / accumulate + '(1 2 3) 3

;accumulate
; this procedure takes 2 arguments
; the operator and a list
; depending on the operator it accumulates the value of the first 2 -> get the result -> perform operation on the next
; -> repeat -> until base case is reached

; repeated
; this function takes a procedure and number n and return another procedure when
; given an argument, applies that procedure n times instead

; (repeated sqrt 3)
; this procedure returns a procedure that when given an argument, applies sqrt 3 times to that argument

; (repeated even? 2)
; this proc returns a proc that when given an argument, applies even? 2 times to that argument
; it gives an error

; (repeated first 2)
; same error as even? since first returns an item an items first isalways undefined

;(repeated (repeated bf 3) 2)
; inner -> repeated bf 3 - a proc that returns a proc, when given an arg applies bf in chain-like manner 3 times
; 'hello -> 'ello -> 'llo -> 'lo
; outer -> (repeated (repeated bf 3) 2)
; so this one performs bf 3 * 2 = 6 times

; ========================================

; real exercise
; 8.4 Write a procedure choose–beatles that takes a predicate function as its argument and returns a sentence of 
; just those Beatles (John, Paul, George, and Ringo) that satisfy the predicate. For example:

;(define (ends–vowel? wd) (vowel? (last wd)))
;(define (even–count? wd) (even? (count wd)))

;> (choose–beatles ends–vowel?)
;(GEORGE RINGO)

;> (choose–beatles even–count?)
;(JOHN PAUL GEORGE)


(define (ends–vowel? wd) (vowel? (last wd)))
(define (even–count? wd) (even? (count wd)))

;choose-beatles:: (X -> Y) -> List-of-words
(define (choose–beatles pred)
  ; map each member word and apply filter to it
  (keep pred '(john paul george ringo))
  )
(choose–beatles ends–vowel?)
(choose–beatles even–count?)

;8.5  Write a procedure transform–beatles that takes a procedure as an argument, applies it to each of the Beatles, 
;and returns the results in a sentence:

;(define (amazify name)
;  (word 'the–amazing–name))
;> (transform–beatles amazify)
;(THE–AMAZING–JOHN THE–AMAZING–PAUL THE–AMAZING–GEORGE
;THE–AMAZING–RINGO)
;> (transform–beatles butfirst)
;(OHN AUL EORGE INGO)

(define (transform-beatles proc)
  (every proc '(john paul george ringo))
  )

(define (amazify name)
  (word 'the-amazing '- name))
(transform-beatles amazify)
(transform-beatles bf)

#|
8.6 When you're talking to someone over a noisy radio connection, you sometimes have to spell out a word in order to 
get the other person to understand it. But names of letters aren't that easy to understand either, so there's a standard 
code in which each letter is represented by a particular word that starts with the letter. For example, instead of "B" you 
say "bravo."

Write a procedure words that takes a word as its argument and returns a sentence of the names of the letters in the 
word:
> (words 'cab)
(CHARLIE ALPHA BRAVO)
(You may make up your own names for the letters or look up the standard ones if you want.) just use 3-5.
Hint: Start by writing a helper procedure that figures out the name for a single letter

|#
(define (char->radio-word letter)
  (cond [(eq? letter 'a ) 'ALPHA]
        [(eq? letter 'b) 'BRAVO]
        [(eq? letter 'c) 'CHARLIE]
        ; pretend this is the rest
        )
  )

(define (words wd)
  (every char->radio-word wd)
  )
(words 'cab)

#|
8.7 [14.5]* Write a procedure letter–count that takes a sentence as its argument and returns the total number of 
letters in the sentence:
> (letter–count '(fixing a hole))
11
|#

(define (letter-count se)
  (accumulate + (every count se))
  )
(letter-count '(fixing a hole))

#|
8.9 What procedure can you use as the first argument to every so that for any sentence used as the second argument, 
every returns that sentence?
answer: se

What procedure can you use as the first argument to keep so that for any sentence used as the second argument, 
keep returns that sentence?
answer: se

What procedure can you use as the first argument to accumulate so that for any sentence used as the second 
argument, accumulate returns that sentence?
answer:se

|#

#|
8.10 Write a predicate true–for–all? that takes two arguments, a predicate procedure and a sentence. It should 
return #t if the predicate argument returns true for every word in the sentence. no lambda or recursion only hof
> (true–for–all? even? '(2 4 6 8))
#T
> (true–for–all? even? '(2 6 3 4))
#F
|#

(define (both-true? a b)
  (and a b))

; basically like andmap
(define (true–for–all? proc sen)
  #|
  (= (length (keep proc sen))
     (length sen) )
  |#
  )
