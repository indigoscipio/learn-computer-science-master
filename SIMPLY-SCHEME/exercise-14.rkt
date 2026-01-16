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
  (cond [(empty? sent) '()]
        [(empty? (bf sent)) '()]
        [else (se (- (first (bf sent)) (first sent)  ) (differences (bf sent))) ]
        )
  )
(differences '(4 23 9 87 6 12)) ;should return (19 –14 78 –81 6)

#|
14.8 Write expand, which takes a sentence as its argument. It returns a sentence similar to the argument, except that 
if a number appears in the argument, then the return value contains that many copies of the following word:
> (expand '(4 calling birds 3 french hens))
(CALLING CALLING CALLING CALLING BIRDS FRENCH FRENCH FRENCH HENS)
> (expand '(the 7 samurai))
(THE SAMURAI SAMURAI SAMURAI SAMURAI SAMURAI SAMURAI SAMURAI)
|#

;helper that applies n times
; number word -> word
(define (repeat n wd)
  (cond [(zero? n) '()]
        [else (se wd (repeat (- n 1) wd)) ])
  )
(repeat 7 'samurai)


(define (expand sent)
  (cond [(empty? sent) '()]
        [(number? (first sent)) (if (empty? (bf sent))
                                    '()
                                    (se (repeat (first sent) (first (bf sent)) ) (expand (bf (bf sent))))) ]
        [else (se (first sent) (expand (bf sent)) )]
        )
  )
(expand '(4 calling birds 3 french hens 6 hey 8))
(expand '(the 7 samurai))

#|
14.9 Write a procedure called location that takes two arguments, a word and a sentence. It should return a number 
indicating where in the sentence that word can be found. If the word isn't in the sentence, return #f. If the word 
appears more than once, return the location of the first appearance.
> (location 'me '(you never give me your money))
4
|#

; word sentence -> maybeNumber
; pattern: keep
(define (location wd sent)
  (cond [(empty? sent) #f]
        [(equal? wd (first sent)) 1]
        [else (let ((rest (location wd (bf sent)) ))
                (if (number? rest)
                    (+ 1 rest)
                    #f
                    )
                ) ]
        )
  )
;(location 'give '(you never give me your money))

#|
14.10 Write the procedure count–adjacent–duplicates that takes a sentence as an argument and returns the 
number of words in the sentence that are immediately followed by the same word:
> (count–adjacent–duplicates '(y a b b a d a b b a d o o))
3
> (count–adjacent–duplicates '(yeah yeah yeah))
2
|#

; small helper function

; needs to find a way to slide/drop
; maybe im overcomplicating this
(define (count-adjacent-duplicates se)
  (cond [(empty? se) 0]
        [(empty? (bf se)) 0]
        [(equal? (first se) (first (bf se))) (+ 1 (count-adjacent-duplicates (bf se)))]
        [else (count-adjacent-duplicates (bf se))]
        )
  )
(count-adjacent-duplicates '(y a b b a d a b b a d o o)) ;return 3
(count-adjacent-duplicates '(yeah yeah yeah)) ; return 2

; check if the current word is equal to the next one, if so increase the counter

#|
14.11 Write the procedure remove–adjacent–duplicates that takes a sentence as argument and returns the 
same sentence but with any word that's immediately followed by the same word removed:
> (remove–adjacent–duplicates '(y a b b a d a b b a d o o))
(Y A B A D A B A D O)
> (remove–adjacent–duplicates '(yeah yeah yeah))
(YEAH)
|#

;; sent -> sent
(define (remove-adjacent-duplicates sent)
  (cond [(empty? sent) '()]
        [(empty? (bf sent)) sent]
        [(equal? (first sent) (first (bf sent))) (remove-adjacent-duplicates (bf sent))]
        [else (se (first sent) (remove-adjacent-duplicates (bf sent))) ])
  )
; maybe im overcomplicating this?
(remove-adjacent-duplicates '(y a b b a d a b b a d o o))
(remove-adjacent-duplicates '(yeah yeah yeah))

#|
14.12 Write a procedure progressive–squares? that takes a sentence of numbers as its argument. It should 
return #t if each number (other than the first) is the square of the number before it:

> (progressive–squares? '(3 9 81 6561))
#T
> (progressive–squares? '(25 36 49 64))
#F
|#

(define (sqr n) (* n n))

; feels like a mix of keep + accum pattern
; check if curr n^2 = next num, if so chain it
(define (progressive-squares? se)
  (cond [(empty? se) #t]
        [(empty? (bf se)) #t] ;one more item in the list, since theres nothing to compare return true?
        [(equal? (sqr (first se)) (first (bf se))) (progressive-squares? (bf se))]
        [else #f]
        )
  )
; am i overcomplicating this?
(progressive-squares? '(3 9 81 6561))
(progressive-squares? '(25 36 49 64))




#|
14.14 Write a predicate same–shape? that takes two sentences as arguments. It should return #t if two conditions 
are met: The two sentences must have the same number of words, and each word of the first sentence must have the 
same number of letters as the word in the corresponding position in the second sentence.
> (same–shape? '(the fool on the hill) '(you like me too much))
#T
> (same–shape? '(the fool on the hill) '(and your bird can sing))
#F
|#

; sentence sentence -> boolean
(define (same-shape? se1 se2)
  ; recurse on se1
  ; first, compare the word lenghth of se1 and se2, if its not equal, return false
  ; if true, then check each letter count for each word
  (cond [(and (empty? se1) (empty? se2)) #t] ;no more words to check, return true
        [(or (empty? se1) (empty? se2)) #f]
        [(= (count (first se1)) (count (first se2))) (same-shape? (bf se1) (bf se2))]
        [else #f]
        )
  )
; maybe i'm  overcomplicating this?
(same-shape? '(the foot on the hill) '(you like me too much)) ;should return #t
(same-shape? '(the foot on the hill) '(and bird can sing)) ;should return #f

; ---------------------------------------------------

#|
14.15 Write merge, a procedure that takes two sentences of numbers as arguments. Each sentence must consist of 
numbers in increasing order. Merge should return a single sentence containing all of the numbers, in order. (We'll use 
this in the next chapter as part of a sorting algorithm.)
> (merge '(4 7 18 40 99) '(3 6 9 12 24 36 50))
(3 4 6 7 9 12 18 24 36 40 50 99)

|#
; sentence sentence -> sentence
(define (merge se1 se2)
  ;recurse on both se1 and se2
  ; if x < y, put x in front of the list and recurse on se1
  ; if y < x, put y in front of the list and recurse on se2
  (cond [(empty? se1) se2]
        [(empty? se2) se1]
        [(< (first se1) (first se2)) (se (first se1) (merge (bf se1) se2) )]
        [else (se (first se2) (merge se1 (bf se2)) )]
        )
  )
; feels like im maybe overcomplicating it?
(merge '() '(1 2 3)) ; just reutrn se2
(merge '(1 2 3) '()) ; just reutrn se1
(merge '() '()) ; reutrn ()
(merge '(4 7 18 40 99) '(3 6 9 12 24 36 50)) ;should return (3 4 6 7 9 12 18 24 36 40 50 99)

#|
14.16 Write a procedure syllables that takes a word as its argument and returns the number of syllables in the 
word, counted according to the following rule: the number of syllables is the number of vowels, except that a group of 
consecutive vowels counts as one. For example, in the word "soaring," the group "oa" represents one syllable and the 
vowel "i" represents a second one.
Be sure to choose test cases that expose likely failures of your procedure. For example, what if the word ends with a 
vowel? What if it ends with two vowels in a row? What if it has more than two consecutive vowels?
(Of course this rule isn't good enough. It doesn't deal with things like silent "e"s that don't create a syllable ("like"), 
consecutive vowels that don't form a diphthong ("cooperate"), letters like "y" that are vowels only sometimes, etc. If 
you get bored, see whether you can teach the program to recognize some of these special cases.)
|#

; helper that detects vowel
(define (is-vowel? char) (member? char 'aiueo))

; helper that detects if a vowel is followed by another vowel
(define (is-consc-vowels? wd)
  0
  )

; so we know the rule
; no of sy = no of vowels except group of consecutive vowels count as one
; soaring -> oa = 1, i = 1, total = 2
; lets try to approach this as simple as possible
(define (syllables wd)
  (cond [(empty? wd) 0]
        [(empty? (bf wd)) (if (is-vowel? wd)
                              1
                              0
                              )]
        [ (not (is-vowel? (first wd))) (syllables (bf wd))] ; consonant case
        [else (let ((curr-char (first wd))
                    (next-char (first (bf wd)))
                    )
                (cond [(and (is-vowel? curr-char) (not (is-vowel? next-char)) ) (+ 1 (syllables (bf wd)))] ; end of group, count
                      [else (syllables (bf wd))])
                ) ] ;vowel case
        )
  )
(syllables 'cat) ; 1
(syllables 'apple) ;2
(syllables 'banana) ; 3
(syllables 'education) ; 4
(syllables 'kwcgt) ;0


; ================= PROJECT =====================

(define base-digit '(one two three four five six seven eight nine))
(define teens '(ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen))

; number -> sentence
; given a positive integer n, reutrn a sentence with that number spelled out in words
(define (number-name n)
  ; if its <= 9, use base digit
  (cond [(<= n 9) (item n base-digit)]
        [(<= n 19) (item (- n 9) teens)]
        [else 8])
  )
(number-name 19)