#lang racket

; Atom List-of-X -> List-of-Y
; removes occurence of a in l, including nested list
(define (rember* a l)

  #|
  ; Iteration 1
  (cond [(empty? l) '()]
        [(not (pair? (car l))) (if (eq? a (car l))
                                   (rember* a (cdr l))
                                   (cons (car l) (rember* a (cdr l)))
                                   ) ] ;check if car l is an atom
        [else (cons (rember* a (car l)) (rember* a (cdr l)))] ;
        )
  


  ; Iteration 2
  ; Accumulator acc builds the correct list that's already been checked for removal
  (define (iter list acc)
    (cond [(empty? list) (reverse acc)]
          [(not (pair? (car list))) (if (eq? a (car list))
                                        (iter (cdr list) acc)
                                        (iter (cdr list) (cons (car list) acc))
                                        )] ;check if car l is an atom
          [else (iter (cdr list) (cons (iter (car list) '()) acc ))] ;else car l is a sublist. build the list with car l reuand cdr l recursed
          )
    )
  (iter l '())
  |#

  ; Iteration 3
  ; using fold
  (foldr (lambda (x acc) (if (not (pair? x)) ;if it's atom, 
                             (if (eq? a x)
                                 acc ;remove a from the list
                                 (cons x acc))
                             (cons (rember* a x) acc) ; x is a sublist, recurse
                             )) '() l)
  
  )

; Atom Atom List-of-Atoms -> List-of-Atoms
(define (insertR* new old l)
  ; Iteration 1
  ; builds the list through recursion
  (cond [(empty? l) '()]
        [(not (pair? (car l))) (if (eq? old (car l))
                                   (cons old (cons new (insertR* new old (cdr l))) ) ;insert it to the right
                                   (cons (car l) (insertR* new old (cdr l))) ;don't insert new, just build the list and recurse
                                   ) ] 
        [else (cons (insertR* new old (car l))
                    (insertR* new old (cdr l)) )] ; else it's a sublist
        )

  ; Iteration 2
  ; accumulator acc builds the correct list with new inserted on each iteration (final result)
  (define (iter list acc)
    (cond [(empty? list) (reverse acc)]
          [(not(pair? (car list))) (if (eq? (car list) old)
                                       (iter (cdr list) (cons  new (cons old acc)) ) ; insert new to the right
                                       (iter (cdr list) (cons (car list) acc)) ; don't insert, just build the list
                                       )
                                   ] 
          [else (iter (cdr list) (cons (iter (car list) '()) acc))]
          )
    )
  (iter l '())

  ; Iteration 3
  ; build the list using foldr, where acc is the list which the new item inserted on each iteration
  (foldr (lambda (x acc) (if (not(pair? x)) ; check if x is an atom
                             (if (eq? old x)
                                 (cons old (cons new acc)) ; insert new
                                 (cons x acc) ; just build the list without inserting
                                 )
                             (cons (insertR* new old x) acc) ;not an atom, recurse with the 
                             ) ) '() l)

  ; Iteration 4
  ; using map
  
  )
#|
(insertR* 'roast 'chuck '((how much (wood)) 
                          could 
                          ((a (wood) chuck)) 
                          (((chuck))) 
                          (if (a) ((wood chuck))) 
                          could chuck wood))
|#

; =============================

;The First Commandment (Final Version)
;When recurring on a list of atoms, lat, ask two questions about it: (null? lat) and else. 
;When recurring on a number, n, ask two questions about it: (zero? n) and else. 
;When recurring on a list of S-expressions, l, ask three question about it: (null? l), (atom? (car l)), and else.


; The Fourth Commandment (Final Version)
;Always change at least one argument while recurring. 
;When recurring on a list of atoms, lat, use (cdr lat).
;When recurring on a number, n, use (sub1 n).
;And when recurring on a list of S-expressions, l, use (car l) and (cdr l) if neither (null? l) nor (atom? (car l)) are true.
;It must be changed to be closer to termination.
;The changing argument must be tested in the termination condition: 
;when using cdr, test termination with null? and 
;when using sub1, test termination with zero?.

; Number List-of-X -> Number
; checks how many times an atom occurs in a list of S-Expressions
(define (occur* a l)
  ; Iteration 1
  ; classic recursion
  (cond [(empty? l) 0]
        [(not(pair? (car l))) (if (eq? a (car l))
                                  (+ 1 (occur* a (cdr l))) ; count it
                                  (occur* a (cdr l)) ;don't count it
                                  )]
        [else (+ (occur* a (car l)) (occur* a (cdr l)) )]
        )

  ; Iteration 2
  ; Accumulator acc holds the number of times a occurs in current l
  (define (iter list acc)
    (cond [(empty? list) acc]
          [(not(pair? (car list))) (if (eq? a (car list))
                                       (iter (cdr list) (+ 1 acc))
                                       (iter (cdr list) acc))]
          [else (iter (cdr list) (+ (iter (car list) 0) acc) )]
          )
    )
  (iter l 0)
  

  ; Iteration 3
  ; Using foldr
  (foldr (lambda (x acc) (if (not(pair? x)) ;check if x is an atom
                             (if (eq? x a)
                                 (+ 1 acc)
                                 acc)
                             (+ (occur* a x) acc) ;else it's a list, count & recurse the car l
                             )) 0 l)

  ; Iteration 4
  ; Using map
  )

; substitutes all occurence of old with new in a given list of S-Expressions l
; Atom Atom List-of-Atoms -> List-of-atoms
(define (subst* new old l)
  ; Iteration 1
  ; build list using  plain recursion
  (cond [(empty? l) '()]
        [(not(pair? (car l))) (if (eq? (car l) old)
                                  (cons new (subst* new old (cdr l)));repalce it
                                  (cons (car l) (subst* new old (cdr l)));just build it without replacing it
                                  )]
        [else (cons (subst* new old (car l)) (subst* new old (cdr l)) )]
        )

  ; Iteration 2
  ; build the list through accumulator acc
  ; acc holds the list built so far with old replaced by new
  (define (iter list acc)
    (cond [(empty? list) (reverse acc)]
          [(not(pair? (car list))) (if (eq? old (car list))
                                       (iter (cdr list) (cons new acc) ); replace (car list) with new
                                       (iter (cdr list) (cons (car list) acc)); just build the list with (car list)
                                       )]
          [else (iter (cdr list) (cons (iter (car list) '()) acc))] ;else car l is a sublist, recurse on it and recurse on the rest of the list
          )

    )
  (iter l '())


  ;Iteration 3
  (foldr (lambda (x acc) (if (not(pair? x))
                             (if (eq? old x)
                                 (cons new acc) ;replace x with new
                                 (cons x acc) ;keep x
                                 )
                             (cons (subst* new old x) acc) ;it's a sublist, recur on the first and rest
                             ) ) '() l)


  ; Iteration 4
  ; build the list using using map
  (map (lambda (x) (if (not(pair? x))
                       (if (eq? x old)
                           new ;replace x with new
                           x; don't replace
                           )
                       (subst* new old x) 
                       )
         ) l)
  )
#|
(subst* 'orange 'banana '((banana) 
                          (split ((((banana ice))) 
                                  (cream (banana)) 
                                  sherbet)) 
                          (banana) 
                          (bread) 
                          (banana brandy)))
|#


; Atom List-of-Atoms -> Boolean
; checks if atom a occurs in a given list l
(define (member* a l)
  ; Iteration 1
  ; check booleah using recursion
  (cond [(empty? l) #f]
        [(not(pair? (car l))) (or (eq? a (car l))
                                  (member* a (cdr l)) )]
        [else (or (member* a (car l)) (member* a (cdr l)) )]
        )
  
  )
;(member* 'chips '((potato) (chips ((with) fish) (chips))))


; finds the leftmost atom in a non-empty list of S-Expr
; that does not contain the empty list
; List-of-S-Expressions -> Atom
(define (leftmost l)
  (cond [(empty? l) '()]
        [(not(pair? (car l))) (car l)] ;(car l) is an atom
        [else (leftmost (car l))]
        )
  )

(leftmost '())
(leftmost '((potato) (chips ((with) fish) (chips))))
(leftmost '(((hot) (tuna (and))) cheese) )
(leftmost '(((() four)) 17 (seventeen)) )

(define (eqlist l1 l2)
  (cond [(and (empty? l1) (empty? l2)) #t]
        [(or (empty? l1) (empty? l2)) #f]
        [(and (equal? (car l1) (car l2))) (and (eqlist (cdr l1) (cdr l2)))]
        [(or (not(pair? (car l1))) (not(pair? (car l2)))) #f]
        [else (and (eqlist (car l1) (eqlist (car l2))) (eqlist (cdr l1) (cdr l2)) ) ]
        )
  )
;(eqlist '(beef ((sausage)) (and (soda))) '(beef ((sausage)) (and (soda))))
;(eqlist '() '())
;(eqlist '(non-empty) '())

;S-Expr S-Expr -> Boolean
(define (my-equal sexp1 sexp2)
  (cond [(and (not(pair?sexp1)) (not(pair?sexp2))) (eq? sexp1 sexp2)]
        [(or (atom? sexp1) (atom? sexp2)) #f]
        [else (eqlist sexp1 sexp2)]
        )
  )

; ================================
; The Sixth Commandment
; Simplify only after the function is correct


