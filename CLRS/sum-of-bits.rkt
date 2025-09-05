#lang racket

; A Binary is either of the following:
; Number 1 or Number 0

; List-of-binaries List-of-binaries -> List-of-binaries
; adding two n-bit binary integers, stored in two n-element arrays A and B
; Assume the length of the two lists are equal
(define (sum-of-bits l1 l2)

  ; iteration 1, using iter + acc
  (define (iter list1 list2 carry acc)
    (cond [(null? list1) (if (= carry 0) (reverse acc) (reverse (cons carry acc)) )] 
          [else (let* ((sum (+ (car list1) (car list2) carry))
                       (curr-bit (remainder sum 2))
                       (new-carry (quotient sum 2))
                       )
                  (iter (cdr list1) (cdr list2) new-carry (cons curr-bit acc) )
                  )])
    )

  (let ((result   (iter (reverse l1) (reverse l2) 0 '()) ) )
    (reverse result))
  
  )
(sum-of-bits '(1 0 1) '(1 1 0))

