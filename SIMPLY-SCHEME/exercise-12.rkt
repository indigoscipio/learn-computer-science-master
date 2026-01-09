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