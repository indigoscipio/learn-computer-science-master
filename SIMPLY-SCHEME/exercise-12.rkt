#lang simply-scheme

#|
Boring Exercises
12.1 Here is a definition of a procedure that returns the sum of the numbers in its argument sentence:
(define (addup nums)
  (if (empty? (bf nums))
      (first nums)
      (+ (first nums) (addup (bf nums)))))
Although this works, it could be simplified by changing the base case. Do that.

|#


(define (addup nums)
  (if (empty? nums)
      0
      (+ (first nums) (addup (bf nums))))
  )
(addup '(1 2 3))

#|
12.2 Fix the bug in the following definition:
(define (acronym sent)                  ;; wrong
  (if (= (count sent) 1)
      (first sent)
      (word (first (first sent))
            (acronym (bf sent)))))
|#

(define (acronym sent)
  (if (empty? sent)
      ""
      (word (first (first sent))
            (acronym (bf sent))))
  )
(acronym '(hey there how are you))

#|
12.3 Can we reduce the factorial base case argument from 0 to –1? If so, show the resulting procedure. If not, 
why not?

we cannot because factorial of negative number is undefined

when it goes down to (factorial 0) it should return 1
it always return multiplied by 0

|#

#|
heres a definition of function f

f(sent) = sent if sent is empty,
other wise sent(f(sent(sent)),first(sent))
|#

(define (f sent)
  (cond [(empty? sent) '()]
        [else (se (f (bf sent)) (first sent) ) ])
  )
(f '(hello you))

; it reverses a sentence


#|
Real Exercises
Page 204
Solve all of the following problems with recursive procedures. If you've read Part III, do not use any higher-order 
functions such as every, keep, or accumulate.
12.5 [8.8] Write an exaggerate procedure which exaggerates sentences:
> (exaggerate '(i ate 3 potstickers))
(I ATE 6 POTSTICKERS)
> (exaggerate '(the chow fun is good here))
(THE CHOW FUN IS GREAT HERE)
It should double all the numbers in the sentence, and it should replace "good" with "great," "bad" with "terrible," and 
anything else you can think of.
|#


; lets just keep the logic simple, double number and word only 'good -> great and bad -> teribble
(define (exaggerate-item x)
  (cond [(number? x) (* x x)]
        [(equal? x 'good) 'great]
        [(equal? x 'bad) 'teribble]
        [else x]
        )
  )

; sentence -> sentence
(define (exaggerate sent)
  (cond [(empty? sent) '()]
        [else (se (exaggerate-item (first sent)) (exaggerate (bf sent)) )])
  )
(exaggerate '(i ate 3 potstickers))

#|
2.6 [8.11] Write a GPA procedure. It should take a sentence of grades as its argument and return the corresponding 
grade point average:
> (gpa '(A A+ B+ B))
3.67
Hint: write a helper procedure base–grade that takes a grade as argument and returns 0, 1, 2, 3, or 4, and another 
helper procedure grade–modifier that returns –.33, 0, or .33, depending on whether the grade has a minus, a plus, 
or neither.
|#
; grade-modifier:: word -> number
; given a letter grade, returns a modifier based on its last sign
(define (grade-modifier grade)
  (cond [(eq? (last grade) '+) 0.33]
        [(eq? (last grade) '-) -0.33]
        [else 0]
        )
  )
(grade-modifier 'A-)

; base-grade:: word -> number
; given a letter grade, returns its grade point
(define (base-grade grade)
  (cond [(equal? (first grade) 'A) (if (equal? grade 'A+) 4.0 (+ (grade-modifier grade) 4)) ]
        [(equal? (first grade) 'B) (+ (grade-modifier grade) 3)]
        ; lets just do 2 for now
        )
  )

(define (sum-grades grades)
  (cond [(empty? grades) 0]
        [else (+ (base-grade (first grades)) (sum-grades (bf grades)) )])
  )

(define (gpa grades)
  (let ((result ( sum-grades grades)))
    (/ result (count grades))
    )
  )
(gpa '(A A+ B+ B))

#|
12.7 Write a procedure spell–number that spells out the digits of a number:
> (spell–number 1971)
(ONE NINE SEVEN ONE)
Use this helper procedure:
(define (spell–digit digit)
  (item (+ 1 digit)
        '(zero one two three four five six seven eight nine))
|#

(define (spell-digit digit)
  (item (+ 1 digit)
        '(zero one two three four five six seven eight nine)))


(define (spell-number digits)
  (cond [(empty? digits) '()]
        [else (se (spell-digit (first digits)) (spell-number (bf digits)) )])
  )
(spell-number 1971)

#|
12.8 Write a procedure numbers that takes a sentence as its argument and returns another sentence containing only 
the numbers in the argument:
Page 205
> (numbers '(76 trombones and 110 cornets))
(76 110)
|#

(define (numbers sent)
  (cond [(empty? sent) '()]
        [(number? (first sent)) (se (first sent) (numbers (bf sent)))] ; keep it
        [else (numbers (bf sent))]
        )
  )
(numbers '(76 trombones and 110 cornets))

#|
12.9 Write a procedure real–words that takes a sentence as argument and returns all the "real" words of the 
sentence, using the same rule as the real–word? procedure from Chapter 1.
|#

(define (real-word? wd)
  (and (not (number? wd)) (> (count wd) 1))
  )

(define (real-words sent)
  (cond [(empty? sent) '()]
        [else (se (real-words (first sent)) (real-words (bf sent))) ])
  )


#|
12.10 Write a procedure remove that takes a word and a sentence as arguments and returns the same sentence, but 
with all copies of the given word removed:
> (remove 'the '(the song love of the loved by the beatles))
(SONG LOVE OF LOVED BY BEATLES)
|#

(define (remove wd sent)
  (cond [(empty? sent) '()]
        [(equal? wd (first sent)) (remove wd (bf sent))]
        [else (se (first sent) (remove wd (bf sent))) ]
        )
  )
(remove 'the '(the song love of the loved by the beatles))

#|
12.11 Write the procedure count, which returns the number of words in a sentence or the number of letters in a word
|#
(define (count-word wd)
  (cond [(equal? wd "") 0]
        [else (+ 1 (count-word (bf wd)))])
  )
(count-word 'hello)

(define (count-sent sent)
  (cond [(empty? sent) 0]
        [else (+ 1 (count-sent (bf sent)))])
  )
(count-sent '(1 2 3 4 5))

(define (my-count wordsent)
  (if (sentence? wordsent)
      (count-sent wordsent)
      (count-word wordsent)
      )
  )


#|
12.12 Write a procedure arabic which converts Roman numerals into Arabic numerals:
> (arabic 'MCMLXXI)
1971
> (arabic 'MLXVI)
1066
|#

(define (roman->num wd)
  (cond [(equal? wd 'I) 1]
        [(equal? wd 'V) 5]
        [(equal? wd 'X) 10]
        [(equal? wd 'L) 50]
        [(equal? wd 'C) 100]
        [(equal? wd 'D) 500]
        [else 1000] ;lets just assume inptus are valid and else is M
        )
  )
(roman->num 'I)
(roman->num 'L)


(define (arabic roman-wd)
  (cond [(empty? roman-wd) 0]
        [(empty? (bf roman-wd)) (roman->num roman-wd)]
        [else (let* ((first-letter (first roman-wd))
                    (second-letter (first (bf roman-wd)))
                    (first-value (roman->num first-letter))
                    (second-value (roman->num second-letter))
                    )
                (if (< first-value second-value)
                    (- (arabic (bf roman-wd)) first-value)
                    (+ (arabic (bf roman-wd)) first-value)
                    )
                ) ])
  )
(arabic 'MCMLXXI)
(arabic 'MLXVI)

(define (double wd) (word wd wd))
(trace double)
(double 'frozen)(double (double (double 'yum)))


; boring exercise
(explode 'ape)