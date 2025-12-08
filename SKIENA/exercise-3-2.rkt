#lang racket


; reverse singly linked list
; given a singly linked list, reverses its direction
(define (reverse sll)
  (define (loop list index acc)
    (cond [(null? list) acc]
          [else (let ((last-item (list-ref list (- (length list) 1) ))
                      )
                  (if ())
                  )])
    )
  (loop sll '() )

  
  )

(reverse '(1 2 3 4 5))
