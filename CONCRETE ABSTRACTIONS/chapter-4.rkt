#lang racket

; ORDERS OF GROWTH & TREE RECURSION


#|
Exercise 4.1
Go ahead and figure out exactly what n + (n 1) + ... + 2 + 1 is.
Do this by adding
the first term to the last, the second to the second from last, and so forth. What does
each pair add up to? How many pairs are there? What does that make the sum?

answer:
(n + 1) + ((n-1) + 2) + ((n-2) + 3) + ... (first n-midpoint) + last midpoint

so if n = 5
(5 + 1) + (4 + 2) + (3)
so 2 total pairs + one half pair => so it makes 2n total pairs + 1/2 pair

sum = 6 + 6 + 3 = 15

total number of pair = n/2
total value of each pair = n+1
multiply it = n/2 * n + 1 -> n(n+1)/2 = n^2+n/2



|#



#|
Exercise 4.2

(define mod-expt
  (lambda (base exponent modulus)
    (define mod*
      (lambda (x y)
        (remainder (* x y) modulus)))
    (if (= exponent 0)
        1
        (if (even? exponent)
            (mod* (mod-expt base (/ exponent 2) modulus)
                  (mod-expt base (/ exponent 2) modulus))
            (mod* (mod-expt base (- exponent 1) modulus)
                  base)))))

Inthisexerciseyouwillshowthatthisversionofmod-exptdoes (e)multiplications,
asweclaimed.
a.Useinductiontoproveeachofthefollowingaboutthislatestversionofmod-expt:
(1) eisanonnegativeinteger,(mod-exptb em)doesatleastemultiplications.
(2)Wheneisapositiveinteger,(mod-expt b em)doesatmost2e 1multi
plications.

answer:

a1.
e is a nonnegative integer, (mod-expt b e m) does at least e multiplicaitons

M(e) represents the number of mult performed for exponent e
if e = 0; m = (0)

if e is even and > 0 : m(e) = 1 + m(e/2) + m(e/2)
if e is odd: m(e) = 1 + m (e-1)

proving m(e)>=e
base case = 1

IH
assume for some arbitrary integer k>=0
the formula holds all values from 0 up to k
we assume that any j<=k the number of multiplications mj >=j

IS

a2.

|#


#|
Exercise 4.3
Write a procedure that, given the exponent, will compute how many multiplications
this latest version of mod-expt does.
|#

(define mod-expt
  (lambda (base exponent modulus)
    (define mod*
      (lambda (x y)
        (remainder (* x y) modulus)))
    (if (= exponent 0)
        0
        (if (even? exponent)
            (let ((result (mod-expt base (/ exponent 2) modulus)))
              (+ 1 result)
              )
            (+ 1 (mod-expt base (- exponent 1) modulus)
                       )))))
(mod-expt 2 8 3)


#|
4.11
(define factorial
  (lambda (n)
    (if (= n 0)
        1
        (* n (factorial (- n 1))))))

(define factorial-sum1 ; returns 1! + 2! + ... + n!
  (lambda (n)
    (if (= n 0)
        0
        (+ (factorial n)
           (factorial-sum1 (- n 1))))))

(define factorial-sum2 ; also returns 1! + 2! + ... + n!
  (lambda (n)
    (define loop
      (lambda (k fact-k addend)
        (if (> k n)
            addend
            (loop (+ k 1)
                  (* fact-k (+ k 1))
                  (+ addend fact-k)))))
    (loop 1 1 0)))

n answering the following, assume that n is a nonnegative integer. Also, justify your
answers.
a. Give a formula for how many multiplications the procedure factorial does as
a function of its argument n.
b. Give a formula for how many multiplications the procedure factorial-sum1
does (implicitly through factorial) as a function of its argument n.
c. Give a formula for how many multiplications the procedure factorial-sum2
does as a function of its argument n.

answer:
a. factorial
base case is when n = 0
an each iteration it decreases the next n by n-1

so if n=3
ist call -> 3 * (factorial 2) - 1 mult
2nd call -> 2 * (factorial 1) - 1 mult
3rd call -> 1 * (factorial 0) - 1 mult
final -> 0 -> no mult

total = n multiplications
but if n is already 0, no multiplication is done

; -------

b. factorial-sum1
base case is when n = 0, returns 0
else sum the factorial + recurse with n-1

lets do small exmale, n=3
1st call - (+ (factorial 3) (factorial-sum1 2))
we know factorial n returns n multiplications , so mult = 3

2nd call - (+ (factorial 2) (factorial-sum1 1))
we know factorial n returns n multiplications , so mult = 2

3rd call - (+ (factorial 1) (factorial-sum1 0))
we know factorial n returns n multiplications , so mult = 1

final call - n reaches 0, no more mult
total multiplications = 3+2+1 = 6
so the total multiplication is = n + n-1 + n-2 + ... 1 
if n is alraedy 0, no multiplication is needed

-----

c factorial-sum2
so here added basically stores hte acc

lets do example n = 3
first call
initialize with (loop 1 1 0) - k=1, fact-k=1, addend = 0
1 > 3? false
(loop 2 (* 1 2) (+ 0 1)) - here 1 multiplication happened

2nd call
(loop 2 2 1) - k=2, fact-k=2, addend = 1
2 > 3 ?false
(loop 3 (* 2 3) (+ 1 2)) - here 1 multiplication happened

3nd call
(loop 3 6 3) - k=3, fact-k=6, addend = 3
3 > 3 ?false
(loop 4 (* 6 4) (+ 3 6)) - here 1 multiplication happened

final call
since k > n it gives the result and no more mult
so total = n mult, similar to a



|#


#|
Exercise4.12
How many ways are there to factor n into two or more numbers (each of which must
be no smaller than 2)? We could generalize this to the problem of finding how many
ways there are to factor n into two or more numbers, each of which is no smaller
than m. That is, we write

(define ways-to-factor
(lambda (n)
(ways-to-factor-using-no-smaller-than n 2)))
Your job is to write ways-to-factor-using-no-smaller-than. Here are some
questions you can use to guide you:
If m2 n, how many ways are there to factor n into two or more numbers each
no smaller than m?
Otherwise, consider the case that n is not divisible by m. Compare how many
ways are there to factor n into two or more numbers no smaller than m with how
many ways there are to factor n into two or more numbers no smaller than m 1.
What is the relationship?
The only remaining case is that m2 
n and n is divisible by m. In this case,
there is at least one way to factor n into numbers no smaller than m. (It can
be factored into m and nm.) There may, however, be other ways as well. The
ways of factoring n divide into two categories: those using at least one factor of m
and those containing no factor of m. How many factorizations are there in each
category?

answer:
if m^2 > n then theres 0factor
if n is not divisible by m - just move to m+1

|#

(define (ways-to-fact-r m n)
  0
  )

