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

#|
Finish writing the survives? procedure, and carefully test it with a number of cases
that are small enough for you to check by hand but that still cover an interesting
range of situations.
|#

(define (survives? pos n)
  ;#t if the person in that position is one of the last two survivors
  ;else its #f
  (cond [(< n 3) #t]
        [(= pos 3) #f]
        [else (survives? (renumber pos n) (- n 1))] 
        )
  )
(survives? 2 40)

#|
se 3.12
Write a procedure, analogous to first-perfect-after, that can be used to system
atically search for surviving positions. What are the two surviving positions starting
from a circle of 40 people? (Presumably Josephus chose one of these two positions.)
abswer:
|#

; number -> list-of-numbers
(define (surviving-positions n)

  (define (helper curr-pos acc)
    (cond [(> curr-pos n) (reverse acc)]
          [else (let ((result (survives? curr-pos n)))
                  (if result
                      (helper (+ 1 curr-pos) (cons curr-pos acc))
                      (helper (+ 1 curr-pos) acc)
                      )
                  )]
          )
    )
  (helper 1 '())
  
  )
(surviving-positions 20)


#|
In Exercises 2.12 and 3.2 you saw that any positive integer n can be expressed as 2jk
where k is odd, and you wrote a procedure to compute j, the exponent of 2. The
following procedure instead computes k, the odd factor (which is the largest odd
divisor of n). Does it generate a recursive process or an iterative process? Justify your
answer.

(define largest-odd-divisor
  (lambda (n)
    (if (odd? n)
      n
      (largest-odd-divisor (/ n 2)))))


answer:
since in the 2nd case largest-odd-divisor is called without any preceding operator
it generates a iterative process

example - n = 10
odd? 10 - false
calls (largest-odd-divisor 5) - no more computation here except for the argument
odd? 5 - true, return the 5

|#

;======================================================

#|
Exercise 3.14
Here is a procedure that finds the largest number k such that bk n, assuming that n
and bareintegers such that n 1andb 2.Forexample,(closest-power 2 23)
returns 4:

(define closest-power
  (lambda (b n)
    (if (< n b)
      0
      (+ 1 (closest-power b (quotient n b))))))

a. Explain why this procedure generates a recursive process.
b. Write a version of closest-power that generates an iterative process.

answer:
a. because the recursive call to closest power happens with the + operator
it needs needs to calculate the + operator result on each call

closest power 2 23
< 23 2 ? false
(+ 1 (closest-power 2 11))) ... etc


b. below
|#

(define (closest-power b n)
  (define (loop curr-n k)
    (cond [(< curr-n b) k]
          (else (loop (quotient curr-n b) (+ 1 k)))
          )
    )
  (loop n 0)
  )
(closest-power 2 23)

;======================================================

#|
Exercise 3.15

Consider the following two procedures:
(define f
  (lambda (n)
    (if (= n 0)
    0
    (g (- n 1)))))


(define g
  (lambda (n)
    (if (= n 0)
      1
      (f (- n 1)))))


a. Use the substitution model to evaluate each of (f 1), (f 2),and(f 3).
b. Can you predict (f 4)? (f 5)? In general, which arguments cause f to return
0 and which cause it to return 1? (You need only consider nonnegative integers.)
c. Is the process generated by f iterative or recursive? Explain.

answer:
a.
f(1) -> n = 1
since n !=0, go to the recursive case

calls g(0) -> = 0
since n = 0 it returns 1

------

f(2) -> n = 2
since n !=0, go to the recursive case

calls g(1) -> n = 1
since n != 0 goes to recursive case

calls f(0)
since n = 0 it return 0

------

f(3) -> 3 = 2
since n !=0, go to the recursive case

calls g(2) -> n = 2
since n != 0 goes to recursive case

calls f(1)
since n != 0 it goes to recursive case

calls g(0) -> n = 0
since n = 0 it return 1


------

b. based on the pattern it keeps alternatiig 0 or 1 like modulo
so if f1 = 1, f2 =0, f3=1, f4 will return 0 and f5 will return 1

arguments that return 0: even numbers
arguments that return 1: odd numbers


-----

c. since there is no other operation and the recursive call
is the only final one it generates a iterative process
so no more "chain" of operation remaining
however i calls each other so its like mutual iterative recursion

|#

; =================================================


#|
Exercise 3.17

Falling factorial powers are similar to normal powers and also similar to factorials.
We write them as nk
and say “n to the k falling.” This means that k consecutive
numbers should be multiplied together, starting with n and working downward.
For example, 7_3
7 6 5(i.e., three consecutive numbers from 7 downward
multiplied together).

Write a procedure for calculating falling factorial powers that generates an iterative
process.

answer:
|#

; ===================================================

; number number -> number
(define (ff n k)
  
  (define (loop curr-n counter result)
    (cond [(>= counter k) result]
          [else (loop (- curr-n 1) (+ counter 1) (* curr-n result) ) ]
          )
    )
  (loop n 0 1)
  
  )
(ff 8 1) ; 8
(ff 7 3) ; 210
(ff 5 4) ;120
(ff 10 2) ;90

; ===================================================

#|
We’ve already seen how to raise a number to an integer power, provided that the
exponent isn’t negative. We could extend this to allow negative exponents as well by
using the following definition:


b^n = {
1 if n = 0
b^n-1 * b if n > 0
b^n+1/b if n < 0
}

a. Using this idea, write a procedure power such that (power b n) raises b to the
n power for any integer n.
b. Use the substitution model to show how (power 2-3) would be evaluated. (You
can leave out steps that just determine which branch of a cond or if should be
taken.) Does your procedure generate a recursive process or an iterative one?

answer:
|#

; PART A
(define (expo b n)
  (cond [(zero? n) 1]
        [(> n 0) (* (expo b (- n 1)) b)]
        [else (/ (expo b (+ n 1))  b)])
  )

#|
PART B

(expo 2 -3)
n = -3
goes to the n<0
(/ (expo 2 -2)  2)

(expo 2 -2)
n = -2
goes into the n<0
(/ (expo 2 -1)  2)

(expo 2 -1)
n = -1
goes into the n<0
(/ (expo 2 0)  2)

(expo 2 0)
n is zero, reutrn 1

building up the calls

(/ (/ (/ 1  2)  2)  2) -> return 1/8

since there is another operation during the call (* or /) this is not a tail iterative call
it needs to calculate the result of the operation so its a recursive process

|#

; =========================================

; EXERCISE 3.19