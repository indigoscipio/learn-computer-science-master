#lang racket

(define (binary-search sorted-vec target)
  (define (helper low high)
    (cond [(> low high) #f]
          [else
           (let* ((mid (quotient (+ low high) 2))
                  (mid-val (vector-ref sorted-vec mid)))
             (cond [(= mid-val target) #t]
                   [(< mid-val target) (helper (+ mid 1) high)]
                   [else              (helper low (- mid 1))]))]))
  (helper 0 (- (vector-length sorted-vec) 1)))

(define (adds-up-to-x s1 s2 x)
  ; sort s2 and convert to vector for O(1) access
  (let ((sorted-s2 (list->vector (sort s2 <))))
    (define (loop xs)
      (cond [(empty? xs) #f]
            [else
             (let ((b (- x (car xs))))
               (or (binary-search sorted-s2 b)
                   (loop (cdr xs))))]))
    (loop s1)))

(adds-up-to-x '(3 1 8) '(5 2 9) 10) ; #t  (1 + 9)
(adds-up-to-x '(3 1 8) '(5 2 9) 99) ; #f