#lang racket


; List-of-X -> List-of-Y
(define (leftmost l)


  (cond [(empty? l) '()]
        [(not (pair? (car l))) (car l)] ;it's an atom
        [else (let ((a (leftmost (car l))))
                (cond [(not(pair? a)) a]
                      [else (leftmost (cdr l))])
                ) ] ;it contains sublist
        )
 

  
  )
(leftmost '(() 2 5 6))
(leftmost '(((5 2) 3 4) 2 3))


; Atom List-of-X -> List-of-Y
(define (rember1* a l)

  (letrec ((F (lambda (list) (cond [(empty? list) '()]
                                   [(not(pair? (car list))) (cond [(eq? a (car list)) (cdr list)]
                                                                  [else (cons (car list) (F (cdr list)) )]
                                                                  )]
                                   [else (cond [(equal? (car list) (F (car list))) (F (cdr list)) ]
                                               [else (cons (F (car list)) (cdr list) )])]
                                   ))))
    (F l)
    )

  #|
  (cond [(empty? l) '()]
        [(not(pair? (car l))) (cond [(eq? (car l) a) (cdr l)]
                                    [else (cons (car l) (rember1* a (cdr l)))])] ; its an atom
        [else (cond [(eq? (car l) (rember1* a (car l))) (rember1* a (cdr l))]
                    [else (cons (rember1* a (car l)) (cdr l))])] ; its a sublist
        )
  |#

  ; iteration 2, using accumulator/iter
  ; accumulator acc builds the result list checked so #far
  #|
  (define (iter list is-removed? acc)
    (cond [(empty? list) acc]
          [(not (pair? (car list)) ) (cond [(eq? a (car list)) (cdr list) ]
                                           [else (iter (cdr list) #f (cons (car list) acc) )])]
          [else (cond [(equal? (car list) (iter (car list) #f acc)) (iter (cdr list) (  ))]
                      [else (iter (cdr list) (cons (car list) (iter (cdr list) '())) )])]
          )
    )
  (iter l #f '())
  |#

  ; iteration 3, using fold

  
  )
(rember1* 'salad '((Swedish rye) (French (mustard salad turkey)) salad))
(rember1* 'meat '((pasta meat) pasta (noodles meat sauce) meat tomatoes))

; The fifteenth commandment
; use let to name values of repeated expressiosn
; in a function definition if they may be evaluated twice for
; one and hte same use of the function

; counts the depth of a list of s expr
; List-of-X -> Number
(define (depth* l)

  (cond [(empty? l) 1]
        [(not (pair? (car l))) (depth* (cdr l)) ] ; its a atom
        [else (let ((sublist (+ 1 (depth* (car l))))
                    (rest (depth* (cdr l)))
                    )
                (max sublist rest)
                ) ] ; its a sublist
        )
  
  )
(depth* '(margarine ((bitter buttre) (makes) (batter (bitter))) butter))