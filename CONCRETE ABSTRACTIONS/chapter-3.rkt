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

#|
(define (sum-of-divisors n)
  (define (loop curr-divisor acc)
    (cond [(> curr-divisor n) acc] ;no more divisors
          [(zero? (remainder n curr-divisor)) (loop (+ 1 curr-divisor) (+ curr-divisor acc)) ]
          [else (loop (+ 1 curr-divisor) acc) ]
          )
    )
  (loop 1 0)
  )
|#

#|
Although the method we use for computing the sum of the divisors is straightforward,
it isn’t particularly efficient. Any time we find a divisor d of n, we can infer that n d
is also a divisor. In particular, all the divisors greater than the square root of n can
be inferred from the divisors less than the square root. Make use of this observation
to write a more efficient version of sum-of-divisors that stops once low2 
n.
Remember that if low2 n, low and n low are the same divisor, not two different
ones.

answer:
lets avoid using confusing language like lowetc and just keep it simple
|#

(define (sum-of-divisors n)
  (define (loop curr-divisor acc)
    (cond [(>= (sqr curr-divisor) n) acc] ;no more divisors
          [(zero? (remainder n curr-divisor)) (loop (+ 1 curr-divisor) (+ curr-divisor (/ n curr-divisor) acc)) ]
          [else (loop (+ 1 curr-divisor) acc) ]
          )
    )
  (loop 1 0)
  )
(sum-of-divisors 6)

(define (perfect? n)
  (= (sum-of-divisors n) (* 2 n))
  )
(perfect? 6)

(define first-perfect-after
  (lambda (n)
    (if (perfect? (+ n 1))
        (+ n 1)
        (first-perfect-after (+ n 1)))))
(first-perfect-after 6)

#|
Exercise 3.7
Using this technique, write a procedure, improve, that takes one of the approxima
tions of 
and returns then next one. For example, given 2, it would return 3.
|#

#|
(define (improve curr-phi)
  (+ 1 (/ 1 curr-phi))
  )

(define epsilon 0.00001)

(define (good-enough? curr-guess improved-guess)
  (< (abs (- improved-guess curr-guess)) epsilon)
  )

(define (find-approximation guess)
  (let ((improved-guess (improve guess)))
    (cond [(good-enough? guess improved-guess) guess]
          [else (find-approximation improved-guess)]
          )
    )
  )
(find-approximation 1.9)
|#

#|
Presumably any art work needs to be made out of something, and there are only
about 1079 electrons, neutrons, and protons in the universe. Therefore, we can
conservatively assume that no artist will ever need to know to better than one part
in 1079. Calculate an approximation that is within a tolerance of 1 1079, which can
also be expressed as 10 79. (To calculate this tolerance in Scheme, you could use
the expt procedure, as in (/ 1 (expt 10 79)) or (expt 10-79).)
|#

(define (improve curr-phi)
  (+ 1 (/ 1 curr-phi))
  )

(define epsilon (expt 10 -79))

(define (good-enough? curr-guess improved-guess)
  (< (abs (- improved-guess curr-guess)) epsilon)
  )

(define (find-approximation guess)
  (let ((improved-guess (improve guess)))
    (cond [(good-enough? guess improved-guess) guess]
          [else (find-approximation improved-guess)]
          )
    )
  )


(define (survives? pos n)
  ;#t if the person in that position is one of the last two survivors
  ;else its #f
  (cond [(< n 3) #t]
        [else 0]
        )
  )


#|
Exercise 3.9

How about the people who were in pos 1 and 2;
what pos numbers are they in after the renumbering?

answer:
once they killof the #3 one then the 4th one will become the new pos 1, 5th one new pos 2,
etc so the people who were in pos1 and 2 at that renumber becomes the 1st last and 2nd last

|#


#|
Write a procedure for doing the renumbering. It should take two arguments: the
old position number and the old number of people (n). (It can assume that the old
position number won’t ever be 3, because that person is killed and hence doesn’t get
renumbered.) It should return the new position number.

answer:
|#

; assume old pos wont be 3
(define (renumber old-pos old-n)
  #|
  (let ((new-n (- old-n 1))
        (shifted-result (modulo (- old-pos 3) (- old-n 1))))
    (if (= shifted-result 0)
        new-n
        shifted-result
        )
    
    )
 |#
(+ (modulo (- old-pos 1 3) 
           (- old-n 1)) 
   1)
  
)
(renumber 1 3) ;before target, add with old n
(renumber 4 3) ;after target, subtract old n