#lang racket
(require data/heap)

#|
4-14
Give an O(nlogk)-time algorithm that merges k sorted lists with a total of n
elements into one sorted list. (Hint: use a heap to speed up the elementary O(kn)
time algorithm).

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