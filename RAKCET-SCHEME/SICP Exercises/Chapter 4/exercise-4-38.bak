#lang sicp




; Exercise 4.35
; an-integer-between
; returns an integer between two bounds

#|
(define (an-integer-between low high)

  ; Number List-of-number -> List-of-number
  ; builds a list of number from low - high range
  (define (build-list min acc)
    (cond [(> min high) (reverse acc)]
          [else (build-list (+ 1 min) (cons min acc) ) ])
    )

  
  (apply amb (build-list low '())
  )
|#

(define (require p)
  (if (not p) (amb))
  )

(define (an-integer-between low high)
  (require (<= low high))
  (amb low (an-integer-between (+ low 1) high)))
(an-integer-between 3 10)

#|
(define (a-pythagorean-triple-between low high)
  (let ((i (an-integer-between low high)))
    (let ((j (an-integer-between i high)))
      (let ((k (an-integer-between j high)))
        (require (= (+ (* i i) (* j j)) (* k k)))
        (list i j k)))))
|#


;; require : Boolean -> (void)
;; Purpose: Succeeds if the Boolean is true.
;;          Otherwise, forces backtracking (causes current path to fail).
#|


(define x (amb 1 2 3))
(require (even? x))
|#