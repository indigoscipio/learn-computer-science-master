#lang sicp

;pascal

(define (pascal-triangle r c)
    (if (or (< c 0) (> c r))
              (error "Invalid input: column index is out of bounds")

  (if (or (= c 0) (= c r) )
      1
      (+ (pascal-triangle (- r 1)(- c 1)) (pascal-triangle (- r 1) c) )
      )
  ))

(pascal-triangle 0 2)


;r=1 | c=1 return 1
;r=1 | c=2 return 1
;r=1 | c=3 return 1

;r=2 | c=1 return 1
;r=2 | c=2 return 1
;r=2 | c=3 return ?

;if c=0 OR c=r return el=1
;any other elements is the sum of the two elements above it

;r=3 ;c=3 ;sum the two elements above it

;pascal(4,2)
;(pascal(3,1) + pascal(3,2))
;( (pascal(2,0) + pascal(2,1)) + (pascal(2,1) + pascal(2,2)) )
