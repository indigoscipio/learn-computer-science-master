#lang racket

#|
CONS the magnificnet

1st commandment
always ask null? as the first question in expressing any function

2nd commandment
use cons to build lists

3rd commandment
When building a list, describe the first typical element, and then cons it into the natural recursion

4th commandment
Always change at least one argument while recurring
it must be changed to be close to termination (reduce the problem into subproblem)
the changing argument must be tested in the termination condition:
when usind cdr, test termination with null?

What is (rember a lat) 
where a is mint and lat is (lamb chops and mint jelly)
Rember stands for remove a member
so it's (lamb chops and jelly)


( rember a lat) where a is mint 
and lat is (lamb chops and mint flavored mint jelly)
(lamb chops and flavored jelly)

( rember a lat) 
where a is toast 
and lat is (bacon lettuce and tomato)
(bacon lettuce and tomato)

( rember a lat) 
where a is cup 
and lat is (coffee cup tea cup and hick cup)
(coffee tea and hick)

What does ( rember a lat) do?
input: atom and a lat as its list of arguments
output: new lat with the FIRST occurence of the atom in the old lat removed

What steps should we use to do this?
(null? lat)
if its true, return '() since we're building a list
else we want to find the first occurence of the atom
either the lat is empty or it contains at least one atom

how do we ask the question

(define rember 
  (lambda (a lat) 
    (cond ((null? lat) (quote ())) 
          (else (cond ((eq ? (car lat) a) (cdr lat)) 
                      (else (cons (car lat) (rember a (cdr lat)))))))))


; List-of-List-of-X -> List-of-X
; first takes a list of lists and reutrns the first sublist of each list
(define (firsts l)
  ; Iteration 1, uses recursion
  ;(cond [(null? l) '()]
  ;      [else (cons (car (car l)) (firsts (cdr l))) ])
  
  ; Iteration 2, which uses map
  ;(map (lambda (sublist) (car sublist)) l)

  ; Iteration 3, using accumulator
  ;(define (iter list acc)
  ;  (cond [(null? list) acc]
  ;        [else (iter (cdr list) (cons (car (car list)) acc) ) ])
  ;  )
  ;  (reverse (iter l '()))

  ; Iteration 4, using fold
  ;(foldr (lambda (sublist acc) (cons (car sublist) acc)) '() l)
  
  )

(firsts '())
(firsts '((apple peach pumpkin) 
          (plum pear cherry) 
          (grape raisin pea) 
          (bean carrot eggplant)))
(firsts '((a b) (c d) (e f)))
(firsts '(((five plums) four) 
          (eleven green oranges) 
          ((no) more)))
(firsts '((five plums) 
          (four) 
          (eleven green oranges)))



What is (insertR new old lat) 
where new is topping old is fudge 
and lat is (ice cream with fudge for dessert)
ice cream with fudge topping for dessert

( insertR new old lat) 
where new is jalapeno 
old is and and 
lat is (tacos tamales and salsa)
(tacos tamales and jalapeno salsa)

( insertR new old lat) 
where new is e 
old is d and 
lat is (a b c d f g d h)
(a b c d e f g d h)

insertR inserts a new to the right of the first occurence of old  (returns a list)
takes 3 args: atoms old, new and lat



; Atom Atom List-of-Atom -> List-of-Atom
; inserts new atom to the right of the first occurence of old, and returns a list
(define (insertR new old lat)
  ; Iteration 1: recursion
  ;(cond [(null? lat) '()]
  ;      [else (cond  [(eq? (car lat) old) (cons old (cons new (cdr lat)))]
  ;                   [else (cons (car lat) (insertR new old (cdr lat))) ])]
  ;      )

  ; Iteration 2: accumulator
  ; acc builds the list until it old = new
  ;(define (iter l acc)
  ;  (cond [(null? l) '()]
  ;        [else (cond [(eq? (car l) old) (append (reverse acc) (list old new) (cdr l)) ]
  ;                    [else (iter (cdr l) (cons (car l) acc) )]) ])
  ;  )
  ;(iter lat '())

  ; Iteration 3: using foldr
  ; Using foldr with state tracking (complex approach)
; Using foldr with state tracking (corrected)
(car (foldr (lambda (current acc-pair)
              (let ((result-list (car acc-pair))
                    (found? (cdr acc-pair)))
                (if (and (eq? current old) (not found?))
                    (cons (cons current (cons new result-list)) #t)
                    (cons (cons current result-list) found?))))
            (cons '() #f)
            lat))

  )
(insertR 'topping 'fudge '(ice cream with fudge for dessert))
(insertR 'jalapeno 'and '(tacos tamales and salsa))
(insertR 'e 'd '(a b c d f g d h))
|#


; replaces the first occurence of old in the lat with new
; Atom Atom List-of-Atom -> List-of-Atom
(define (subst new old lat)
  ; Iteration 1
  ;(cond [(empty? lat) '()] ;base case: return empty list
  ;      [(eq? (car lat) old) (cons new (cdr lat)) ]; if found, replace the old with the new
  ;      [else (cons (car lat) (subst new old (cdr lat))) ])

  ; Iteration 2: accumulator
  ; accumulator acc builds the list until car lat = old is found
  (define (iter l acc)
    (cond [(null? l) '()]
          [(eq? old (car l))  (append (reverse acc) (list new) (cdr l)) ]
          [else (iter (cdr l) (cons (car l) acc)) ]
          )
    )
  (iter lat '())  
  )


; replaces either the first occurence of o1 or
; the first occurence of o2 by new
; example: new = vaniilla, o1 = chocolate, o2 = banana
; lat = (banana ice cream with chocolate topping)
; returns (vanilla ice cream with chocolate topping)
(define (subst2 new o1 o2 lat)
  ; Iteration 1: recursion
  (cond [(empty? lat) '()]
        [(or (eq? o1 (car lat))(eq? o2 (car lat))) (cons new (cdr lat))]
        [else (subst2 new o1 o2 (cdr lat))]
        )
  )
;(subst2 'vanilla 'chocolate 'banana '(banana ice cream with chocolate topping))

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
;(multirember 'cup '(coffee cup tea cup and hick cup)) ;returns (coffee tea and hick).

(define (multiinsertR new old lat)
  
   (cond [(null? lat) '()]
         [(eq? (car lat) old) (cons old (cons new (multiinsertR new old (cdr lat)))) ] ;insert to the right
        [else (cons (car lat) (multiinsertR new old (cdr lat)))] ;else recurse
         )

  
  ;Iteration 2: accumulator
  ;acc builds the list until it old = new
  ;(define (iter l acc)
  ;  (cond [(null? l) acc]
  ;        [else (cond [(eq? (car l) old) (iter (cdr l) (cons old (cons new acc))) ]
  ;                    [else (iter (cdr l) (cons (car l) acc) )]) ])
  ;  )
  ;(reverse (iter lat '()))
  
  )
;(multiinsertR 'coffee 'cup '(i drank a cup this afternoon with another cup))
; should return '(i drank a coffee cup this afternoon with another coffee cup)


(define (multisubst new old lat)
  ;iteration 1
  ;(map (lambda (x) (if (eq? x old) new x)) lat)

  ;iteration 2
  ;(foldr (lambda (x acc) (if (eq? x old) (cons new acc) (cons x acc))) '() lat)

  ;iteration 3
  (cond [(empty? lat) '()]
        [(eq? old (car lat)) (cons new (multisubst new old (cdr lat)))]
        [else (cons (car lat) (multisubst new old (cdr lat)))]
        )
  
  )
(multisubst 'new 'old '(i am old and new and old sometimes always old))
