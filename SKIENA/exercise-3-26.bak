#lang racket

; functional
(define (rev-ll ll)
  (define (helper list result)
    (cond [(null? list) result]
          [else (helper (cdr list) (cons (car list) result))]
          )
    )
  (helper ll '())
  )
(rev-ll '(1 2 3 47 5))

; Assumes 'll' is a list of mutable pairs (mcons)
(define (rev-ll-m ll)
  (let loop ((curr ll)         ; The node we are about to reverse
             (prev '()))       ; The reversed list head
    
    (cond 
      [(null? curr) prev]                  ; Base Case: return the new head
      
      [else (let ((next-node (mcdr curr)))
              (set-mcdr! curr prev)
              (loop next-node curr)
              )
            ; We need to perform three steps here: SAVE, REVERSE, ADVANCE
   
            ])))