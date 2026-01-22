#lang simply-scheme

(define (drop-once x xs)
  (cond [(empty? xs) xs]
        [(equal? (first xs) x) (bf xs)]
        [else (se (first xs) (drop-once x (bf xs)))]
        )
  )
(drop-once 3 '(1 2 3 4 5 3))

(define (find-smallest sent)
  (define (find-smallest1 curr-smallest sentence)
    (cond [(empty? sentence) curr-smallest]
          [else (let* ((fst (first sentence))
                       (rest (bf sentence))
                       )
                  (if (before? curr-smallest fst)
                      (find-smallest1 curr-smallest rest) ;keep it
                      (find-smallest1 fst rest ) ;update cur smallest
                      )
                  )]
          )
    )
  ; initialize
  (if (empty? sent) '() (find-smallest1 (first sent) (bf sent)))
  )
(find-smallest '(4))

; selection sort (sort of)
; ss-sort:: list-of-number -> list-of-number
(define (ss-sort xs)
  (cond [(empty? xs) '()]
        [else (se (find-smallest xs) (ss-sort (drop-once (find-smallest xs) xs ))) ])
  )
(ss-sort '(i wanna be your man))

; ==================

;take
(define (take n sent)
  (cond [(empty? sent) '()]
        [(zero? n) '()]
        [else (se (first sent) (take (- n 1) (bf sent)))]
        )
  )
(take 3 '(h e l l o))

;drop
(define (drop n sent)
  (cond [(empty? sent) sent]
        [(zero? n) sent]
        [else (drop (- n 1) (bf sent))]
        )
  )


; merge:: sentence sentence -> sentence
(define (merge left right)
 (cond [(empty? left) right]
       [(empty? right) left]
       [(before? (first left) (first right)) (se (first left) (merge (bf left) right)) ] ;but left
       [else (se (first right) (merge left (bf right)))]
       )
  )
(merge '(1 4 8) '(2 5 6 10))


; merge sort
(define (mergesort sent)
  (let* ((mid (floor (/ (count sent) 2)))
        (left-half (take mid sent))
        (right-half (drop mid sent))
        )
    (cond [(<= (count sent) 1) sent]
          [(merge (mergesort left-half) (mergesort right-half) )])
    )
  )
(mergesort '(1 99 2 -100 3 64 4 5))

; ========================================
#|
15.1 write a procedure to binary
> (to–binary 9)
1001
> (to–binary 23)
10111
|#

(define (to-binary n)
  (if (equal? n 0) '(0) (to-binary1 n))
  )

(define (to-binary1 n)
   (cond [(zero? n) '()]
          [else (let* ((q (quotient n 2))
                      (r (remainder n 2))
                      )
                  (se (to-binary1 q) r)
                  )])
  )
(to-binary 0)
(to-binary 9) ;1001 => 1x8 + 1x4 + 0x2 + 1x1
(to-binary 23) ;10111 => 1x4 + 1x2 + 1x1


; ========================================

#|
15.2 A "palindrome" is a sentence that reads the same backward as forward. Write a predicate palindrome? that 
takes a sentence as argument and decides whether it is a palindrome. For example:
> (palindrome? '(flee to me remote elf))
#T
> (palindrome? '(flee to me remote control))
#F
Do not reverse any words or sentences in your solution.
|#

;palindrome?:: sentence -> boolean
(define (palindrome? sent)
  (palindrome?-helper (accumulate word sent))
  )

;palindrome?-helper:: word -> boolean
(define (palindrome?-helper wd)
  ; veyr difficult since no reverse alloweed
  ; flatten the list into words
  ; check if first xs = last xs
  ; continue until it reaches the middle
  (cond [(empty? wd) #t]
        [(empty? (bf wd)) #t]
        [else (let* ((fst (first wd))
                     (lst (last wd))
                     (drop-fl (bl (bf wd)))
                     )
                (cond [(equal? fst lst) (palindrome?-helper drop-fl)] ;drop both first and last
                      [else #f])
                )]
        )
  )
; maybe i'/m overcomplicating this?
(palindrome? '()) ;vacuously true
(palindrome? '(flee to me remote elf))
(palindrome? '(ba o ab)) ; should return true
(palindrome? '(he eh))
(palindrome? '(flee to me remote control))

; ========================================

#|
15.3 Write a procedure substrings that takes a word as its argument. It should return a sentence containing all of 
the substrings of the argument. A substring is a subset whose letters come consecutively in the original word. For 
example, the word bat is a subset, but not a substring, of brat.
|#

; helper to find substring
(define (subst wd)
  (cond [(empty? wd) '()]
        [else (se  wd (subst (bl wd)))])
  )
(subst 'power) ;'(p po pow powe power)
(subst 'ower) ;'(o ow owe ower)

; word -> sentence
(define (substring wd)
  (cond [(empty? wd) '()]
        [else (se (subst wd) (substring (bf wd)) )]
        )
  )
(substring 'cat)

; ========================================

#|
15.4 Write a predicate procedure substring? that takes two words as arguments and returns #t if and only if the 
first word is a substring of the second. (See Exercise 15.3 for the definition of a substring.)
Be careful about cases in which you encounter a "false start," like this:
> (substring? 'ssip 'mississippi)
#T
and also about subsets that don't appear as consecutive letters in the second word:
Page 244
> (substring? 'misip 'mississippi)
#F
|#

; helper that checks if next wd contains
(define (starts-with? wd1 wd2)
  (cond [(empty? wd1) #t]
        [(empty? wd2) #f]
        [(equal? (first wd1) (first wd2)) (starts-with? (bf wd1) (bf wd2))]
        [else #f]
        )
  )
(starts-with? 'mis 'mississippi)

; word word -> boolean
(define (substring? wd1 wd2)
  ; scanning 'window'
  ; maybe im' overcomplicating this?
  (cond [(empty? wd1) #t]
        [(empty? wd2) #f]
        [(starts-with? wd1 wd2) #t]
        [else (substring? wd1 (bf wd2))]
        )
  
  )
(substring? 'ssip 'mississippi)


#|
15.5 Suppose you have a phone number, such as 223-5766, and you'd like to figure out a clever way to spell it in 
letters for your friends to remember. Each digit corresponds to three possible letters. For example, the digit 2 
corresponds to the letters A, B, and C. Write a procedure that takes a number as argument and returns a sentence of all 
the possible spellings:
> (phone–spell 2235766)
(AADJPMM AADJPMN ... CCFLSOO)
(We're not showing you all 2187 words in this sentence.) You may assume there are no zeros or ones in the number, 
since those don't have letters.
Hint: This problem has a lot in common with the subsets example.
|#

; lookup list for num words
(define num-sents '(() (A B C) (D E F) (G H I) (J K L) (M N O) (P Q R S) (T U V) (W X Y Z))
  )

; assume no zeroes or ones
; helper that convers nm to possible letters
(define (num->sent n)
  (item n num-sents)
  )
(num->sent 7) ;should return '(A B C)

; word sentence -> sentence
(define (prepend-every wd sent)
  (cond [(empty? sent) '()]
        [else (se (word wd (first sent)) (prepend-every wd (bf sent)))]
        )
  )
(prepend-every 'g '())

(define (phone-spell n)
  (cond [(empty? n) (se "")]
        [else (let* ((curr-num-sent (num->sent (first n)))
                     (rest (phone-spell (bf n))))
                (every (λ (char) (prepend-every char rest) ) curr-num-sent)
                )]
        )
  )
(phone-spell 4) ; (D E F)
(phone-spell 34)

#|
prepend every A '(D E F) -> AD AE AF
prepend eveyr B '(D E F) -> BD BE BF
prepend every C '(D E F) -> CD CE CF
|#

#|
15.6 Let's say a gladiator kills a roach. If we want to talk about the roach, we say "the roach the gladiator killed." But if 
we want to talk about the gladiator, we say "the gladiator that killed the roach."
People are pretty good at understanding even rather long sentences as long as they're straightforward: "This is the 
farmer who kept the cock that waked the priest that married the man that kissed the maiden that milked the cow that 
tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built." But even a 
short nested sentence is confusing: "This is the rat the cat the dog worried killed." Which rat was that?
Write a procedure unscramble that takes a nested sentence as argument and returns a straightforward sentence 
about the same cast of characters:
> (unscramble '(this is the roach the gladiator killed))
(THIS IS THE GLADIATOR THAT KILLED THE ROACH)
> (unscramble '(this is the rat the cat the dog the boy the
                     girl saw owned chased bit))
(THIS IS THE GIRL THAT SAW THE BOY THAT OWNED THE DOG THAT
      CHASED THE CAT THAT BIT THE RAT)
You may assume that the argument has exactly the structure of these examples, with no special cases like "that lay in 
the house" or "that Jack built."
|#

; helper that removes 'the
(define (remove wd sent)
  (cond [(empty? sent) '()]
        [(equal? wd (first sent)) (remove wd (cdr sent))]
        [else (se (first sent) (remove wd (bf sent)))]
        )
  )

; get the verbs after the last occurence of "the"
(define (verbs sent)
  (cond [(empty? sent) '()]
        [(empty? (bl sent)) '()]
        [(equal? (last (bl sent)) 'the) '()]; stop
        [else (se (verbs (bl sent)) (last sent) ) ]
        )
  )
(verbs '(this is the roach the gladiator killed)) ;'(killed)
(verbs '(this is the rat the cat the dog the boy the girl saw owned chased bit)) ;(saw owned chased bit)



; get the names before the last occurence of "the"
(define (names sent)
  (cond [(empty? sent) '()]
        [(empty? (bf sent)) '()]
        [(equal? (first sent) 'the) ]
        )
  )
(names '(the roach the gladiator killed)) ;'((the roach) (the gladiator))
(names '(the rat the cat the dog the boy the girl saw owned chased bit))
;((the rat) (the cat) (the dog) (the boy) (the girl))


; sentence -> sentence
(define (unscramble sent)
  ;lets try to get the logic fist
  ; last occurence of the => becomes the first
  ; when there is a "the", you add "that" afterward
  ; the words after the last the is the verb. order it like it is
  ; need: extract the person/enitty name after "the"
  ; need: get the verbs after the last "the"
  0
  )
(unscramble '(this is the roach the gladiator killed))
(unscramble '(this is the rat the cat the dog the boy the girl saw owned chased bit) )