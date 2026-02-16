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

#|

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

|#
(define a '(1 2 3))
;exercise 2.54
;Any Any -> Boolean
(define (equal? s1 s2)
  (cond [(and (symbol? s1) (symbol? s2)) (eq? s1 s2)] ;check if they're both symbold nad the symbols are eq?
        [(and (empty? s1) (empty? s2)) #t]
        [(or (empty? s1) (empty? s2)) #f ] ; one of the list is empty and the other isn't
        [(and (list? s1) (list? s2)) (and (equal? (car s1) (car s2))
                                          (equal? (cdr s1) (cdr s2))) ] ;both of them is a list, check if they are equal
        [else (eq? s1 s2)]; else its false
        
        )
  )
(equal? '(1 2 3) '(1 2 3))
(equal? '(a (b c) d) '(a (b c) d))       ; should be #t
(equal? '(a (b c) d) '(a (b d) c))       ; should be #f
(equal? 'a 'a)                           ; should be #t
(equal? '(a) 'a)                         ; should be #f
(equal? '(1 2 (3 4)) '(1 2 (3 4)))       ; should be #t
(equal? '(1 2 (3 4)) '(1 2 (3 5)))       ; should be #f

;exercise 2.55
(car (quote (quote nigga)))
(cdr (quote (quote nigga)))
