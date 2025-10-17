#lang racket

(define (binary-search array target)
  ; Number Number List-of-Number Number -> Number or 'not found
  (define (bs-helper low high vec target)
    (if (> low high)
        'not-found
        (let* ((mid-index (floor (/ (+ low high) 2)))
               (mid-val (vector-ref vec mid-index)))
          (cond [(= target mid-val) mid-index]
                [(< target mid-val) (bs-helper low (- mid-index 1) vec target)]
                [else (bs-helper (+ mid-index 1) high vec target)]))))

    
  (if (zero? (vector-length array))
      'not-found
      (bs-helper 0 (- (vector-length array) 1) array target)
      )
  )

(binary-search #(4 8 12 16 23 28 32) 23)
(binary-search #(1 3 5 8 13 21 34 55 89 144 233 377 634) 144)
(binary-search #(6) 6)
(binary-search #() 5)