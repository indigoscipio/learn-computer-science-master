#lang racket
(require data/heap)

#|

Quicksort
4-16. [3] Use the partitioning idea of quicksort to give an algorithm that finds the median
element of an array of n integers in expected O(n) time. (Hint: must you look at
both sides of the partition?)

|#

(define (quicksort-median lst)
  (let* ((mid-index (quotient (length lst) 2)))
    ;; partition: x listofx listof(listofx listofx listofx)
    (define (helper xs i)
      (let* ((pivot (car xs))
             (rest (cdr xs))
             (smaller (filter (λ (x) (< x pivot)) xs))
             (equal (filter (λ (x) (= x pivot)) xs))
             (larger (filter (λ (x) (> x pivot)) xs))
             (length-smaller (length smaller))
             (length-equal (length equal))
             (length-larger (length larger)))
        (cond [(< i length-smaller) (helper smaller i)]
              [(< i (+ length-smaller length-equal)) pivot]
              [else (helper larger (- i (+ length-smaller length-equal)))]
              )
        )
      )
    (helper lst mid-index)    
    )
  )

#|
5. An inversion of a permutation is a pair of elements that are out of order.

(a) Show that a permutation of n items has at most n(n-1)/2 inversions. Which
permutation(s) have exactly n(n - 1)/2 inversions?

(b) Let P be a permutation and Pr be the reversal of this permutation. Show
that P and Pr have a total of exactly n(n-1)/2 inversions.

(c) Use the previous result to argue that the expected number of inversions in a
random permutation is n(n -1)/4.

answer:
a. order is decreasing is the messiest possible arrangement
eg : {1,2,3}

1st num can be paired with n-1 number before it
2nd num can be paired with n-2 number before it

(1 + 2 + 3 + ... + n-1) = n (n-1) / 2

b. if pair is corectly ordered in p then its inversion in pr
if pair is inversion in p its corectly ordered in pr
so its the same

c.
since we know permutation p and its peverse pr always share
total possible inversions 

|#
(define sample-vect (vector 1 2 3))

(define (vector-swap! vect i1 i2)
  (let ((temp (vector-ref vect i1)))
    (vector-set! vect i1 (vector-ref vect i2))
    (vector-set! vect i2 temp)
    )
  )

(define (flag-sort vect)
  (define (helper v low mid high)
    ; look at mid pos
    (let ((mid-val (vector-ref v mid)))
      ; white: increment mid
      (cond [(> mid high) v]
            [(equal? mid-val 'W) (helper v low (+ 1 mid) high)]
            [(equal? mid-val 'R) (begin (vector-swap! v low mid)
                                        (helper v (+ 1 low) (+ 1 mid) high)
                                        )]
            [else (begin (vector-swap! v mid high)
                         (helper v low mid (- high 1))
                         )]
            )
      )
    )
  (helper vect 0 0 (- (vector-length vect) 1))
  )
(flag-sort (vector 'R 'R 'W 'B 'W 'B))