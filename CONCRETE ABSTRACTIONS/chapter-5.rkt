#lang racket

#|
Exercise 5.1
Write a linear iterative version of together-copies-of

answer:
|#

#|
(define (together-copies-of combine quantity thing)

  (define (loop count acc)
    (cond [(= count 1) acc] ;last one
          [else (loop (- count 1) (combine thing acc) )]
          )
    )
  (loop quantity thing)
  
  )
(together-copies-of + 3 10)
|#

#|
(define (together-copies-of combine quantity thing)
  (cond [(= 1 quantity) thing]
        [else (let ((new-quantity (quotient quantity 2)))
                (if (even? quantity)
                    (let ((result (together-copies-of combine new-quantity thing)))
                      (combine result result)
                      )
                    
                    (combine (together-copies-of combine (- quantity 1) thing) thing)
                    )
                )]
        )
  )
(together-copies-of + 3 10)
|#


#|
What does the following procedure compute? Also, compare its performance with
each of the three versions of together-copies-of installed, using relatively large
values for the first argument, perhaps in the ten thousand to a million range.


(define mystery
  (lambda (a b)
    (together-copies-of + a b)))

answer:

this is just a wrapper for together copies of
but witht he + operation passed on
so its summing b a times, in other words multiplication

linear recursive - on
linear iterative - instant
logarithmic = 20
|#

#|
(define (num-digits-in-satisfying n test?)
  (cond [(< n 0) (num-digits-in-satisfying (- n) test?)]
        [(< n 10) (if (test? n) 1 0)]
        [(test? (remainder n 10)) (+ (num-digits-in-satisfying (quotient n 10) test?) 1)]
        [else (num-digits-in-satisfying (quotient n 10) test?)]))
|#

#|
Exercise 5.4
Use num-digits-in-satisfyingto define the procedure num-digits, which was
defined “from scratch” in Section 2.3.
|#


#|
Exercise 5.5
Rewrite num-digits-in-satisfying so that it generates an iterative process.
Another computational pattern that occurs very frequently involves summing the
values of a function over a given range of integers.
|#

(define (num-digits-in-satisfying n test?)
  (define (loop curr-n acc)
    (cond [(< curr-n 0) (loop (- curr-n) acc)] ;negative n
          [(< curr-n 10) (if (test? curr-n) (+ 1 acc) acc)] ;last digit
          [(test? (remainder curr-n 10)) (loop (quotient curr-n 10) (+ 1 acc)) ] ;passes the test
          [else (loop (quotient curr-n 10) acc)]; fails the test
          )
    )
  (loop n 0)
  )
(num-digits-in-satisfying 12345 odd?)


#|

Exercise 5.6
Write a general purpose procedure, that when given two integers, low and high,and
a procedure for computing a function f, will compute f(low) + f(low + 1) + f(low +2) + ... + f(high).
Show how it can be used to sum the squares of the integers from 5 to 10 and to sum the square
roots of the integers from 10 to 100

|#

(define (sum-from low high f)
  ; on each step increase low until it moves past high
  (cond [(> low high) 0] ;low is now past high
        [else (+ (f low) (sum-from (+ 1 low) high f))]
        )
  )
(sum-from 5 10 sqr)
(sum-from 10 100 sqrt)


#|
Exercise 5.7
Write a procedure make-exponentiater that is passed a single parameter e (an
exponent) and returns a function that itself takes a single parameter, which it raises
to the e power. You should use the built-in Scheme procedure expt. As examples,
you could define square and cube as follows:
(define square (make-exponentiater 2))
(define cube (make-exponentiater 3))
(square 4)
16
(cube 4)
64
|#


#|
(define (make-exponentiater e)
  (λ (b) (expt b e))
  )
(define square (make-exponentiater 2))
(square 4)

|#

#|
Exercise 5.8
Define a procedure that can be used to produce factorial (Section 2.1) or
sum-of-first (Section 2.3). Show how it can be used to define those two pro
cedures
|#

