#lang racket


; An Entry is a pair of lists
; (cons (List-of-X) (List-of-x) )
; whose first list is a set
; two lists must be of a equal length

;examples
;'((1 2 3 4) (8 8 8 8))
;'((appetizer entree beverage) (pate boeuf vin))

(define (build a b)
  (list a b)
  )

(define new-entry build)

(define (first l)
  (car l)
  )

(define (second l)
  (car (cdr l))
  )

; Atom Entry XXX -> MaybeValue
(define (lookup-in-entry name entry entry-f)
  (lookup-in-entry-help name (first entry) (second entry) entry-f)
  )

; Atom List-of-Atom List-of-Atom 
(define (lookup-in-entry-help name names values entry-f)
  ; Iteration 1: using recursion
  (cond [(empty? names) entry-f] ;no value found, apple entry-f to name
        [(eq? name (car names)) (car values)] ;return the value
        [else (lookup-in-entry-help name (cdr names) (cdr values) entry-f)])

  )

;(lookup-in-entry 'entree '((appetizer entree beverage) (food tastes good)) '())
;(lookup-in-entry 'dessert '((appetizer entree beverage) (food tastes good)) '())


; A Table (environment) is a list of entries
; empty table: '()
; or '(((key1 key2) (value1 value2)) ((food1 food2) (lunch1 lunch2)))

; Entry Table -> Table
(define extend-table
  cons
  )

; Atom Table [X -> Y]
(define (lookup-in-table name table table-f)
  (cond [(empty? table) (table-f name)]
        [else (lookup-in-entry name (car table) (lambda (entry) (lookup-in-table name (cdr table) table-f) ) ) ] ;key is found in entry
        )
  )

#|
(define (expression-to-action  e)
  (cond 
    ((not (pair? e)) (atom-to-action e)) 
    (else (list-to-action e))))


(define atom-to-action 
  (lambda (e) 
    (cond 
      ((number? e) *const) 
      ((eq? e #t) *const) 
      ((eq? e #f) *const) 
      ((eq? e (quote cons)) *const) 
      ((eq? e (quote car)) *const) 
      ((eq? e (quote cdr)) *const) 
      ((eq? e (quote null?)) *const) 
      ((eq? e (quote eq?)) *const) 
      ((eq? e (quote atom?)) *const) 
      ((eq? e (quote zero?)) *const) 
      ((eq? e (quote add1)) *const) 
      ((eq? e (quote sub1)) *const) 
      ((eq? e (quote number?)) *const) 
      (else *identifier))))

(define (list-to-action e)
  (cond [(not(pair? (car e))) (cond [((eq? (car e) 'quote) *quote)] ;lambda
                                    [((eq? (car e) 'lambda) *lambda)] ;application
                                    [((eq? (car e) 'cond) *cond)] ;quote
                                    [else *application]; cond
                                    )] ; car e is an atom
        [else *application]
        )
  )


(define (value e)
  (meaning e '())
  )

(define (meaning e table)
  ((expression-to-action e) e table)
  )
|#

(define (*const e table)
  (cond 
    ((number? e) e) 
    ((eq? e #t) #t) 
    ((eq? e #f) #f) 
    (else (build (quote primitive) e))))

(define (*quote e table)
  (text-of e)
  )

(define text-of second )

(define (*identifier e table)
  (lookup-in-table e table initial-table)
  )

(define (initial-table name)
  '()
  )

(define (*lambda e table)
  (build '(non-primitive) (cons table (cdr e)))
  )

(define table-of first) 
(define formals-of second) 
(define body-of third)

