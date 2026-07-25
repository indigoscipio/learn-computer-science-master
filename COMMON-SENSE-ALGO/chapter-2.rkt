#lang racket

; CHAPTER 2

; Ordered array
; list needs to be sorted
; comparison phase + shift + insertion phae
; if number near the end: big comparison, small shift
; if number near the begining: small comparison, lots of shift
; searching: can stop early

; Unordered array
; doesn't need to compare
; searching: needs to scan all

; BINARY SEARCH
; check the center
; shrink search space
; stop
; functional/list
(define (binary-search x xs)
  (cond [(null? xs) #f]
        [else (let* ((k (quotient (length xs ) 2))
                     (center (list-ref xs k)))
                (cond [(equal? center x) #t]
                      [(< x center) (binary-search x (take xs k))] ; search left half
                      [else (binary-search x (drop xs (+ k 1)))]; search right half
                      )
                )]
        ) 
  )
(binary-search 11 '(1 2 3 4 5 6 7 8 9 10 20 30 40))

; =======================================================

; BINARY SAERCH
; imperative/vector
(define sample-vect #(1 2 3 4 5 6 7 8 9 10 20 30 40))

; upper is vec-len - 1 (to match 0 base index thing)
(define (binary-search-vect target vect)
  (let ((lower-bound 0)
        (upper-bound (- (vector-length vect) 1)))
    
    (define (bs-vect-helper lower upper)
      (cond [(> lower upper) #f] ;not found
            [else (let* ((midpoint (quotient (+ lower upper) 2))
                         (midpoint-value (vector-ref vect midpoint)))
                    (cond [(equal? target midpoint-value) #t]
                          [(< target midpoint-value) (bs-vect-helper lower (- midpoint 1))] ;search left
                          [else (bs-vect-helper (+ midpoint 1) upper)]
                          )
                    )]
            )
      )
    (bs-vect-helper lower-bound upper-bound)
    
    )  
  )
(binary-search-vect 11 sample-vect)

; =======================================================

#|
EXERCISES 2

1. How many steps would it take to perform a linear search for the number
8 in the ordered array [2, 4, 6, 8, 10, 12, 13]?

2. How many steps would binary search take for the previous example?

3. What is the maximum number of steps it would take to perform a binary
search on an array of size 100,000?

answer:

1. ok so we have the array (2 4 6 8 10 12 13) whic has length
n = 7 and the array is already ordered

first check 2 -> check 4 -> check 6 -> check 8
since 8 is found at index 3 it stops so it only check 4 times

2. for binary search
lower = 0
upper = (- 7 1) = 6
it checks for the midpoint which is 6 / 2 = 3
index 3 = 8
check if its equal to target = 8? true
so it stops there so only take 1 step? assuming finding midpoint is instant

3. log base 2 of 100000 -> appox ~16.60964 steps 
or intuitively
100000 / 2 -> 50000
50000 / 2 -> 25000
25000 / 2 -> 12500
12500 / 2 -> 6250
3125 / 2 -> ...


|#