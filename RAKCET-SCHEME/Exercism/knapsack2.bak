#lang racket



; Number List-of-Number List-of-Number List-of-Number
(define (knapsack capacity weights values)
  ; on each iteration store the best value accomulated so far
  ; Number List-of-Number List-of-Number -> List-of-number
  (define cache (make-hash))
  
  (define (loop c w v)
    (cond [(null? w) 0] ;
          [(<= c 0) 0] ;max capacity reached
          [else (let* ((take (if (<= (car w) c)
                                (+ (car v) (loop (- c (car w)) (cdr w) (cdr v)))
                                0 ))
                      (skip (loop c (cdr w) (cdr v)) )
                      (result (max take skip))
                      )
                  result
                  )]
          )
    )
  (loop capacity weights values)  
  )

(knapsack 100 '() '() ) ;return 0
(knapsack 10 '(100) '(1)) ; return 0
(knapsack 10 '(2 2 2 2 10) '(5 5 5 5 21)) ;21
(knapsack 10 '(2 2 2 2 10) '(20 20 20 20 50)) ;80
(knapsack 10 '(5 4 6 4) '(10 40 30 50)) ;90

#|
(if (hash-has-key? cache key)
    (hash-ref cache key)   ; already solved this subproblem
    (begin
      ...compute result...
      (hash-set! cache key result)
      result))
|#