(define (sum-of-first n)
  (cond [(zero? n) 0]
        [else (+ n (sum-of-first (- n 1)))]
        )
  )

(define (factorial n)
  (cond [(zero? n) 1]
        [else (* n (factorial (- n 1)))])
  )

(define (proc op n b f)
  (cond [(zero? n) b]; done
        [else (op (f n) (proc op (- n 1) b f)) ]
        )
  )
;(proc * 5 1) ;factorial 5
;(proc + 5 0) ;sum of first 5

#|
Exercise 5.9
Generalize your solution to the previous exercise so it can also be used to produce
sum-of-squares and sum-of-cubes from Exercise 2.8 on page 38.
|#

(define (sum-of-squares n)
  (proc + n 0 sqr)
  )
(sum-of-squares 5)
(define (sum-of-cubes n)
  (proc + n 0 (λ (x) (expt x 3)))
  )
(sum-of-cubes 5)

#|
Exercixe 5.10
Write a predicate that takes a number and determines whether the sum of its digits
is divisible by 17.
|#

#|
(define (sod-div-by-17 n)
  (zero? (remainder (sum-of-digits n) 17))
  )
|#

#|
Exercise 5.11
Write a procedure make-verifier, which takes f and m as its two arguments
and returns a procedure capable of checking a number. The argument f is itself a
procedure, of course. Here is a particularly simple example of a verifier being made
and used:

(define check-isbn (make-verifier * 11))
(check-isbn 0262010771)
#t


As we just saw, for ISBN numbers the divisor is 11 and the function is simply
f (i, di) = di. Other kinds of numbers use slightly more complicated functions,
but you will still be able to use make-verifier to make a verifier much more easily
than if you had to start from scratch.

answer:
|#


(define (sum-of-digits n)
  (define (loop curr-n acc)
    (cond [(equal? curr-n 0) acc]
          [else (loop (quotient curr-n 10) (+ (remainder curr-n 10) acc) ) ])
    )
  (loop n 0)
  )


(define (make-verifier f m)
  (λ (n) (define (loop i curr-n acc)
           (cond [(zero? curr-n) (zero? (remainder acc m))]
                 [else (loop (+ i 1) (quotient curr-n 10) (+ (f i (remainder curr-n 10)) acc))]
                 )
           )
    (loop 1 n 0))
  )
(define check-isbn (make-verifier * 11))
(check-isbn 0262010771)


#|
Execise 5.12
For UPC codes (the barcodes on grocery items), the divisor is 10, and the function
f (i, di)isequaltodi itself when i is odd, but to 3di when i is even. Build a verifier for
UPCcodes using make-verifier, and test it on some of your groceries. (The UPC
number consists of all the digits: the one to the left of the bars, the ones underneath
the bars, and the one on the right.) Try making some mistakes, like switching or
changing digits. Does your verifier catch them?
|#

(define check-upc (make-verifier (λ (i d) (if (odd? i) d (* 3 d))) 10))
(check-upc 036000291453)

#|
Credit card numbers also use a divisor of 10 and also use a function that yields di
itself when i is odd. However, when i is even, the function is a bit fancier: It is 2di if
di 
5, and 2di 1ifdi 5. Build a verifier for credit card numbers. In the dialog
at the beginning of this section, did the order taker really mistype the number, or
did the customer read it incorrectly?
|#

(define check-cc (make-verifier (λ (i d) (if (odd? i)
                                             d
                                             (if (< d 5)
                                                 (* 2 d)
                                                 (+ (* 2 d) 1)
                                                 )
                                             )) 10))
(check-cc 378282246310005)


#|
Exercise 5.14

The serial number on U.S. postal money orders is self-verifying with a divisor of 9 and
a very simple function: f(i,di) = di, with only one exception, namely, f(1,d1) = -d1.
Build a verifier for these numbers, and find out which of these two money orders is
mistyped: 48077469777 or 48077462766.
Actually, both of those money order numbers were mistyped. In one case the error
was that a 0 was replaced by a 7, and in the other case two digits were reversed.
Can you figure out which kind of error got caught and which didn’t? Does this help
explain why the other kinds of numbers use fancier functions?

