#lang racket

#|
4-25. [5] Assume that the array A[1..n] only has numbers from {1,...,n2} but that at
most loglogn of these numbers ever appear. Devise an algorithm that sorts A in
substantially less than O(nlogn).

find which log log n is in the array
count its occurences for each unique number we found
print them out

|#


#|
4-26. [5] Consider the problem of sorting a sequence of n 0’s and 1’s using comparisons.
For each comparison of two values x and y, the algorithm learns which of x<y,
x =y,orx>yholds.
(a) Give an algorithm to sort in n -1 comparisons in the worst case. Show that
your algorithm is optimal.
(b) Give an algorithm to sort in 2n/3 comparisons in the average case (assuming
each of the n inputs is 0 or 1 with equal probability). Show that your algorithm
is optimal.

a. worst case is O(n)
pick ai, compare with a2, a3, a4 ....
|#

(define (sort-binary binary-values)
  (define (helper xs zeroes ones)
    (cond [(empty? xs) (append zeroes ones)]
          [else (if (zero? (car xs))
                    (helper (cdr xs) (cons (car xs) zeroes) ones)
                    (helper (cdr xs) zeroes (cons (car xs) ones))
                    )]
          )
    )
  (helper binary-values '() '())
  )
(sort-binary '(1 0 0 1 0 1 0 1 0 0 1))

