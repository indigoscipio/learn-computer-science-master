#lang racket

; CHAPTER 12: DYNAMIC PROGRAMMING
; don't repeat the work you already done

; unecessary version
; assume input is nonempty
(define (my-max xs)
  (cond [(null? (cdr xs)) (car xs)]
        [else (let ((fst (car xs))
                    (max-rest (my-max (cdr xs))) )
                (display 'RECURSE)
                (newline)
                (if (> fst max-rest)
                    fst
                    max-rest
                    )
                )]
        )
  )
(my-max '(1 2 3 4 5 6 7 8))


; with memoization
(define (my-max-memo xs)
  (let ((table (make-vector (length xs))))
    table
    )
  )
(my-max-memo '(1 2 3 4 5 6 7 8))

; number -> number
(define (fib n)
  (cond [(or (zero? n)(= n 1)) n]
        [else (+ (fib (- n 2)) (fib (- n 1)) )])
  )
(fib 6)

; fills hash table with value
(define (fill-ht! ht value)
  0
  )

; 0, 1, 1, 2, 3, 5, 8, 13, 21,
; 0  1  2  3  4  5  6  7   8
; memoized fib with hash table
(define (memoized-fib n)
  (let ((ht (make-hash)))

    #|
    (define (memoized-fib-helper curr-n)
      (cond [(= curr-n 0) 0]
            [(= curr-n 1) 1]
            [else (+ (mf-subproblem (- curr-n 1))
                     (mf-subproblem (- curr-n 2)))]
            )
      )

    (define (mf-subproblem curr-n)
      (if (hash-has-key? ht curr-n)
          (hash-ref ht curr-n)
          (begin (hash-set! ht curr-n (memoized-fib-helper curr-n))
                 (hash-ref ht curr-n)
                 )
          )
      )
    (memoized-fib-helper n)
    |#


    (define (memoized-fib-helper curr-n)
      (cond [(or (= curr-n 0) (= curr-n 1)) curr-n]
            [(hash-has-key? ht curr-n) (hash-ref ht curr-n) ] ;key exists
            [else (let ((subproblem (+ (memoized-fib-helper (- curr-n 1))
                                       (memoized-fib-helper (- curr-n 2))
                                       )))
                    (hash-set! ht curr-n subproblem)
                    subproblem
                    ) ]
            )
      )
    (memoized-fib-helper n)
    
    )
  )
(memoized-fib 8)

; ===========================================

; DYNAMIC PROGRAMMING
; bottom up approach: start with 0 and 1, build up everything until n

; 0, 1, 1, 2, 3, 5, 8, 13, 21,
; 0  1  2  3  4  5  6  7   8
(define (dp-fib n)
  #|
  (cond [(zero? n) 0]
        [else (for ((i (in-range 1 (+ n 1)))
                    (a 0)
                    (b 1)
                    )
                (display 'hello)
                )]
        )
  |#

  (define (fib-helper a b i)
    (cond [(>= i n) b]
          [else (fib-helper b (+ a b) (+ i 1))])
    )

  (if (zero? n)
      0
      (fib-helper 0 1 1)
      )
  
  )
(dp-fib 4)
(dp-fib 1)
(dp-fib 8)

; ==========================================

#|
EXERCISE 1
The following function accepts an array of numbers and returns the sum,
as long as a particular number doesn’t bring the sum above 100. If adding
a particular number will make the sum higher than 100, that number is
ignored. However, this function makes unnecessary recursive calls. Fix
the code to eliminate the unnecessary recursion:

def add_until_100(array):
if not array:
return 0
if array[0] + add_until_100(array[1:]) > 100:
return add_until_100(array[1:])
else:
return array[0] + add_until_100(array[1:])


answer:
let me try to rebuild this in racket first and see
how ican improve it im shit at python
|#

; takes array of numbers and return the sum

; slow version rebuilt in racket (hopefully roughly the same)
; list-of-number -> number
(define (add-until-100 xs)
  (cond [(null? xs) 0]
        [(> (+ (car xs) (add-until-100 (cdr xs))) 100)
         (add-until-100 (cdr xs))]
        [else (+ (car xs) (add-until-100 (cdr xs)))]
        )
  )
(add-until-100 '(10 20 30 40 50 60 70 80 90))

; yeah idont think we need dp or memoization here honestly
; the issue with the code is that too many recursion calls
; the 2nd branch use 2 recursion calls
; and the else branch 1 recursion call so at most itusese 2 calls

; improved version
(define (add-until-100-v2 xs)

  #|
  ; we can use let here
  ; so each call to (add-until-100 (cdr xs)) is saved
  (cond [(null? xs) 0]
        [else (let* ((fst (car xs))
                     (sum-rest (add-until-100-v2 (cdr xs))))
                (if (> (+ fst sum-rest) 100)
                    sum-rest
                    (+ fst sum-rest)
                    )
                )]
        )
  |#

  ; or even better just use tail recursion
  ; just 1 single recursion call instead of 2
  (define (helper curr-xs curr-sum)
    (cond [(null? curr-xs) curr-sum]
          [(> (+ (car curr-xs) curr-sum) 100) (helper (cdr curr-xs) curr-sum)]
          [else (helper (cdr curr-xs) (+ (car curr-xs) curr-sum) )])
    )
  (helper xs 0)
  
  
  )
(add-until-100-v2 '(10 20 30 25 25 25))
(add-until-100-v2 '(10 20 30 40 50 60 70 80 90))


; ==========================================

#|
Exercise 2
The following function uses recursion to calculate the Nth number from
a mathematical sequence known as the Golomb sequence. It’s terribly
inefficient, though! Use memoization to optimize it. (You don’t have to
understand how the Golomb sequence works to do this exercise.)

def golomb(n):
if n == 1:
return 1
return 1 + golomb(n- golomb(golomb(n- 1)))

answer:
ok lets analyze the code first, my python is shit here
base case -> if n is 1, return 1
else we hve nested recursive calls here
outer -> golomb(n - mid)
mid -> golomb(inner)
inner -> golomb(n-1)
thats insane

lets try to like reconstruct this in racket first
just do the naive version first then try to optimize
with like memoization
|#

; naive version
; number -> number
(define (golomb n)
  (cond [(= n 1) 1]
        [else (+ 1 (golomb
                    (- n (golomb
                          (golomb (- n 1)))))) ])
  )
(golomb 7)


; now lets try the memoized version
; maybe just use a simple hash table
;; memo-golomb:: number -> number
(define (memo-golomb n)
  (let ((ht (make-hash)))

    (define (golomb-helper curr-n)
      (cond [(= curr-n 1) 1] ; base case
            [(hash-has-key? ht curr-n) (hash-ref ht curr-n)] ;exists in the table?
            [else (let ((subproblem (+ 1
                                       (golomb-helper
                                        (- curr-n
                                           (golomb-helper
                                            (golomb-helper (- curr-n 1)))))) ))
                    (hash-set! ht curr-n subproblem)
                    subproblem
                    )]
            )
      )
    (golomb-helper n)
    
    )
  )
(memo-golomb 7)


; ==========================================

#|
EXERCISE 3
Here is a solution to the unique paths problem from an exercise in the
previous chapter. (Sorry, it’s a bit of a spoiler if you haven’t tried doing
that exercise yet.) Use memoization to improve its efficiency:

def unique_paths(rows, columns):
if rows == 1 or columns == 1:
return 1
return unique_paths(rows- 1, columns) + unique_paths(rows, columns- 1)

answer:
lets try to re-implemen this
|#

; naive version
; unique-paths:: number number -> number
(define (unique-paths r c)
  (cond [(or (= r 1)(= c 1)) 1] ; found path
        [else (+ (unique-paths (- r 1) c)
                 (unique-paths r (- c 1))
                 )]
        )
  )
(unique-paths 5 5)

#|
; memoized version
(define (unique-paths-memo r c)
  ; in ht, a key is a (cons r c) and value is a Number
  (let ((ht (make-hash)))
    (define (unique-paths-helper curr-r curr-c)
      (cond [(or (= curr-r 1) (= curr-c 1)) 1] ;
            [(hash-has-key? ht (cons curr-r curr-c))
             (hash-ref ht (cons curr-r curr-c))] ; cache hit
            [else (let ((key (cons curr-r curr-c))
                        (subproblem (+ (unique-paths-helper (- curr-r 1) curr-c)
                                       (unique-paths-helper curr-r (- curr-c 1)) )))
                    (hash-set! ht key subproblem)
                    subproblem
                    )]
            )
      )
    (unique-paths-helper r c)
    

    )
  )
(unique-paths-memo 5 5)
|#

