#lang sicp

(define (require p) (if (not p) (amb)))

    
(define (distinct? items)
  (cond ((null? items) true)
        ((null? (cdr items)) true)
        ((member (car items) (cdr items)) false)
        (else (distinct? (cdr items)))))

(define (an-element-of items)
  (require (not (null? items)))
  (amb (car items) (an-element-of (cdr items))))

(define (multiple-dwelling)
  (let ((marys-father (amb 1 2 3 4 5))
        (col-downing (amb 1 2 3 4 5))
        (mr-hall (amb 1 2 3 4 5))
        (sir-barnacle (amb 1 2 3 4 5))
        (dr-parker (amb 1 2 3 4 5)))
    
    (require
      (distinct? (list (marys) )))
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
          (list 'smith smith)))


  )

(multiple-dwelling)