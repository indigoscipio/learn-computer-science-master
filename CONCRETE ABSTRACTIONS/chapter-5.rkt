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

(define (make-exponentiater e)
  (λ (b) (expt b e))
  )
(define square (make-exponentiater 2))
(square 4)

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