#lang racket
range
; Number -> List-of-number
; builds a list of numbers starting from n under the limit m
(define (enumerate n m)
  (cond [(> n (- m 1)) '()]
        [else (cons n (enumerate (+ n 1) m))])
  )

; List-of-number Number -> Number
(define (sum-of-multiples ints limit)
  ; find unique multiples of each ints
  ; Number Number -> List-of-number
  ; creates a list of numbers multiples of n less than m
  (define (iter l n acc)
    (cond  [(null? l) (reverse acc)]
           [(= (remainder (car l) n) 0) (iter (cdr l) n (cons (car l) acc)) ] ; add it to acc
           [else (iter (cdr l) n acc)]
           )
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

  ; Filters the valid integer
  (define valid-ints (filter (lambda (x) (not (zero? x)) ) ints))

  ; creates the unique set
  (define unique-set (combine-set (map (lambda (n) (iter (enumerate 1 limit) n '())) valid-ints)))

  ; sum up everything
  (foldr + 0 unique-set)
  )
(sum-of-multiples '(3 5) 20)
(sum-of-multiples '(3 0) 4)