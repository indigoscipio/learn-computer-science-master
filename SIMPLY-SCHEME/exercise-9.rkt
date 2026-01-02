#lang simply-scheme

(define (square n) (* n n))

#|
9.1 what will scheme print? figure it out before try it on the compuer


(lambda (x) (+ (* x 3) 4))
; returns  a procedure/lambda

((lambda (x) (+ (* x 3) 4)) 10)
;34

(every (lambda (wd) (word (last wd) (bl wd)))
       '(any time at all))
;yan etim ta lal

((lambda (x) (+ x 3)) 10 15)
; error

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|

9.2 Rewrite the following definitions so as to make the implicit lambda explicit.
1. (define (second stuff)
  (first (bf stuff)))
2. (define (make-adder num)
  (lambda (x) (+ num x)))

(lambda (stuff) (first (bf stuff)))
(((lambda (num) (lambda (x) (+ num x)) ) 3) 5)

|#

#|
9.3 What does this procedure do?
(define (let-it-be sent)
  (accumulate (lambda (x y) y) sent))

answer:
the procedure takes sent which is a list
example sent = '(1 2 3) or can be words
then insidie accum it checks

'(2 3) -> return 3
next call '(1 3) -> return 3

so it only retunrs the last thing in the list

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
real exercisel
9.4
The following program doesn't work. Why not? Fix it


(define (who sent)
  (every describe '(pete roger john keith)))

(define (describe person)
  (se person sent))

> (who '(sells out))
(pete sells out roger sells out john sells out keith sells out)

|#

; it doesn't work because the sent inside (describe person) is not defined and only exists within who
; to fix it just define replace describe proc as anonymous lambda

#|
(define (who sent)
  (every (lambda (person) (se person sent) ) '(pete roger john keith)))

(who '(sells out))
|#

; or alternatively make describe take 2 args


#|

In each of the following exercises, write the procedure in terms of lambda and higher-order functions. Do not use 
named helper procedures. If you've read Part IV, don't use recursion, either.

9.5 write prepend-every

> (prepend–every 's '(he aid he aid))
(SHE SAID SHE SAID)

> (prepend–every 'anti '(dote pasto gone body))
(ANTIDOTE ANTIPASTO ANTIGONE ANTIBODY)

|#

(define (prepend-every wd sent)
  (every (lambda (x) (word wd x) ) sent)
  )


#|

9.6 Write a procedure sentence–version that takes a function F as its argument and returns a function G. F 
should take a single word as argument. G should take a sentence as argument and return the sentence formed by 
applying F to each word of that argument.

|#

(define (sentence-version f)
  (lambda (sent) (every f sent) )
  )
((sentence-version first) '(if i fell))
((sentence-version square) '(8 2 4 6 ))

#|
9.7 Write a procedure called letterwords that takes as its arguments a letter and a sentence. It returns a sentence 
containing only those words from the argument sentence that contain the argument letter:

> (letterwords 'o '(got to get you into my life))
(GOT TO YOU INTO)

|#

(define (letterwords target-letter sent)
  ; for each word in sentence, check if target letter is in each word
  ; if so, keep it, else don't
  (keep (lambda (wd) (member? target-letter wd) ) sent)
  )
(letterwords 'o '(got to get you into my life) )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
9.8
Suppose we're writing a program to play hangman. In this game one player has to guess a secret word chosen by 
the other player, one letter at a time. You're going to write just one small part of this program: a procedure that takes as 
arguments the secret word and the letters guessed so far, returning the word in which the guessing progress is 
displayed by including all the guessed letters along with underscores for the not-yet-guessed ones:

> (hang 'potsticker 'etaoi)–OT–TI––E
Hint: You'll find it helpful to use the following procedure that determines how to display a single letter:
(define (hang–letter letter guesses)
  (if (member? letter guesses)
      letter
      '–))

|#

; hang-letter:: word word -> word
(define (hang-letter letter guesses)
  (if (member? letter guesses)
      letter
      '-))
; secret word letter guessed so far -> word in which guessing progress is displayed
; hang:: word word -> word
(define (hang secret-wd lgsf)
  ; for each letter in secret word
  ; i want to check if each letter is a member within letters-guessed-so-far, with the helper
  (accumulate word (every (lambda (letter) (hang-letter letter lgsf) ) secret-wd))
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
9.9  Write a procedure common–words that takes two sentences as arguments and returns a sentence containing only 
those words that appear both in the first sentence and in the second sentence.

|#

(define (common-words s1 s2)
  ;for each words in s1, check if each word in s2 also equals to that word
  (keep (λ (wd1) (member? wd1 s2) ) s1)
  )
;(common-words '(hello there you) '(hello you there)) ; '(hello you)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
9.10 In Chapter 2 we used a function called appearances that returns the number of times its first argument appears 
as a member of its second argument. Implement appearances.
|#

;appearances: number/wd sentence -> number
(define (appearances target xs)
  ; for each item x in xs, check if x = target
  ; if so, count it, if no skip i
  (count (keep (λ (x) (equal? x target) ) xs))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
9.11 Write a procedure unabbrev that takes two sentences as arguments. It should return a sentence that's the same 
as the first sentence, except that any numbers in the original sentence should be replaced with words from the second 
sentence. A number 2 in the first sentence should be replaced with the second word of the second sentence, a 6 with 
the sixth word, and so on

> (unabbrev '(john 1 wayne fred 4) '(bill hank kermit joey))
(JOHN BILL WAYNE FRED JOEY)
> (unabbrev '(i 3 4 tell 2) '(do you want to know a secret?))
(I WANT TO TELL YOU)

|#

(define (unabbrev s1 s2)
  ; for each word in s1, check if it contains a number
  ; if so, replace that number with the xth item in s2
  (every (λ (wd) (if (number? wd)
                     (item wd s2)
                     wd
                     )) s1)
  )
(unabbrev '(john 1 wayne fred 4) '(bill hank kermit joey))
(unabbrev '(i 3 4 tell 2) '(do you want to know a secret?))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|

9.12 Write a procedure first–last whose argument will be a sentence. It should return a sentence containing only 
those words in the argument sentence whose first and last letters are the same

> (first–last '(california ohio nebraska alabama alaska massachusetts))
(OHIO ALABAMA ALASKA)

|#

(define (first-last sent)
  ; for each word insent, check if its first letter = last letter
  ; if so keep it. else just skip it
  (keep (λ (wd) (equal? (first wd) (last wd) ) ) sent)
  )
(first-last '(california ohio nebraska alabama alaska massachusetts))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
9.13 Write a procedure compose that takes two functions f and g as arguments. It should return a new function, the 
composition of its input functions, which computes f(g(x)) when passed the argument x.

> ((compose sqrt abs) –25)
5
> (define second (compose first bf))
> (second '(higher order function))
ORDER

|#

(define (compose f g)
  (lambda (arg) (f (g arg)) )
  )

((compose sqrt abs) -25)

#|
9.14 Write a procedure substitute that takes three arguments, two words and a sentence. It should return a version 
of the sentence, but with every instance of the second word replaced with the first word:
> (substitute 'maybe 'yeah '(she loves you yeah yeah yeah))
(SHE LOVES YOU MAYBE MAYBE MAYBE)
|#

(define (substitute new-wd old-wd sent)
  ; for every word in sent, check if its equal to old wd
  ; if so, replace it with the new word
  (every (λ (wd) (if (equal? wd old-wd)
                     new-wd
                     wd
                     ) ) sent)
  )
(substitute 'maybe 'yeah '(she loves you yeah yeah yeah))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


#|
9.15 Many functions are applicable only to arguments in a certain domain and result in error messages if given 
arguments outside that domain. For example, sqrt may require a nonnegative argument in a version of Scheme that 
doesn't include complex numbers. (In any version of Scheme, sqrt will complain if its argument isn't a number at 
all!) Once a program gets an error message, it's impossible for that program to continue the computation.
Write a procedure type–check that takes as arguments a one-argument procedure f and a one-argument predicate 
procedure pred. Type–check should return a one-argument procedure that first applies pred to its argument; if 
that result is true, the procedure should return the value computed by applying f to the argument; if pred returns 
false, the new procedure should also return #f:
> (define safe–sqrt (type–check sqrt number?))
> (safe–sqrt 16)
4
> (safe–sqrt 'sarsaparilla)
#F
|#

;type-check:: (a -> b) (c -> d)
(define (type-check f pred)
  (lambda (arg) (if (pred arg) (f arg) #f))
  )

(define safe-sqrt (type-check sqrt number?))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
9.16 In the language APL, most arithmetic functions can be applied either to a number, with the usual result, or to a 
vector—the APL name for a sentence of numbers—in which case the result is a new vector in which each element is 
the result of applying the function to the corresponding element of the argument. For example, the function sqrt 
applied to 16 returns 4 as in Scheme, but sqrt can also be applied to a sentence such as (16 49) and it returns 
(4 7).
Write a procedure aplize that takes as its argument a one-argument procedure whose domain is numbers or words. It 
should return an APLized procedure that also accepts sentences:
> (define apl–sqrt (aplize sqrt))
> (apl–sqrt 36)
6
> (apl–sqrt '(1 100 25 16))
(1 10 5 4)
|#

; aplize:: (x -> y) -> (a -> b)
(define (aplize proc)
  (λ (arg) (if (number? arg)
               (proc arg)
               (every proc arg)
               ) )
  )
(define apl–sqrt (aplize sqrt) )
(apl–sqrt 36)
(apl–sqrt '(1 100 25 16))

; 9.17 write keep in terms of every and accumulate
(define (my-keep pred xs)
  ; for each x in the xs, check if it satisfies the pred.
  ; if so, keep it, else discard
  (let ((result (every (λ (x) (if (pred x)
                                  x
                                  '()
                                  ) ) xs)))
    (if (sentence? xs)
        (accumulate se result)
        (accumulate word result)
        )
    )
  )
(my-keep even? '(1 2 3 4))
(my-keep (λ(letter) (equal? letter 'a)) 'abcde)