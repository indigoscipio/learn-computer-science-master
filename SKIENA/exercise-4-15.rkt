#lang racket
(require data/heap)

#|
4-15.
a) Give an efficient algorithm to find the second-largest key among n keys.
You can do better than 2n-3 comparisons.
(b) Then, give an efficient algorithm to find the third-largest key among n keys.
How many key comparisons does your algorithm do in the worst case? Must your
algorithm determine which key is largest and second-largest in the process?

answer:
a. winner play 7 total match

peopel who lost to someone other than the winner cannot be second largest
build tournament bracket
identify candidates - find anyone who lost to the winner
find the best of the losers (find the max of those loser candiates)

|#


(define (merge . lst)
  (let ((h (make-heap (λ (a b) (< (car a) (car b)))) ))
    ; put first element of each list in the heap
    (heap-add-all! h (filter (λ (x) (not (empty? x))) lst))
    (define (loop pairs)
      (cond [(zero? (heap-count h)) '()]
            [else (let* ((smallest (heap-min pairs))
                        (v (car smallest))
                        (rest (cdr smallest)))
                    (heap-remove-min! pairs)
                    (if (empty? rest)
                        '()
                        (heap-add! pairs rest)
                        )
                    (cons v (loop pairs))
                    )]
            )
      )
    (loop h)
    )
  )
(merge '(1 10 20) '(2 5 6) '(3 7 8))


#|
; given a list constructs a max heap
(define (create-heap lst)
  (let ((vect (list->vector lst)))
    (define (left-child i)
      (let ((idx (+ (* 2 i) 1)))
        (if (< idx (vector-length vect))
            idx
            #f))) ; #f means "no child exists here"

    (define (right-child i)
      (vector-ref vect (+ (* 2 i) 2))
      )

    (define (parent i)
      (vector-ref vect (floor (/ (- i 1) 2)))
      )

    
    )
  )
(create-heap '(1 2 3 4 5 6))
|#