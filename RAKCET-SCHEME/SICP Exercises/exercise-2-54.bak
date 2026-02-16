#lang racket

(define x '(1 2 3 4 5))

; if the symbol is not contained in the list, return false
;otherwise returns the sublist beginning with the first occurence of the symbol

; X List-of-X -> List-of-X or False
; linear recursion
(define (memq item l)
  (cond [(empty? l) #f]
        [(equal? item (first l)) l] ;return sublist
        [else (memq item (cdr l))]; else recurse
        )
  )

; iterative process
(define (memq.v2 item l)
  (define (memq-iter l0)
    (cond [(empty? l0) #f]
          [(equal? item (first l0)) l0]
          [else (memq-iter (cdr l0))])
    )
  (memq-iter l)
  )

;Exercise2.53:What would the interpreter print inresponse
;to evaluating each of the following expressions?

(list 'a 'b 'c)
; should print '(a b c)

(list (list 'george))
; should print '((george))

 '((x1 x2) (y1 y2))
; should print '((y1 y2))

(cadr '((x1 x2) (y1 y2)))
; should print '(y1 y2)

(pair? (car '(a short list)))
; should print false because 'a is not a pair

(memq 'red '((red shoes) (blue socks)))
;should print false because theres no 'red in the list

(memq 'red '(red shoes blue socks))
;should print '(red shoes blue socks)