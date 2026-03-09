#lang racket

#|
Exercise 3.1
At the very beginning of the above design of the iterative factorial, a choice needed
to be made of which two numbers to multiply together, in order to fit the two
of them into one blank. In the version shown above, the decision was made to
multiply together the leftmost two numbers (the 6 and the 5). However, it would
have been equally possible to make some other choice, such as multiplying together
the rightmost two numbers. Redo the design, following this alternative path.

(define factorial-product
(lambda (a b) ; compute a * b!
(if (= b 0)
a
(factorial-product (* a b) (- b 1)))))

answer:
|#

  #|
; version where it process rightmost
; where a is acc and b is counter
(define (factorial-product a b)

  (define (helper counter acc)
    (cond [(> counter b) acc]
          [else (helper (+ 1 counter) (* counter acc) )]
          )
    )
  
  (helper 1 a)

  )
(factorial-product 1 5)
|#


(define factorial-product
  (lambda (a b) ; compute a * b!
    (if (= b 0)
        a
        (* a (factorial-product a (- b 1)) ))))
(factorial-product 1 5)



#|
Exercise 3.2
Write a new procedure for finding the exponent of 2 in a positive integer, as in
Exercise 2.12 on page 40, but this time using an iterative process.

(define (find-expo n)
  (cond [(odd? n) 0]
        [else (+ 1 (find-expo (/ n 2)))] ;keep dividing by two
        )

  (let loop ((remaining n)
             (expo-count 0))
    (cond [(odd? remaining) expo-count]
          [else (loop (/ remaining 2) (+ 1 expo-count))])
    )
  
  )

answer:
|#

(define (find-expo n)
  (define (iter counter result)
    (cond [(odd? counter) result]
          [else (iter (/ counter 2) (+ 1 result)) ])
    )
  (iter n 0)
  )
(find-expo 40)

; -----

#|

INVARIANT

something that never changes
a and b changes ine very step
but theres a relationship between them that stays exactly the same
|#

; =======================

#|
Exercise 3.4

Give a formal induction proof that power-product is correct.


(define power-product
(lambda (a b e)
; returns a times b to the e power
(if (= e 0)
a
(power-product (* a b) b (- e 1)))))



answer:

we wanna show the code returns a . b^e

base case:
e = 0
a . b^0
a . 1
a
therefore it returns the accuulator/result


inductive hypothesis
assume for some nonneg int k where 0 <= k < e, the call (power product i b k)
correctly terminates and return i . b^k

inductive step
we wanna show it reutrns true for k+1, that is the code
terminates and reutrns i . b^k+1

since k is not zero it goes to the 2nd else case
substitute

(power-product (* i b) b (- k 1)))
(power-product (* i b) b (- (k + 1) 1)))
(power-product (* i b) b k))

since we assumed earlier we can substitute from IH
ib . b^k
i (b^k+1)
therefore it matches
|#


#|
Exercise 3.5
If when you did Exercise 3.2, you didn’t write down the invariant for your iterating
procedure, do so now. Next, use induction to prove that your procedure does in fact
compute this invariant quantity.

my answer from exercise 3.2

(define (find-expo n)
  (define (iter counter result)
    (cond [(odd? counter) result]
          [else (iter (/ counter 2) (+ 1 result)) ])
    )
  (iter n 0)
  )
(find-expo 40)

answrer:



base case
2^result . counter = N

inductivehypothesis
 Assume the invariant holds for some state $(r, c)$.
New Counter: (/ counter 2)
New Result: (+ 1 result)

inductive step
show the new invariant is equal to old invariant
2^(result + 1) . (counter / 2)
(2 . 2^result) . counter / 2
2^result . counter

therefore it matches

|#