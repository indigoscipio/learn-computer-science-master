#lang racket


#|
PROBLEM 17:: Number Letter Counts
if the total numbers 1 to 5 are written out in words:
one, two, three, four, five, then there are 3+3+5+4+4 = 19 letters used in total

if all the numbers from 1 to 1000 inclusive were written out in words,
how many letters would be used?

note: do not count spaces or hypens
for example, 342 (three hundred and forty two) contiains 23 letters
and 115 (one hundred and fifteen) contains 20 letters.
the use of 'and' when writing out numbers is in compliance with british usage.

answer:
ok i feel likei've encountered this before but i dont remember the exact approach

i hope im not overcomplicating here
first i think we need a map for number to letter
since we're looking for numbers from 1 - 1000, we will need
base units, tens, teens, and hundreds.

then we need the basic logic to wire up the numbers to those letter to form a word
following the proper wording with 'and' - in compliance with british usage.

once we have the translator ready, we can genereate the word from up to 1000
then for each of those sum up the letter count (excluding spaces or hypens)

|#

; a word is a symbol
; a sentence is a list of words/symbols

; THE NUMBERS MAP
; given a base unit digit, gives back its letter representation
; number -> word

(define (digit->word d)
  (cond [(equal? d 0) 'zero]
        [(equal? d 1) 'one]
        [(equal? d 2) 'two]
        [(equal? d 3) 'three]
        [(equal? d 4) 'four]
        [(equal? d 5) 'five]
        [(equal? d 6) 'six]
        [(equal? d 7) 'seven]
        [(equal? d 8) 'eight]
        [(equal? d 9) 'nine]
        )
  )

; number->word
(define (teens->word t)
  (cond [(equal? t 10) 'ten]
        [(equal? t 11) 'eleven]
        [(equal? t 12) 'twelve]
        [(equal? t 13) 'thirteen]
        [(equal? t 14) 'fourteen]
        [(equal? t 15) 'fifteen]
        [(equal? t 16) 'sixteen]
        [(equal? t 17) 'seventeen]
        [(equal? t 18) 'eighteen]
        [(equal? t 19) 'nineteen]
        )
  )

; number->word
(define (tens->word tn)
  (cond [(equal? tn 2) 'twenty]
        [(equal? tn 3) 'thirty]
        [(equal? tn 4) 'forty]
        [(equal? tn 5) 'fifty]
        [(equal? tn 6) 'sixty]
        [(equal? tn 7) 'seventy]
        [(equal? tn 8) 'eighty]
        [(equal? tn 9) 'ninety]
        )
  )

;number->word
(define (hundreds->word h)
  (cond [(equal? h 1) 'one-hundred]
        [(equal? h 2) 'two-hundred]
        [(equal? h 3) 'three-hundred]
        [(equal? h 4) 'four-hundred]
        [(equal? h 5) 'five-hundred]
        [(equal? h 6) 'six-hundred]
        [(equal? h 7) 'seven-hundred]
        [(equal? h 8) 'eight-hundred]
        [(equal? h 9) 'nine-hundred]
        )
)


#|
THE LOGIC THAT TRANSLATES NUM -> SENTENCE PROPERLY
5 -> '(five)
20 -> '(twenty)
25 -> '(twenty-five) - tens = 2, units = 5, connect with hyphen.
100 ->  '(one-hundred) -> hundred = 1, tens = 0, units = 0
200 -> '(two-hundred) -> hundred = 2
105 -> '(one-hundred and five) -> hundred = 1, tens = 0, unit = 0
342 -> '(three-hundred and forty two) -> hundred = 3, tens = 4, unit = 2
1000 -> '(one-thousand) -> maybe a special case here

How does translate-tens handle 42?
It needs to produce '(forty two).
Does it do that alone, or does it call one of the other helpers to get the two part?
That answer will tell you how these helpers compose with each other — which is the real insight here.
|#

; given n from 1 - 9, returns its correct translated form.
(define (translate-digit n)
  (list (digit->word n))
  )

; given n from 10 - 99, returns its correct translated form
(define (translate-tens n)
  (let ((d (remainder n 10))
        (t (quotient n 10)))
    (cond [(= 1 t) (list (teens->word n))] ; just call teens
          [(zero? d) (list (tens->word t))] ;base digit is 0, just call tens
          [else (list (tens->word t) (digit->word d))]
          )
    )
  )
(translate-tens 11) ;'(eleven)
(translate-tens 42) ;'(forty two)
(translate-tens 20) ;'(twenty)
(translate-tens 99) ;'(twenty)

; given n from 100 - 999, returns its correct translated form
(define (translate-hundreds n)
  (let ((d (remainder n 10))
        (r (remainder n 100))
        (t (quotient n 10))
        (h (quotient n 100))
        )
    (cond [(zero? r) (list (hundreds->word h))] ;tens and base is 0
          [(and (> r 0) (< r 10)) (list (hundreds->word h) 'and (digit->word d)) ] ; digit is 1 < d < 9
          [(and (> r 9) (< r 20)) (list (hundreds->word h) 'and (teens->word r)) ]
          [else (append (list (hundreds->word h)) '(and) (translate-tens r) )])
    )
  )

; remainder is 0
(translate-hundreds 100) ; '(one-hundred)

; remainder is 1-9 (needs 'and')
(translate-hundreds 101) ; '(one-hundred and one)
(translate-hundreds 305) ; '(three-hundred and five)

; remainder is 10-19 (teens, needs 'and')
(translate-hundreds 110) ; '(one-hundred and ten)
(translate-hundreds 115) ; '(one-hundred and fifteen)

; remainder is 20-99 (tens, needs 'and')
(translate-hundreds 120) ; '(one-hundred and twenty)
(translate-hundreds 123) ; '(one-hundred and twenty-three)
(translate-hundreds 342) ; '(three-hundred and forty two)
(translate-hundreds 999) ; '(nine-hundred and ninety nine)

; given a number from 1 - 1000, translates to its proper word
(define (translate n)
  (cond [(and (> n 0) (< n 10)) (translate-digit n)] ;digits: 1 - 9
        [(and (> n 9) (< n 100)) (translate-tens n)] ;tens: 10 - 99
        [(and (> n 99) (< n 1000)) (translate-hundreds n)] ;hundreds: 100 - 999
        [else '(one thousand)]
        )
 )
(display 'TRANSLATE)(newline)
(translate 123)
(translate 999)
(translate 1000)
(translate 1)
(translate 9)
(translate 11)
(translate 99)
(translate 450)

; returns true if a letter is not a hyphen or space 
(define (is-valid-letter? char)
  (not (or (equal? char #\-) (equal? char #\space)))
  )

; given a word, counts its letters
(define (count-letters sym)
    (let* ((chars (string->list (symbol->string sym)))
          (valid-chars (map (λ (c) (is-valid-letter? c) ) chars))
          )
      (foldr (λ (x acc) (if x (+ 1 acc) acc) ) 0 valid-chars)
      )
  )
(display 'count-letters) (newline)
(count-letters 'fourty-two) ; 9
(count-letters 'sixteen) ; 7
(count-letters 'twenty) ; 6


; THE MAIN FUNCTION
; given a number, calculates all total number letters count representation from 1 to n
(define (number-letter-counts n)
  
  (define (loop curr-n result)
    (cond [(<= curr-n 0) result]
          [else (loop (- curr-n 1) (cons (translate curr-n) result) ) ]))

  (let ((num-words (loop n '()) ))
    (foldr + 0 (map (λ (xs) (foldr + 0 (map (λ (sym) (count-letters sym) ) xs)) ) num-words))
    )  
  )
(number-letter-counts 2) ;should return total letters in 'one two' -> 3+3 = 6
(number-letter-counts 3) ; total letters in 'one two three' -> 3+3+5 = 11
(number-letter-counts 4) ; totla letters in 'one two three four' -> 3+3+5+4 = 15
(number-letter-counts 5) ; 3+3+5+4+4 = 19
(number-letter-counts 15) ; returns 74
(number-letter-counts 50) ;returns 389
(number-letter-counts 1000) ;returns 21124