answer:
|#

(define check-postal (make-verifier (λ (i d) (if (= i 1) (- d) d)) 9))
(check-postal 48077469777) ;false, mistyped
(check-postal 48077462766) ;true


; ================================================

; REVIEW PROBLEMS

#|
Exercise 5.15

Write a higher-order procedure called make-function-with-exceptionthat takes
two numbers and a procedure as parameters and returns a procedure that has the
same behavior as the procedural argument except when given a special argument.
The two numerical arguments to make-function-with-exception specify what
that exceptional argument is and what the procedure made by make-function
with-exception should return in that case. For example, the usually-sqrt pro
cedure that follows behaves like sqrt, except that when given the argument 7, it
returns the result 2:

(define usually-sqrt
(make-function-with-exception 7 2 sqrt))
(usually-sqrt 9)
3
(usually-sqrt 16)
4
(usually-sqrt 7)
2
|#

(define (make-func-with-exception a b f)
  (λ (n) (if (equal? n a) b (f n)))
  )

(define usually-sqrt (make-func-with-exception 7 2 sqrt))
(usually-sqrt 9)
(usually-sqrt 16)
(usually-sqrt 7)


#|
Exercise 5.16

If two procedures f and g are both procedures of a single argument such that the val
ues produced by g are legal arguments to f,thecomposition of f and g isdefinedtobe
the procedure that first applies g to its argument and then applies f to the result. Write
a procedure called compose that takes two one-argument procedures and returns
the procedure that is their composition. For example, ((compose sqrt abs)-4)
should compute the square root of the absolute value of 4.
|#

;; compose: (b -> c) (a -> b) -> c
(define (compose f g)
  (λ (n) (f (g n)))
  )
((compose sqrt abs) -4)



#|
Suppose you have a function and you want to find at what integer point in a given
range it has the smallest value. For example, looking at the following graph of the
function f(x) = x^2 - 2x, you can see that in the range from 0 to 4, this function has
the smallest value at 1

<plot image with curve>

We could write a procedure for answering questions like this; it could be used as
follows for this example:

(integer-in-range-where-smallest (lambda (x) (- (* x x) (* 2 x))) 0 4)
Here is the procedure that does this; fill in the two blanks to complete it:

(define integer-in-range-where-smallest
  (lambda (f a b)
    (if (= a b)
        a
        (let ((smallest-place-after-a
               <blank>))
          (if <blank>
           a
           smallest-place-after-a)))))


answer: ...
|#


(define (integer-in-range-where-smallest f a b)
  (if (= a b)
      a
      (let ((smallest-place-after-a (integer-in-range-where-smallest f (+ a 1) b)))
        (if (< (f a ) (f smallest-place-after-a))
            a
            smallest-place-after-a))
      )
  )

#|
Exercise 5.18
Consider the following definitions


(define make-scaled
  (lambda (scale f)
    (lambda (x)
      (* scale (f x)))))

(define add-one
  (lambda (x)
    (+ 1 x)))

(define mystery (make-scaled 3 add-one))

for the following questions, be sure to indicate how you arrived at your answer:

a. what is the value of (mystery 4)?
b. what is the value of the procedural call ((make-scaled 2 (make-scaled
3 add-one)) 4)?

answer:
a. lets to a simple trace

(mystery 4) -> ((make-scaled 3 add-one) 4) ->
inside make-scaled
scale = 3, f = add-one, x = 4
(* scale (f x)) -> (* 3 (add-one 4)) -> (* 3 5) -> 15
so it returns 15

b. lets do this one by one
since make scaled is a function machine that expects 1 arg
we stack it so it expect 1 arg then another arg

INNER PART
the inside application first (make-scaled 3 add-one) ->
scale = 3, f = add-one
it returns a lamda that expects x -> (lambda (x) (* 3 (add-one x)))
in other words it increases whatever x you provide by 1 , then multiplies it by 3

