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

; Intersect with letrec
; List-of-X List-of-X -> List-of-Y
(define (intersect set1 set2)
  
  (letrec ((F (lambda (set) (cond [(empty? set) '()]
                                  [(member (car set) set2) (cons (car set) (F (cdr set)) )]
                                  [else (F (cdr set)) ]) ) ) )
    (if (empty? set2) '() (F set1))
    )

  )
(intersect '(a b c e) '(c d e))

#|
(define (intersectall l)

  (call/cc (lambda (hop) ( ) )

           )

  (letrec ((A (lambda (l) (cond [(empty? l) (A '())]
                                [(empty? (cdr l)) (car l)]
                                [else (intersect (car l) (intersectall (cdr l)))  ])))
           (I (lambda (s1 s2) (letrec ((J (lambda (s1) (cond [(empty? s1) '()]
                                                             [(member (car s1) s2) (cons (car s1) (I (cdr s1)) )]
                                                             [else (I (cdr s1)) ]) )))
                                
                                ...
                                )

                ) )
           )
    ...
    )
  
  
  )
(intersectall '((1 2) (2) (12 55 88 77)))
|#

; rember with letrec
(define (rember a lat)
  (letrec ((R (lambda (l) (cond [(empty? l) '()]
                                [(eq? a (car l)) (cdr l)]
                                [else (cons (car l) (R (cdr l)))]) )))
    (R lat)
    )
  )
(rember 'a '(a b c d e f a))


; takes atom a and a lat, if a occurs in lat it removes all atoms from lat beyond
; including the first occurence of a
(define (rember-beyond-first a lat)
  ; build the list through recursion
  (letrec ((F  (lambda (l) (cond [(empty? l) '()]
                                 [(eq? a (car l)) '()] ;car l = a, don't include it
                                 [else (cons (car l) (F (cdr l)))]
                                 ) )))

    (F lat)
    )

  )
;(rember-beyond-first 'desserts '(cookies chocolate mints caramel delight ginger snaps desserts chocolate mousse vanilla) )
;(rember-beyond-first 'sweetthing '(noodles spahgetti spatzle bean-thread roots potatoes yam others rice) )
;(rember-beyond-first 'roots '(noodles spahgetti spatzle bean-thread roots potatoes yam others rice) )

; takes atom a and a lat and removes all atoms from the lat UP TO AND INCLUDING the last occurence of a
; if there are no occurences of a, rember-tupto-last returns the lat
(define (rember-upto-last a lat)
  (call/cc (lambda (skip) (letrec ((R (lambda (l) (cond [(empty? l) '()]
                                                        [(eq? a (car l)) (skip (R (cdr l)))]
                                                        [else (cons (car l) (R (cdr l))) ]) )))
                            (R lat)
                            ) ) )
  )
(rember-upto-last 'cookies '(cookies chocolate mints caramel cookies gingerbreadman chocolate chip brownies))