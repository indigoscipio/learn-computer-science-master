#lang racket


; takes a function F and gives back a recursive function  of it
;f : (T -> R) -> (T -> R)

(define (Y f)
  ((lambda (x) (f (lambda (v) ((x x) v) )) )
   (lambda (x) (f (lambda (v) ((x x) v) ))))
  )

(define (multirember a lat)

  #|
  ((Y  (lambda (mr) (lambda (lat) (cond [(null? lat) '()]
                                        [(eq? a (car lat))  (mr (cdr lat))]
                                        [else (cons (car lat) (mr (cdr lat)))]))))
   lat
   )
  |#
  
  (letrec ((mr (lambda (lat) (cond [(null? lat) '()]
                                   [(eq? a (car lat))  (mr (cdr lat))]
                                   [else (cons (car lat) (mr (cdr lat)))])) )) (mr lat))

  )
(multirember 'list '(my list list of the list))

(define length
  (Y (lambda (length) (lambda (l) (cond [(null? l) 0]
                                        [else (add1 (length (cdr l))) ])))
     )
  )
(length '(1 2 3 4 5))

; The twelfth commandment
; use (letrec) to remove arguments


; (Atom Atom -> Boolean) -> ([Atom List-of-Atom] -> List-of-atoms)
(define (multirember-f test?)
  #|
  (lambda (a lat) (cond [(empty? lat) '()]
                        [(test? a (car lat)) ((multirember-f test?) a (cdr lat))]
                        [else (cons (car lat) ((multirember-f test?) a (cdr lat)) ) ]) )
  |#

  (letrec ((m-f (lambda (a lat) (cond [(empty? lat) '()]
                                      [(test? a (car lat)) (m-f a (cdr lat))]
                                      [else (cons (car lat) (m-f a (cdr lat)) ) ]) )))
    m-f
    )
  
  
  )

; Member with letrec
(define (member? a lat)
  
  (letrec ((member-f (lambda (l) (cond [(empty? l) #f]
                                       [(eq? a (car l)) #t]
                                       [else (member-f (cdr l))]
                                       ) )))
    (member-f lat)
    )
  
  )
(member? 'a '(b c d e))

; Union using letrec
(define (union set1 set2)
  ;recurse in set1
  ;build list
  #|
  (cond [(empty? set1) set2]
        [(member (car set1) set2) (union (cdr set1) set2)]
        [else (cons (car set1) (union (cdr set1) set2) )]
        )
  |#

  ; with letrec
  (letrec ((u-f (lambda (s1) (cond [(empty? s1) set2]
                                   [(member (car s1) set2) (union (cdr s1) set2)]
                                   [else (cons (car s1) (union (cdr s1) set2))]
                                   )) ))
    (u-f set1)
    )
  )
(union '(a b c f g h) '(b c d e f))

; Thirteenth Commandment
; Use letrec to hide and protect functions

; Two in a row with letrec
(define (two-in-a-row? lat)

  #|
  (letrec ((iter (lambda (prev rest) 
                     (cond [(empty? rest) #f]
                           [(eq? (car rest) prev) #t]
                           [else (iter (car rest) (cdr rest))]) )))
    (iter (car lat) (cdr lat))
    )
  |#

  (letrec ((F (lambda (a l) (cond [(empty? l) #f]
                                  [else (or (eq? (car lat) a) (F a lat))]) )))
    (if (empty? lat) #f (F (car lat) lat))
    )
  

  
  )
(two-in-a-row? '(a a b c d))

; sum of prefixes b using letrec
(define (sum-of-prefixes-b tup)
  (letrec ((F (lambda (tup sum)(cond [(empty? tup) '()]
                                     [else (cons (+ (car tup) sum )
                                                 (F (cdr tup) (+ sum (car tup)))) ]) )))
    (F tup 0)
    )
  )
(sum-of-prefixes-b '(1 2 3))


