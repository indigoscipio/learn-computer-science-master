#lang racket



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
          [(empty? (cdr xs)) (if (zero? (car xs))
                                 (append (cons 0 zeroes) ones )
                                 (append zeroes (cons 1 ones))
                                 )] ; 1 item left, do the final comparison
          [else (let ((x (car xs))
                      (y (cadr xs)) )
                  (if (equal? x y)
                      (if (zero? x)
                          (helper (cddr xs) (cons 0 (cons 0 zeroes)) ones)
                          (helper (cddr xs) zeroes (cons 1 (cons 1 ones)))
                          )
                      (helper (cddr xs) (cons 0 zeroes) (cons 1 ones))
                      )
                  )]
          )
    )
  (helper binary-values '() '())
  )
(sort-binary '(1 0 0 1 0 1 0 1 0 0 1))

