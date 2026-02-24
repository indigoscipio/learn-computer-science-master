#lang simply-scheme

#|
23.5
23.5 Write a procedure vector–map that takes two arguments, a function and a vector, and returns a new vector in 
which each box contains the result of applying the function to the corresponding element of the argument vector.


(define (vector-map vect f)
  (let ((new-vect (make-vector (vector-length vect) 0)))
    (define (helper v i)
      (cond [(>= i (vector-length vect) ) 'done]
            [else (let* ((curr-item (vector-ref v i))
                         (mapped-item (f curr-item)))
                    (begin (vector-set! new-vect i mapped-item)
                           (helper v (+ i 1))
                           )
                    )])
      )
    (helper vect 0)
    new-vect
    )
  )
|#



#|
23.6 Write a procedure vector–map! that takes two arguments, a function and a vector, and modifies the argument 
vector by replacing each element with the result of applying the function to that element. Your procedure should return 
the same vector.
|#

; like vecotr-map but mutable
(define (vector-map! vect f)
  (let ((v-length (vector-length vect)))
    (define (helper v i)
      (cond [(< i 0) 'done]
            [else (let* ((curr-item (vector-ref v i))
                        (mapped-item (f curr-item)))
                    (begin (vector-set! v i mapped-item)
                           (helper v (- i 1)))
                    )]
            )
      )
    (helper vect (- v-length  1))
    vect
    )
  )
(vector-map! (vector 1 2 3 4 5) (λ (x) (* x x)))


#|
23.7 Could you write vector–filter? How about vector–filter!? Explain the issues involved.

answer: lets try one by one first
|#

; vector x->boolean -> number
(define (satisfies-pred-count vect pred)
  (define (helper v i)
    (cond [(>= i (vector-length vect)) 0]
          [else (let ((fst (vector-ref vect i)))
                  (if (pred fst)
                      (+ 1 (helper v (+ i 1)))
                      (helper v (+ i 1))
                      )
                  )])
    )
  (helper vect 0)
  )
(satisfies-pred-count (vector 1 2 3 4 5) even?)


(define (vector-filter vect pred)
  (let ((new-vect (make-vector (satisfies-pred-count vect pred) )))
    (define (helper v i j)
      (cond [(>= i (vector-length vect)) 'done]
            [else (let ((fst (vector-ref v i)))
                    (if (pred fst)
                        (begin (vector-set! new-vect j fst)
                               (helper v (+ i 1) (+ j 1))
                               ) ;keep it
                        (helper v (+ i 1) j)
                        )
                    )]
            )
      )
    (helper vect 0 0)
    new-vect
    )
  )
(vector-filter (vector 1 2 3 4 5) even?)

; ok it seems we have to shrink/rebuild the vector everytime the predicate is passed
; which takes alot of time. everytime  we rebuild need to fill it one by one with corect order.
; the index and length is changed and also the ordering
; im also assuming this would be the same case with vector-filter! so it's very difficult
; vector-filter ispossible but vector-filter! is not possible since vector size is set te moment at its birth
; we can't shrink physical memory ofvector

; ====================================================

#|

23.8 Modify the lap procedure to print "Car 34 wins!" when car 34 completes its 200th lap. (A harder but more 
correct modification is to print the message only if no other car has completed 200 laps.)

answer:

|#

; lets focus on getting to print simple winning message first for now
; and simplify total vecs to to 10 and total winning to 3
(define *lap-vector* (make-vector 10 0))
(define *any-winner?* #f)
(define (lap car-number)
  
  (begin (vector-set! *lap-vector* car-number (+ (vector-ref *lap-vector* car-number) 1) )
         (let ((curr-lap (vector-ref *lap-vector* car-number)))
           (if (and (= curr-lap 3) (not *any-winner?*))
               (begin (set! *any-winner?* #t)
                      (se "winner is car: " car-number)
                      )
               curr-lap
               )
           )

         )
  
  
  
  )

; ==============================================

#|
23.9 Write a procedure leader that says which car is in the lead right now
|#

(define (leader vect)
  ; find maximum value of each vector
  ; return that value
  )

