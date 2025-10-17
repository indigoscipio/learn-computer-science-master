#lang racket

; List-of-number Number -> Number
(define (sum-of-multiples ints limit)
    ; Filters the valid integer
  (define valid-ints (filter (lambda (x) (not (zero? x)) ) ints))
  
  ; find unique multiples of each ints
  ; Number Number -> List-of-number
  ; creates a list of numbers multiples of n less than m
  (define (multiples-of l n)
    (filter (lambda (x) (= (remainder x n) 0)) l)
    )

  ; combine a given nested list into a unique flat set
  ; List-of-List-of-X -> List-of-Y
  (define (combine-set l)
    (let ((list (foldr append '() l)))      
      (foldr (lambda (x acc) (if (member x acc)
                                 acc ;remove it
                                 (cons x acc) ;add it
                                 )) '() list)
      )
    )
  
  ; creates the unique set
  (define unique-set (combine-set (map (lambda (n) (multiples-of (range 1 limit) n)) valid-ints)))

  ; sum up everything
  (foldr + 0 unique-set)
  )
(sum-of-multiples '(3 5) 20)
(sum-of-multiples '(3 0) 4)