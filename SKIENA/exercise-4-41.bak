#lang racket

#|
4-36. [5] Consider an n×n array A containing integer elements (positive, negative, and
zero). Assume that the elements in each row of A are in strictly increasing order,
and the elements of each column of A are in strictly decreasing order. (Hence there
cannotbetwozeroes inthesameroworthesamecolumn.)Describeanefficient
algorithm that counts the number of occurrences of the element 0 in A.Analyzeits
running time.
|#

(define (count-occurence m)
  (let ((n (length m)))

    (define (walk r c acc)
      (cond [(or (= r n) (< c 0)) acc]
            [else (let ((ref (list-ref (list-ref m r) c)))
                    (cond [(zero? ref) (walk (+ r 1) (+ c 1) (+ 1 acc))]
                          [(> ref 0) (walk r (- c 1) acc) ] ;go left
                          [else (walk (+ r 1) c acc )] ; too small, go up
                          )
                    )])
      )
    (walk 0 (- n 1) 0)
    
    )
  )
(count-occurence '(( -2  0  2)
                   ( -5 -1  1)
                   ( -8 -4 -2))) ; Should return 1

(count-occurence '((  0  2  5)
                   ( -3  0  1)
                   ( -6 -2  0))) ; Should return 3) ; Should return 3

                 
(count-occurence '((  1  2  3)
                   ( -1  1  2)
                   ( -3 -2 -1))) ; Should return 0 ;

