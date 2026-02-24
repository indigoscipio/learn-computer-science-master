#lang racket

; find elmeent that dominates in a list

; listofx -> x
; assume lst is nonempty
(define (find-majority lst)
  (let (n (quotient (length lst) 2) )
    ; if its the same, add the count
    ; if its different, reduce the count
    (define (helper xs count curr-item)
      (cond [(null? xs) ...] ; check if count > 0, if so return curr-item
            [(null? (cdr xs)) (equal? fst-item next-item)] ;one item left, do last check
            [else (let ((next-item (car xs)))
                    (cond [(equal? fst-item next-item) (helper (cdr xs) (+ 1 count) next-item)]
                          [else (helper (cdr xs) count next-item)]
                          )
                    )])
      )
    (helper (cdr lst) 1 (car lst))
    
    )  
  )
(find-majority '(a b a c a a d)) ;should reutrn a