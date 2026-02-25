#lang racket
(require data/heap)

(define (k-smallest unsorted-list k)
  (let ((h (make-heap <)))
    (heap-add-all! h unsorted-list)

    (define (loop curr-heap i)
      (cond [(>= i k) '()] ;stop
            [else (let ((curr-min (heap-min curr-heap))
                        (remove-min-effect (heap-remove-min! curr-heap))
                        )
                    (cons curr-min (loop curr-heap (+ i 1)))
                    
                    )]
            )
      )
    (loop h 0)    
    
    ))
(k-smallest '(5 2 8 1 30 10) 3)