OUTER PART
then to the next one
((make-scaled 2 (make-scaled 3 add-one)) ->
where scale = 2, and f is the previous function
it returns a lambda that also expects another x -> (lambda (x) (* scale (f x))) ->
since we know the result from the inner app just subst
(lambda (x) (* 2 ((lambda (x) (* 3 (add-one x))) x)))

APPLICATION
the last application we provide the 1st arg where x = 4
(* 2 ((lambda (x) (* 3 (add-one x))) 4)) -> calc inner layer ->
(lambda (x) (* 3 (add-one 4))) -> (lambda (x) (* 3 5)) -> (lambda (x) 15)

then the outer
(* 2 ((lambda (x) 15)) -> (* 2 15) -> 30
so it evals to 30


|#

(define (make-scaled scale f)
  (lambda (x) (* scale (f x))))

(define (add-one x)
    (+ 1 x))

(define mystery (make-scaled 3 add-one))
(mystery 4)

((make-scaled 2 (make-scaled 3 add-one)) 4)
(lambda (x) (* 2 ((lambda (x) (* 3 (add-one x))) 4)))

#|
Exercise 5.19
f l and h are integers, with l < h, we say f is an increasing function on the integer
range from l to h if f(l) < f(l+1) < f(l+2) < ... < f(h).

Write a procedure, increasing-on-integer-range?, that takes f, l,and h as its three arguments and
returns true or false (that is, #t or #f) as appropriate.
|#

;; int int int -> bool
(define (increasing-on-integer-range? f l h)
  ; if f(l) < f(h) - keep checking
  ; if f(l) > f(h) - stop and return false
  (cond [(= l h) #t] ; return the result
        [else (let ((curr-val (f l))
                    (next-val (f (+ 1 l))))
                (if (> next-val curr-val)
                    (increasing-on-integer-range? f (+ l 1) h)
                    #f
                    )
                )]
        )

) 
(increasing-on-integer-range? (λ (x) (* x 2)) 1 5)
(increasing-on-integer-range? (λ (x) (- 10 x)) 1 5)

#|
Exercise 5.20
Suppose the following have been defined:

(define f
  (lambda (m b)
    (lambda (x) (+ (* m x) b))))
(define g (f 3 2))

For each of the following expressions, indicate whether an error would be signaled,
the value would be a procedure, or the value would be a number. If an error is
signaled, explain briefly the nature of the error. If the value is a procedure, specify
how many arguments the procedure expects. If the value is a number, specify which
number.

a. f
b. g
c. (* (f 3 2) 7)
d. (g 6)
e. (f 6)
f. ((f 4 7) 6)

answer:

a.this one returns a procedure
since we defined f as (lambda (m b)(lambda (x) (+ (* m x) b)))
it returns that procedure that expects 2 argument m and b


b. since we defined g = (f 3 2) it calls the function
with m = 3 and b = 2
(lambda (m b)(lambda (x) (+ (* m x) b))) ->
(lambda (x) (+ (* 3 x) 2))
so this one returns another function that expects one argument x

c. (* (f 3 2) 7)
this one would return an error
because as mentioned in the previous one, the result of function application of f
returns another function that expects 1 argument x
but here we treat it as a math expression which would result in different type (* lambda number)

d. (g 6)
since g is (f 3 2) it returns a function that expects 1 arg
(lambda (x) (+ (* 3 x) 2)) we apply 6 to it
((lambda (x) (+ (* 3 x) 2)) 6) ->
(+ (* 3 6) 2) -> (+ 18 2) -> 20 so this one returns a number

e. (f 6)
since f returns a function that takes 2 args and return a function that takes 1 arg
it wil return an error since (f 6) we only specify 1 arg

f. ((f 4 7) 5)
(f 4 7) -> valid, this will return a func that expects 1 arg ->
(lambda (x) (+ (* 4 x) 7)) -> apply with x= 5 -> ((lambda (x) (+ (* 4 x) 7)) 5)
 (+ (* 4 5) 7) -> (+ 20 7) -> 27
so it will return a number


|#

(define f
  (lambda (m b)
    (lambda (x) (+ (* m x) b))))
(define g (f 3 2))

#|
Exercise 5.22

Thefunction halts?was definedasatest of whether a procedure with no parameters
would generate a terminating process. That is, (halts? f) returns true if and
only if the evaluation of (f) would terminate. What about procedures that take
arguments? Suppose we had a procedure halts-on? that tests whether a one
argument procedure generates a terminating process when given some particular
argument. That is, (halts-on? f x) returns true if and only if the evaluation of
(f x) would terminate.

a. use halts-on? in a definition of halts?
b. what does this tell you about the possibility of halts-on?

answer:


|#


; THERE IS NO UNIVERSAL DEBUGGER


#|
Exercise 5.23

Consider the following example:

(define double (lambda (x) (* x 2)))
(define square (lambda (x) (* x x)))
(define new-procedure
  (make-averaged-procedure double square))

(new-procedure 4)
12
(new-procedure 6)
24

In the first example, the new-procedure that was made by make-averaged
procedure returned 12 because 12 is the average of 8 (twice 4) and 16 (4 squared).
In the second example, it returned 24 because 24 is the average of 12 (twice 6)
and 36 (6 squared). In general, new-procedure will return the average of what
ever double and square return because those two procedures were passed to
make-averaged-procedure when new-procedure was made.

Write the higher-order procedure factory make-averaged-procedure.

answer:
|#


(define double (lambda (x) (* x 2)))
(define square (lambda (x) (* x x)))

(define (make-averaged-procedure f1 f2)
  (λ (x) (/ (+ (f1 x) (f2 x)) 2))
  )

(define new-procedure
  (make-averaged-procedure double sqr))
(new-procedure 4)
(new-procedure 6)


#|
Exercise 5.24

Consider the following procedure:

(define (positive-integer-upto-where-smallest n f)
  ; return an integer i such that
  ; 1 <= i <= n and for all integers j
  ; in that same range, f(i) <= f(j)
  (define (loop where-smallest-so-far next-to-try)
    (if (> next-to-try n)
        where-smallest-so-far
        (loop (if (< (f next-to-try)
                     (f where-smallest-so-far))
                  next-to-try
                  where-smallest-so-far)
              (+ next-to-try 1))))
  (loop 1 2)
  )

a. Write a mathematical formula involving n that tells how many times this proce
dure uses the procedure it is given as its second argument. Justify your answer.
b. Give a simple order of growth for the quantity you determined in part a. Justify
your answer.
c. Suppose you were to rewrite this procedure to make it more efficient. What (in
terms of n) is the minimum number of times it can invoke f and still always
determine the correct answer? Justify your answer. (You are not being asked to
actually rewrite the procedure.)


|#

(define (positive-integer-upto-where-smallest n f)
  ; return an integer i such that
  ; 1 <= i <= n and for all integers j
  ; in that same range, f(i) <= f(j)
  (define (loop where-smallest-so-far next-to-try)
    (if (> next-to-try n)
        where-smallest-so-far
        (loop (if (< (f next-to-try)
                     (f where-smallest-so-far))
                  next-to-try
                  where-smallest-so-far)
              (+ next-to-try 1))
        ))
  (loop 1 2)
  )

#|
answer:
a. lets trace this
with n = 5, f = sqr
inside initializes with (loop 1 2)
where-smallest = 1, next-to-try = 2
checks (> 2 5), false

recurse with 1st argument check and 2nd arg increase
(< (f next-to-try)(f where-smallest-so-far)) -> calls f two times.
(< (sqr 2)(sqr 1)) -> (< 4 1) -> false

recurse with (loop 1 )
where-smallest = 1, next-to-try = 3

so it seems that if we go to the else case
it recurse with the f being called two times.

2 x (n-1)
2 because we call 2 times on each recursion
n-1 is the range from 2 - n

PART B
big theta of n

PART C
save the result in a variable
reduces total call from 2n -> n
|#
(positive-integer-upto-where-smallest 5 sqr)