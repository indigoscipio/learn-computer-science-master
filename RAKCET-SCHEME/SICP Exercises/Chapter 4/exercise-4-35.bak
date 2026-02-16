#lang sicp

(list (amb 1 2 3) (amb 'a 'b))

(define (require p) (if (not p) (amb)))

 (define (an-element-of items)
 (require (not (null? items)))
 (amb (car items) (an-element-of (cdr items))))

(an-element-of '(1 23  4 5))

(define (an-integer-starting-from n)
 (amb n (an-integer-starting-from (+ n 1))))

(an-integer-starting-from 7)