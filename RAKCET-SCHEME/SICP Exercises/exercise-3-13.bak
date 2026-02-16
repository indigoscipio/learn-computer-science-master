#lang sicp
;(require rnrs/mutable-pairs-6)

; List-of-X List-of-Y -> List-of-Y
(define (append x y)
  (cond [(null? x) y]
        [else (cons (car x) (append (cdr x) y))])
  )

(define (last-pair l)
  (cond [(null? (cdr l)) l]
        [else (last-pair (cdr l))])
  )
(last-pair '(1 2 3 4 5 6 7))

; List-of-X List-of-Y -> List-of-Y
; like append but mutates the list
(define (append! x y)
  (set-cdr! (last-pair x) y)
  x
  )
(append! '(1 2 3 4) '(5 6 7))


(define x (list 'a 'b))
; x --> [a | *] --> [b | nil]
(define y (list 'c 'd))
; y --> [c | *] --> [d | nil]
(define z (append x y))
; z --> [a | *] --> [b | *] --> [c | *] --> [d | nil]
; since we use the unmutable "append", we createa new copy

(cdr x)
; response = ('b)

(define w (append! x y))
; response = (append! '(a b) '(c d))
; mutates x to '(a b c d)
; binds w with x = '(a b c d)

(cdr x)
; response = '(b c d)

