#lang racket

#|
; removes first occurence of a inside of l
; given a test? function
; Any -> Boolean Atom List-of-atoms -> List-of-atoms
(define (rember-f test? a l)
  ; Iteration 1: build the list with removed atom using recursion
  (cond [(empty? l) '()]
        [(test? (car l) a) (cdr l) ] ;if car l passes test, remove it and just return the rest
        [else (cons (car l) (rember-f test? a (cdr l)))] ; else keep recursing and build the list
        )

  ; Iteration 2: build the list using accumulator
  ; acc builds the list until it passes the test?
  (define (iter list acc)
    (cond [(empty? list) (reverse acc)]
          [(test? (car list) a) (append (reverse acc) (cdr list))] ;don't add it to the acc and don't iterate
          [else (iter (cdr list) (cons (car list) acc))]
          )
    )
  (iter l '())

  ; Iteration 3: build the list using foldr
  (foldr (lambda (x acc) (if (test? a x)
                             acc ;remove it
                             (cons x acc) ;build the list
                             )) '() l)

  ; Iteration 4: using filter
  (filter (lambda (x) (not (test? x a))) l)
  
  )
(rember-f = 5 '(6 2 5 3))
(rember-f eq? 'jelly '(jelly beans are good))
(rember-f equal? '(pop corn) '(lemonade (pop corn) and (cake)))
|#

(define (rember-f test?)  
  (lambda (a l)
    (cond [(empty? l) '()]
          [(test? (car l) a) (cdr l) ] ;if car l passes test, remove it and just return the rest
          [else (cons (car l) ((rember-f test?) a (cdr l)) )] ; else keep recursing and build the list
          )
    )
  
  )

; Insert right, that returns function version
(define (insertR test?)
  (lambda (new old l)
    (cond [(null? l) '()]
          [(eq? (car l) old) (cons old (cons new (cdr l)))]
          [else (cons (car l) ((insertR test?)new old (cdr l)))]
          )
    )
  )

; Insert left, that returns function version
(define (insertL test?)
  (lambda (new old l)
    (cond [(null? l) '()]
          [(eq? (car l) old) (cons new (cons old (cdr l)))]
          [else (cons (car l) ((insertL test?) new old (cdr l))) ]
          )
    )
  )

#|
((insertR eq?)'topping 'fudge '(ice cream with fudge for dessert))
((insertR eq?) 'jalapeno 'and '(tacos tamales and salsa))
((insertR eq?) 'e 'd '(a b c d f g d h))


((insertL eq?)'topping 'fudge '(ice cream with fudge for dessert))
((insertL eq?) 'jalapeno 'and '(tacos tamales and salsa))
((insertL eq?) 'e 'd '(a b c d f g d h))
|#

(define (seqL new old l)
  (cons new (cons old l))
  )

(define (seqR new old l)
  (cons old (cons new l))
  )

(define (seqS new old l)
  (cons new l)
  )

(define (insert-g seq)
  (lambda (new old l)
    (cond [(empty? l) '()]
          [(eq? (car l) old) (seq new old (cdr l))]
          [else (cons (car l) ((insert-g seq) new old (cdr l)) )]
          )
    )
  )

(define insertS
  (insert-g seqS)
  )

;(insertS 'old 'new '(replace old with new))

#|
; replaces old with new in one occurence
(define subst 
  (lambda (new old l) 
    (cond 
      ((null? l) (quote ())) 
      (( eq? (car l) old) (cons new (cdr l))) 
      (else (cons (car l) 
                  ( subst new old (cdr l)))))))
|#


; The Ninth Commandment
; abstract common patterns with a new function
(define (operator exp)
  (car exp)
  )

#|
(define (value nexp)
  (cond [(not(pair? nexp)) nexp] ;it is an atom
        [(eq? (car (cdr nexp)) '+) (+ (value (car nexp)) (value (caddr nexp)))]
        [(eq? (car (cdr nexp)) '*) (* (value (car nexp)) (value (caddr nexp)))]
        [else (/ (value (car nexp)) (value (caddr nexp)))]
        )
  )
|#

; Atom -> PrimitiveOperation
(define atom-to-function
  (lambda (x)
    (cond [(eq? x '+) +]
          [(eq? x '*) *]
          [else /]
          )
    )
  )

; NExpression -> Number
(define (value nexp)
  (cond [(not (pair? nexp)) nexp]
        [else ((atom-to-function (car nexp)) (value (car (cdr nexp)))
                                             (value (caddr nexp)) ) ])
  )

#|
; mutirember gives as its final value the lat with all occurences of a removed
; Atom List-of-Atom -> List-of-Atom
(define (multirember a lat)
  ;iteration 1
  ;(cond [(empty? lat) '()]
  ;      [(eq? a (car lat)) (multirember a (cdr lat))]
  ;      [else (cons (car lat) (multirember a (cdr lat)))]
  ;      )

  ; iteration 2
  ; accumulator acc builds the list with all of occurence of a removed
  ;(define (iter l acc)
  ;  (cond [(null? l) acc]
  ;        [(eq? a (car l)) (iter (cdr l) acc)]
  ;        [else (iter (cdr l) (cons (car l) acc))]
  ;        )
  ;  )
  ;(reverse (iter lat '()))

  ; iteration 3
  (filter (lambda (x) (not (eq? x a))) lat)

  ; iteration 4
  (foldr (lambda (x acc) (if (eq? x a) acc (cons x acc)  ) ) '() lat)
  )


; [Any -> Boolean] -> [Atom List-of-atom -> List-of-atom]
; mutirember gives as its final value the lat with all occurences of a removed
(define (multirember-f test?)
  (lambda (a lat)
    ; iteration 1: build removed list using recursion
    (cond [(empty? lat) '()]
          [(eq? a (car lat)) ((multirember-f test?) a (cdr lat))] ;remove from the list
          [else (cons (car lat) ((multirember-f test?) a (cdr lat)) )] ;add it in front of the list
          )

    ; iteration 2: using foldr
    (foldr (lambda (x acc) (if (eq? x a) acc (cons x acc)  ) ) '() lat)
    )
  )
|#

; [Any -> Boolean] -> [Atom List-of-atom -> List-of-atom]
; mutirember gives as its final value the lat with all occurences of a removed
(define (multiremberT test? lat)  
  ; iteration 1: build removed list using recursion
  (cond [(empty? lat) '()]
        [(test? (car lat)) (multiremberT test? (cdr lat))] ;remove from the list
        [else (cons (car lat) (multiremberT test? (cdr lat)))] ;add it in front of the list
        )
  )

(define a-friend
  (lambda (x y) (null? y))
  )


(define (multirember&co a lat col)
  (cond [(empty? lat) (col '() '())]
        [(eq? a (car lat)) (multirember&co a (cdr lat) (lambda (newlat seen) (col newlat (cons (car lat) seen)) ) )]
        [else (multirember&co a (cdr lat) (lambda (newlat seen) (col (cons (car lat) newlat) seen)))]
        )
  )
;(multirember&co 'a '(a b a c) 
;                (lambda (kept removed)
;                  (list kept removed)))


; The Tenth Commandment
; Build function to collect more than one value at a time

(define (multiinsertR new old lat)
  (cond [(null? lat) '()]
        [(eq? (car lat) old) (cons old (cons new (multiinsertR new old (cdr lat)))) ] ;insert to the right
        [else (cons (car lat) (multiinsertR new old (cdr lat)))] ;else recurse
        )
  )
;(multiinsertR 'coffee 'cup '(i drank a cup this afternoon with another cup))

; Atom Atom List-of-atom -> List-of-atom
; inserts new to the left of oldL and to the right of oldR in lat
; if oldL are oldR are different
(define (multiinsertLR new oldL oldR lat)
  (cond [(null? lat) '()]
        [(eq? (car lat) oldL) (cons new (cons oldL (multiinsertLR new oldL oldR (cdr lat)))) ] ;insert
        [(eq? (car lat) oldR) (cons oldR (cons new (multiinsertLR new oldL oldR (cdr lat))))]
        [else (cons (car lat) (multiinsertLR new oldL oldR (cdr lat))) ] ;else recurse
        )
  )
;(multiinsertLR 'coffee 'cup 'cup'(i drank a cup this afternoon with another cup))
;(multiinsertLR 'x 'a '3 '(1 a 2 b 3 a 4 b 5 a a))


; use col on the new lat, on the number of left insertions
; and the number of right insertions
; Atom Atom Atom List-of-Atom [List-of-atom Number Number -> ???]
(define (multiinsertLR&co new oldL oldR lat col)
  (cond [(empty? lat) (col '() 0 0)]
        [(eq? (car lat) oldL) (multiinsertLR&co new oldL oldR (cdr lat)
                                                (lambda (newlat li ri) (col (cons new (cons oldL newlat)) (+ 1 li) ri)))]
        [(eq? (car lat) oldR) (multiinsertLR&co new oldL oldR (cdr lat)
                                                (lambda (newlat li ri) (col (cons oldR (cons new newlat)) li (+ 1 ri))))]
        [else (multiinsertLR&co new oldL oldR (cdr lat)
                                (lambda (newlat li ri) (col (cons (car lat) newlat) li ri)) )]
        )
  )
;(multiinsertLR&co 'x 'a '3 '(1 a 2 b 3 a 4 b 5 a a) (lambda (newlat li ri) (list newlat li ri)))

; removes all odd numbers from a list of nested lists.
; List-of-S-expr -> List-of-s-expr
(define (evens-only* l)
  ; iteration 1: build the filtered list using recursion
  (cond [(empty? l) '()]
        [(not(pair? (car l))) (if (even? (car l))
                                  (cons (car l) (evens-only* (cdr l)) );keep it and recurse
                                  (evens-only* (cdr l));remove it and recurse
                                  )]; car l is an atom
        [else (cons (evens-only* (car l)) (evens-only* (cdr l)))];car lit contains sublist, recur through car l and cdr l 
        )

  ; iteration 2: build the filtered list using accumulator
  ; acc holds the filtered list built so far
  (define (iter list acc)
    (cond [(empty? list) (reverse acc)]
          [(not(pair? (car list))) (if (even? (car list))
                                       (iter (cdr list) (cons (car list) acc) ) ;insert to acc
                                       (iter (cdr list) acc) ;don't insert
                                       )] ;car l is an atom
          [else (iter (cdr list) (cons (iter (car list) '()) acc) )];car l is a list
          )
    )
  (iter l '())

  ; iteration 3: using foldr
  (foldr (lambda (x acc) (if (not(pair? x))
                             (if (even? x)
                                 (cons x acc) ;add it to acc
                                 acc ;don't add it
                                 ) ;x is an atom
                             (cons (evens-only* x) acc) ;x is a sublist
                             )) '() l)

  ; iteration 4: using filter & map
  (define (keep? x)
    (or (pair? x) (even? x)))  
  (define (process x)
    (if (pair? x)
        (evens-only* x)
        x))  
  (map process (filter keep? l))
  )
;(evens-only* '((9 1 2 8) 3 10 ((9 9) 7 6) 2))


; List-of-number -> Number
; sums odd numbers including in nested list of number
(define (sum-of-odd* l)
  (cond [(empty? l) 0]
        [(not(pair? (car l))) (if (odd? (car l))
                                  (+ (car l) (sum-of-odd* (cdr l))) ;sum it
                                  (sum-of-odd* (cdr l)) ;don't sum it
                                  )] ; car l is an atom
        [else (+ (sum-of-odd* (car l)) (sum-of-odd* (cdr l)) )] ;car l is a sublist, recur on both
        )
  )
;(sum-of-odd* '((9 1 2 8) 3 10 ((9 9) 7 6) 2) )

; List-of-number -> Number
; sums odd numbers including in nested list of number
(define (product-of-even* l)
  (cond [(empty? l) 1]
        [(not(pair? (car l))) (if (even? (car l))
                                  (* (car l) (product-of-even* (cdr l))) ;sum it
                                  (product-of-even* (cdr l)) ;don't sum it
                                  )] ; car l is an atom
        [else (* (product-of-even* (car l)) (product-of-even* (cdr l)) )] ;car l is a sublist, recur on both
        )
  )
(product-of-even* '((9 1 2 8) 3 10 ((9 9) 7 6) 2))

; builds a nested list of even numbers
; by removing the odd ones from its argument
; and simultaneously multiplies the even numbers and sums up the odd numbers that occur in the argument
; List-of-X [List-of-Y Number Number -> ???]
(define (evens-only*&co l col)
  (cond [(empty? l) (col '() 1 0)]
        [(not (pair? (car l))) (if (even? (car l))
                                   (evens-only*&co (cdr l) (lambda (newl p s) (col (cons (car l) newl) (* (car l) p) s))) ;build the list and add to product
                                   (evens-only*&co (cdr l) (lambda (newl p s) (col newl p (+ (car l) s)))) ;sum the odd number
                                   )]; car l is an atom
        [else (evens-only*&co (car l) (lambda (newcar pcar scar)
                                        (evens-only*&co (cdr l)
                                                        (lambda (newcdr pcdr scdr)
                                                          (col (cons newcar newcdr) (* pcar pcdr) (+ scar scar))))
                                        ))]; car l is a sublist, recur on both car l and cdr l
        )
  )
(evens-only*&co '((9 1 2 8) 3 10 ((9 9) 7 6) 2) (lambda (newl p s) (list newl p s)))