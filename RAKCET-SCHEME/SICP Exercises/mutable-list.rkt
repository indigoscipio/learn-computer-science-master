#lang sicp
;(require rnrs/mutable-pairs-6)

(define x '(a b c d e))
(pair? x)
x
(set-car! x '(2 2))
x
(set-cdr! x '(1 2 3 4 5 8))
x

(define z (cons x (cdr x)))
z

(set-cdr! z x)

