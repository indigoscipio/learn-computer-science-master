#lang racket

; RECURSIVE ALGORITHM FOR SPEED

; functional style
; number list-of-number -> list-of-list-of-number
(define (partition pivot xs)
  (cond [(null? xs) '(()())]
        [else (let* ((fst (car xs))
                     (partition-rest (partition pivot (cdr xs)))
                     (small-xs (car partition-rest))
                     (large-xs (cadr partition-rest)))
                (if (< fst pivot)
                    (list (cons fst small-xs) large-xs)
                    (list small-xs (cons fst large-xs))
                    )
                )]
        )
  )
(partition 3 '(0 5 2 1 6)) ; should return '((0 2 1) (5 6))


; SAMPLE IMPERATIVE ARRAY
(define sample-arr (vector 0 5 2 1 6 3))

; Helper Swap 
(define (vector-swap! v i j)
  (let ((temp-i (vector-ref v i)))
    (vector-set! v i (vector-ref v j))
    (vector-set! v j temp-i)
    )
  )
(vector-swap! (vector 0 1 2 3) 0 1) ;#(1 0 2 3)

; imperative/2 pointer vector style
; returns the index where the pivot landed
(define (partition-v2 vect left right)
  (define (partition-helper p-index l r)
    (let ((left-value (vector-ref vect l))
          (right-value (vector-ref vect r))
          (pivot (vector-ref vect p-index)))
      (cond [(< left-value pivot) (partition-helper p-index (+ l 1) r )] ; move left
            [(> right-value pivot) (partition-helper p-index l (- r 1))] ;move right
            [(>= l r) (begin (vector-swap! vect p-index l) l)]
            [else (begin (vector-swap! vect l r)
                         (partition-helper p-index (+ l 1) (- r 1))
                         ) ]

            ; 3rd case: both stopped and met/crossed
            ; else case: both numbers are on wrong side, swap and continue
            ) 
      )
    )
  (partition-helper right left (- right 1))
  )
(partition-v2 sample-arr
              0
              (- (vector-length sample-arr) 1)) ;should return #(0 1 2 3 6 5)



; ================================================

; QUICKSORT


; functional style
; quicksort:: list-of-number -> list-of-number
(define (quicksort xs)
  (cond [(null? xs) '()]
        [else (let* ((pivot (car xs)) ;lets use car as pivot for simplicity
                     (part-xs (partition pivot (cdr xs)))
                     (left-part (car part-xs))
                     (right-part (cadr part-xs)))

                (append (quicksort left-part)
                        (list pivot)
                        (quicksort right-part)
                        )
                
                )]
        )
  )
(quicksort '(3 0 5 2 1 6))


; imperative style
; quicksort:: vector -> vector (sorted)
(define (quicksort-v2 vect left-index right-index)
  (cond [(>= left-index right-index) vect]
        [else (let ((pivot-index (partition-v2 vect left-index right-index) ))
                (begin (quicksort-v2 vect left-index (- pivot-index 1))
                       (quicksort-v2 vect (+ pivot-index 1) right-index)
                       )      
                )]
        )
  
  )
(quicksort-v2 sample-arr 0 (- (vector-length sample-arr) 1) )

; ======================================

; QUICKSORT ANALYSIS
; work per level = n -> each recursion 'shrinks' the subproblem by n/2
; number of levels = log n -> cuts problem in half

; ======================================


; QUICKSELECT (Rselect)
;; number list-of-number -> number
; k is zero index based
(define (quickselect k xs)
  (cond [(null? xs) '()]
        [else (let* ((pivot (car xs) ) ;lets keep the pivot car xs for simplicity
                     (part-xs (partition pivot (cdr xs)))
                     (left-xs (car part-xs))
                     (right-xs (cadr part-xs))
                     (l (length left-xs)) ; pivot is at position l
                     (r (length right-xs)))
                (cond [(= k l) pivot ] ;found it
                      [(< k l) (quickselect k left-xs) ] ;move left
                      [else (quickselect (- k l 1) right-xs ) ] ;move right
                      )
                )]
        )
  )
(quickselect 1 '(2 6 -3 5 0 -1)) ;shuold return -1


; vector version
(define sample-arr1 (vector 2 6 -3 5 0 -1))
(define (quickselect-v2 vect k left right)
  (cond [(>= left right) (vector-ref vect left)]
        [else (let ((pivot-index (partition-v2 vect left right)))
                (cond [(= k pivot-index) (vector-ref vect pivot-index)]
                      [(< k pivot-index) (quickselect-v2 vect left (- pivot-index 1))]
                      [else (quickselect-v2 vect (+ pivot-index 1) right) ]
                      )
                )]
        )
  )
(quickselect-v2 sample-arr1 1 0 (- (vector-length sample-arr1) 1)) ;shuold return -1
