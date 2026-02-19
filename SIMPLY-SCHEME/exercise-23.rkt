#lang simply-scheme

; VECTORS
(define v (make-vector 5))
(vector-set! v 0 'shoe)


(define *lap-vector* (make-vector 20 0))
*lap-vector*
(define (initialize-lap-vector i)
  (if (< i 0)
      'done
      (begin (vector-set! *lap-vector* i 0)
             (initialize-lap-vector (- i 1))
             )
      )
  )

(define (lap car-num)
  (vector-set! *lap-vector* car-num (+ (vector-ref *lap-vector* car-num) 1))
  (vector-ref *lap-vector* car-num)
  )
(lap 15)
(lap 15)
(lap 15)
(lap 15)
*lap-vector*