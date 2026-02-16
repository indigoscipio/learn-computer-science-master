#lang sicp

(define (require p)
  (if (not p) (amb))
  )

(define (distinct? items)
  (cond ((null? items) true)
        ((null? (cdr items)) true)
        ((member (car items) (cdr items)) false)
        (else (distinct? (cdr items)))))

#|
(define (distinct? items)
      (cond ((null? items) true)
            ((null? (cdr items)) true)
            ((member (car items) (cdr items)) false)
            (else (distinct? (cdr items)))))



(define (multiple-dwelling)
  (let ((baker
         (amb 1 2 3 4 5)) (cooper (amb 1 2 3 4 5))
                          (fletcher (amb 1 2 3 4 5)) (miller (amb 1 2 3 4 5))
                          (smith
                           (amb 1 2 3 4 5)))
    (require
      (distinct? (list baker cooper fletcher miller smith)))
    (require (not (= baker 5)))
    (require (not (= cooper 1)))
    (require (not (= fletcher 5)))
    (require (not (= fletcher 1)))
    (require (> miller cooper))
    (require (not (= (abs (- smith fletcher)) 1)))
    (require (not (= (abs (- fletcher cooper)) 1)))
    (list (list 'baker baker)
          (list 'cooper cooper)
          (list 'fletcher fletcher) (list 'miller miller)
          (list 'smith smith))))
|#


;exercise 4.38
; total solutions: 5
(define (multiple-dwelling)
  (let ((baker (amb 1 2 3 4 5))
        (cooper (amb 1 2 3 4 5))
        (fletcher (amb 1 2 3 4 5))
        (miller (amb 1 2 3 4 5))
        (smith (amb 1 2 3 4 5)))
    (require (distinct? (list baker cooper fletcher miller smith)))
    (require (not (= baker 5)))        ; Baker not on top floor
    (require (not (= cooper 1)))       ; Cooper not on bottom floor
    (require (not (= fletcher 5)))     ; Fletcher not on top floor
    (require (not (= fletcher 1)))     ; Fletcher not on bottom floor
    (require (> miller cooper))        ; Miller above Cooper
    (require (not (= (abs (- fletcher cooper)) 1))) ; Fletcher not adjacent to Cooper
    (list (list 'baker baker)
          (list 'cooper cooper)
          (list 'fletcher fletcher)
          (list 'miller miller)
          (list 'smith smith))))
