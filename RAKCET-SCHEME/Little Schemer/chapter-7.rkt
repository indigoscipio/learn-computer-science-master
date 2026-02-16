#lang racket

; Friends & Relations

; List-of-Atoms List-of-Atoms -> Boolean
(define (set? lat)
  ; Iteration 1  
  (cond [(empty? lat) #t]
        [(member (car lat) (cdr lat)) #f]
        [else (set? (cdr lat))]
        )

  ; Iteration 2
  ; Accumulator acc checks the value of each item that's scanned
  (define (iter l acc)
    (cond [(empty? l) acc]
          [(member (car l) (cdr l)) #f]
          [else (iter (cdr l) acc)]
          )
    )
  (iter lat #t)

  ; Iteration 3
  ; using fold where acc holds the result of folding the rest of the list (seen)
  (not (equal? #f (foldr (lambda (atom acc) (if (member atom acc)
                                                #f ; found a duplicate, return false
                                                (cons atom acc)
                                                ))
                         '()
                         lat)))
  
  )
;(set? '(apple peaches apple plum))
;(set? '(apple peaches pears plum))
;(set? '())
;
#|

(define (multirember a lat)
  (cond [(empty? lat) '()]
        [(equal? (car lat) a)
         (multirember a (cdr lat))]
        [else
         (cons (car lat)
               (multirember a (cdr lat)))]))


; List-of-atoms -> List-of-atoms
; Builds a unique list and remove occurence with multirember
; remembers to cons the first atom in the lat onto the result of the natural recursion
; after removing all occurences of the first atom from the rest of the lat
(define (makeset lat)
  (cond [(empty? lat) '()]
        [else (cons (car lat) (makeset (multirember (car lat) (cdr lat))) )]
        ; [(member (car lat) (cdr lat)) (cons (car lat) (multirember (car lat) (cdr lat) ))]
        )
  )

(makeset '(apple peach pear peach plum apple lemon peach))
(makeset '(orange orange banana orange banana cat lemon lemon))
|#


; Creates a unique set on a given lat
; List-of-atom -> List-of-atom
(define (makeset lat)
  ; Iteration 1
  ; build a list using recursion
  (cond [(empty? lat) '()]
        [(member (car lat) (cdr lat)) (makeset (cdr lat))]
        [else (cons (car lat) (makeset (cdr lat)))]
        )

  ; Iteration 2
  ; builds a unique set using accumulator
  ; acc holds the unique item seen
  (define (iter l acc)
    (cond [(empty? l) acc]
          [(member (car l) (cdr l)) (iter (cdr l) acc)]
          [else (iter (cdr l) (cons (car l) acc) )]
          )
    )
  (iter lat '())

  ; Iteration 3
  ; using foldr to build unique list
  (foldr (lambda (atom acc) (cond [(member atom acc) acc]
                                  [else (cons atom acc)]) ) '() lat)

  
  
  )
;(makeset '(apple peach pear peach plum apple lemon peach))
;(makeset '(orange orange banana orange banana cat lemon lemon))


; Checks if a given element in set1 belongs in set2
; List-of-atoms List-of-atoms -> Boolean
(define (subset? set1 set2)
  ; iteration 1: using recursion
  ; recur on set1 as the pivot
  (cond [(empty? set1) #t]
        [(member (car set1) set2) (subset? (cdr set1) set2)]
        [else #f]
        )

  ; iteration 1 using and
  (cond [(empty? set1 ) #t]
        [else (and (member (car set1) set2) (subset? (cdr set1) set2) )])

  ; iteration 2: accumulator
  ; where acc holds already checked/seen items
  (define (iter s1 s2 acc)
    (cond [(empty? s1) #t]
          [(member (car s1) acc) (iter (cdr s1) s2 (cons (car s1) acc))] ;it's not a unique item
          [else #f] ;it's a unique item
          ) 
    )
  ; initialize with set2 as the accumulator
  (iter set1 set2 set2)

  ; Iteration 3: using fold
  (foldr (lambda (x acc) (and (member x set2) acc) ) #t set1)

  ; Iteration 4: ormap
  (not (ormap (lambda (x) (not (member x set2))) set1))

  ; Iteration 5: filter
  (empty? (filter (lambda (x) (not (member x set2))) set1))
  
  )
;(subset? '(4 pounds of horseradish) '(four pounds chicken and 5 ounces horseradish))
;(subset? '(5 chicken wings) '(5 hamburgers 2 pieces fried chicken and light duckling wings))

(define (eqset? set1 set2)
  (and (subset? set1 set2) (subset? set2 set1))
  )
;(eqset? '(6 large chickens with wings) '(6 chickens with large wings))


; List-of-atoms List-of-atoms -> Boolean
; checks if there's at least one atom in set1 that's in set2
(define (intersect? set1 set2)
  #|
  ; Iteration 1
  ; using recursion recurse through set1 and build the "intersected" list in set2
  (cond [(empty? set1) #f]
        [(member (car set1) set2) #t ] ;recurse through set1
        [else (intersect? (cdr set1) set2) ] ;else true
        )
  
 
  ; Iteration 2
  ; using or
  (cond [(empty? set1) #f]
        [else (not (not (or (member (car set1) set2) (intersect? (cdr set1) set2)))) ])
  |#

  ; Iteration 3, using acucmulator
  ; acc holds the record (Boolean) whether it's seen a match yet.
  (define (iter s1 s2 acc)
    (cond [(empty? s1) acc]
          [else (iter (cdr s1) s2 (or (not (not (member (car s1) s2) )) acc))])
    )
  ; initialize with set2 as acc
  (iter set1 set2 #f)

  ; Iteration 3: using fold
  (foldr (lambda (x acc) (or (not (not (member x set2))) acc) ) #f set1)

  ; Iteration 4: using ormap
  (not (not (ormap (lambda (x) (member x set2)) set1) )) 

  ; Iteration 5; using filter
  (not (empty? (filter (lambda (x) (member x set2)) set1)))
  
  )
;(intersect? '(stewed tomatoes and macaroni) '(macaroni and cheese))
;(intersect? '(apple paprika) '(lemon tea pancake))


; List-of-atoms List-of-atoms -> List-of-atoms
; builds a list of intersetcted item, if set1 intersects set2
(define (intersect set1 set2)
  ; Iteration 1
  ; builds intersected list with recursion
  (cond [(empty? set1) '()]
        [(member (car set1) set2) (cons (car set1) (intersect (cdr set1) set2))] ;build the list
        [else (intersect (cdr set1) set2)] ;else skip it
        )

  ; Iteration 2
  ; using accumulator, acc builds the intertected item if found
  (define (iter s1 s2 acc)
    (cond [(empty? s1) (reverse acc)] ;return the built accumulator
          [(member (car s1) s2) (iter (cdr s1) s2 (cons (car s1) acc))] ;add it to the acc
          [else (iter (cdr s1) s2 acc)] ; else don't add it to acc
          )
    )
  (iter set1 set2 '())

  ; Iteration 3, using foldr
  ; checks if an item is set1 contained in set2, if so build the new intersect list
  (foldr (lambda (x acc) (if (member x set2)
                             (cons x acc) ;add it to the acc
                             acc ;don't add it to the acc
                             )) '() set1)

  ; Iteration 4, using filter
  (filter (lambda (x) (member x set2)) set1)  
  )
;(intersect '(stewed tomatoes and macaroni) '(macaroni and cheese))
;(intersect '(apple paprika) '(lemon tea pancake))
;(intersect '() '(lemon milk tea))
;(intersect '(tea paprika) '(tea))


; List-of-atoms List-of-atoms -> List-of-atoms
; builds a union union list of set1 and set2
(define (union set1 set2)
  ; Iteration 1
  ; recur through set1 and build the unique list
  (cond [(empty? set1) set2]
        [(member (car set1) set2) (union (cdr set1) set2)] ;it's already a mmeber, don't add it
        [else (cons (car set1) (union (cdr set1) set2))] ;else add it
        )

  ; iteration 2
  ; acc builds the unique list
  (define (iter s1 s2 acc)
    (cond [(empty? s1) (reverse acc)] ;return the acc result
          [(member (car s1) s2) (iter (cdr s1) s2 acc)] ;don't add it to the acc
          [else (iter (cdr s1) s2 (cons (car s1) acc)) ] ;add it to the acc
          )
    )
  ; initialize with set2 as the acc
  (iter set1 set2 set2)
  
  ; iteration 3, with foldr
  ; each each item in set1 and build the unique list through
  ; initialize with set2 as the base case
  (foldr (lambda (x acc) (if (member x set2)
                             acc ;skip it
                             (cons x acc) ;build it
                             ) ) set2 set1)  
  )
;(union '(stewed tomatoes and macaroni casserole) '(macaroni and cheese)) ;stewed tomatoes ...
;(union '(paprika tea) '(tea and herb))
;(union '() '(something else))
;(union '(not empty) '())

; return an intersecedt list of sets
; List-of-List-of-atoms -> List-of-atoms
; assume list of sets are non empty
(define (intersectall l-set)
  ; iteration 1, using recursion
  (cond [(empty? (cdr l-set)) (car l-set)]
        [else (intersect (car l-set) (intersectall (cdr l-set)))]
        )

  ; iteration 2, using accumulator
  ; acc holds the intersection of all sets we've seen so far.
  (define (iter l acc)
    (cond [(empty? l) (reverse acc)]
          [else (iter (cdr l) (intersect (car l) acc) )]
          )
    )
  (iter l-set (car l-set))

  )
#|
(intersectall '((a b c) (c a d e) (e f g h a b)))
(intersectall '((6 pears and) 
                (3 peaches and 6 peppers) 
                (8 pears and 6 plums) 
                (and 6 prunes with some apples)))
|#


; List-of-any -> Boolean
(define (a-pair? l)
  (cond [(not(pair? l)) #f]
        [(empty? l) #f]
        [(empty? (cdr l)) #f]
        [(empty? (cdr  (cdr l))) #t]
        [else #f]
        )
  )
(a-pair? (cons 2 '()))

; Pair selectors
; Pair -> Atom
; Selects the first item of a pair
(define (first p)
  (car p)
  )

; Pair -> Atom
; selects the second item of a pair
(define (second p)
  (car (cdr p))
  )

; Pair-> Atom
; selects the third item in a pair
(define (third p)
  (car (cdr (cdr p)))
  )

;Builds a list consists of only s1 and s2
(define (build s1 s2)
  (cons s1 (cons s2 '()))
  )

; List-of-List-of-X -> List-of-X
; first takes a list of lists and reutrns the first sublist of each list
(define (firsts l)
  ; Iteration 4, using fold
  (foldr (lambda (sublist acc) (cons (car sublist) acc)) '() l)  
  )

(define (fun? rel)
  (set? (firsts rel))
  )

#|
; List-of-atoms -> List-of-atoms
; reverses a given rel/list of pairs
(define (revrel rel)
  ; Iteration 1, using recursion
  ; builds the list of new reversed pair using recursion
  (cond [(empty? rel) '()]
        [else (cons (cons (second (car rel)) (first (car rel))) (revrel (cdr rel)) )])
  

  ; Iteration 2, using accumulator
  ; acc builds each reversed pair so far
  (define (iter l acc)
    (cond [(empty? l) acc]
          [else (iter (cdr l) (cons (cons (second (car l)) (first (car l))) acc))]
          )
    )
  (reverse (iter rel '()))

  ; Iteration 3, using foldr
  ; build the reversed pair on each iteration into the acc
  (foldr (lambda (pair acc) (cons (cons (second pair) (first pair)) acc)) '() rel)

  ; Iteration 4, using map
  (map (lambda (pair) (cons (second pair) (first pair)) ) rel)


  ; Iteration 5, using build-list + list-ref
  (build-list (length rel)
              (lambda (i)
                (let ([pair (list-ref rel (- (length rel) i 1))])
                  pair
                  )))
  )
;(revrel '((8 a)(pumpkin pie)(got sick)))
|#

; Reveses a pair's content
; Pair -> Pair
(define (revpair p)
  (build (second p) (first p))
  )
(revpair '(4 8))

;redefined using revpair
(define (revrel rel)
  ; Iteration 1, using recursion
  ; builds the list of new reversed pair using recursion
  (cond [(empty? rel) '()]
        [else (cons (revpair (car rel)) (revrel (cdr rel)) )])
  
 
  ; Iteration 2, using accumulator
  ; acc builds each reversed pair so far
  (define (iter l acc)
    (cond [(empty? l) acc]
          [else (iter (cdr l) (cons (revpair (car l)) acc))]
          )
    )
  (reverse (iter rel '()))


  ; Iteration 3, using foldr
  ; build the reversed pair on each iteration into the acc
  (foldr (lambda (pair acc) (cons (revpair pair) acc)) '() rel)
 
  ; Iteration 4, using map
  (map (lambda (pair) (revpair pair) ) rel)
  )
(revrel '((8 a)(pumpkin pie)(got sick)))


; List-of-X -> Boolean
(define (one-to-one? fun)
  (fun? (revrel fun))
  )
(one-to-one? '((1 3) (1 2)))