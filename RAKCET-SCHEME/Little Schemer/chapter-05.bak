#lang racket


#|
The First Commandment
when recurring on a list of atoms, lat, ask two questions:
null? lat and else

when recurring on a number n, ask two questions:
zero? n and else

The fourth commandment
Always change at least one argument while recurring. It 
must be changed to be closer to termination. The changing 
argument must be tested in the termination condition: 
when using cdr, test termination with null? and 
when using sub1, test termination with zero?.

The fifth commandment
When building a value with + always use 0 for the base case value
adding 0 does not affect the value of addition

When building a value with * always use 1 for the base case value
multiplying by 1 does not affect the value of multiplication

when building a value with cons always consider '() as the base case

|#

; Number Number -> Number
(define (add x y)
  (cond [(zero? x) y]
        [else (add (sub1 x) (add1 y)) ])
  )

(define (add.v2 x y)
  (cond [(zero? x) y]
        [else (add1 (add.v2 (sub1 x) y) ) ])
  )

(define (sub x y) 
  (cond [(zero? y) x]
        [else (sub (sub1 x) (sub1 y) )])
  )

(define (addtup tup)
  ; iteration 1
  (cond [(null? tup) 0]
        [else (+ (car tup) (addtup (cdr tup)))])

  ; iteration 2
  (define (iter l acc)
    (cond [(empty? l) acc]
          [else (iter (cdr l) (+ (car l) acc))]
          )
    )
  (iter tup 0)

  ; iteration 3
  (foldr + 0 tup)
  )

(define (mul x y)
  ; Iteration 1
  (cond [(zero? y) 0]
        [else (+ x (mul x (sub1 y)))])

  ; Iteration 2
  ; acc holds the result
  (define (iter a b acc)
    (cond [(zero? b) acc]
          [else (iter a (sub1 b) (+ a acc))]
          )
    )
  (iter x y 0)  
  )

; List-of-Number List-of-Number -> Number
; sums up car of tup1 and tup2 and returns a new lsit with the amount added each
(define (tup+ tup1 tup2)


  ; Iteration 1
  (cond [(and (empty? tup1) (empty? tup2)) '()]
        [(empty? tup1) tup2]
        [(empty? tup2) tup1]
        [else (cons (+ (car tup1) (car tup2)) (tup+ (cdr tup1) (cdr tup2)) )])


  ; Iteration 2 (only equal length)
  ; (map (lambda (x y) (+ x y) ) tup1 tup2)

   
  ; Iteration 3
  (define (iter l1 l2 acc)
    (cond [(and (empty? l1) (empty? l2)) acc]
          [(empty? l1) l2]
          [(empty? l2) l1]
          [else (iter (cdr l1) (cdr l2) (cons (+ (car l1) (car l2)) acc))])
    )
  (reverse (iter tup1 tup2 '()))

 

  ; Iteration 4 (fore qual length only)
  (foldr (lambda (x y acc) (if (and (empty? x) (empty? y))
                               acc
                               (cons (+ x y) acc)))
         '()
         tup1 tup2)
  )
;(tup+ '(3 7 12) '(4 6 13))
;(tup+ '(3 7 12) '(4))
;(tup+ '() '())


; Number Number -> Boolean
(define (gt x y)
  (cond [(zero? x) #f]
        [(zero? y) #t]                
        [else (gt (sub1 x) (sub1 y)) ])
  
  )
;(gt 120 11)
;(gt 11 120)
;(gt 0 0)

; Number Number -> Boolean
(define (lt x y)
  (cond [(zero? y) #f]
        [(zero? x) #t]                       
        [else (lt (sub1 x) (sub1 y)) ])
  
  )
;(lt 120 11)
;(lt 11 120)
;(lt 0 0)

; Number Number -> Boolean
(define (eq a b)

  ; initial code
  (cond [(zero? a) (zero? b)]
        [(zero? b) #f]      
        [else (eq (sub1 a) (sub1 b))])

  ; rewritten using < and >
  (cond [(< a b) #f]
        [(> a b) #f]
        [else #t]
        
        )  
  )

; Number Number -> Number
; given two numbers exp returns base a to the power of b
(define (exp a b)
  ; Iteration 1
  (cond [(zero? b) 1]
        [else (* a (exp a (sub1 b))) ])

  ; Iteration 2
  ; accumulator acc holds the power counter
  ; each iteration it reduce until 0
  (define (iter base power acc)
    (cond [(zero? power) acc]
          [else (iter base (sub1 power) (* base acc) )])
    )
  (iter a b 1)
  )
;(exp 1 1)
;(exp 2 3)
;(exp 5 3)

(define (div a b)
  ; Iteration 1
  (cond [(< a b) 0]
        [else (add1 (div (- a b) b)) ])

  ; Iteration 2
  (define (iter a b acc)
    (cond [(< a b) acc]
          [else (iter (- a b) b (+ 1 acc)) ])
    )
  (iter a b 0)  
  )

; List-of-X -> Number
(define (my-length l)

  ; Iteration 1
  (cond [(empty? l) 0]
        [else (+ 1 (my-length (cdr l)))])

  ; Iteration 2
  ; accumulator acc holds each counted car
  (define (iter list acc)
    (cond [(empty? list) acc]
          [else (iter (cdr list) (add1 acc))])
    )
  (iter l 0)
  
  ; Iteration 3
  (foldr (lambda (x acc) (+ 1 acc) ) 0 l)
  
  )

; Number List-of-Atom -> MaybeAtom
(define (pick n lat)
  ; Iteratio n1
  (cond [(zero? (sub1 n)) (car lat)]
        [else (pick (sub1 n) (cdr lat))])
  )


; List-of-Atoms -> List-of-Atoms
; no-nums returns a lat obtained by removing all number occurence from the lat
(define (no-nums l)
  ; Iteration 1
  (filter (lambda (x) (not (number? x))) l)

  ; Iteration 2
  (cond [(empty? l) '()]
        [(number? (car l)) (no-nums (cdr l))] ;put it and recurse
        [else (cons (car l) (no-nums (cdr l)))])

  ; Iteration 3
  ; accumulator holds the non-number list/final result
  (define (iter list acc)
    (cond [(empty? list) acc]
          [(number? (car list)) (iter (cdr list) acc) ]
          [else (iter (cdr list) (cons (car list) acc))]
          )
    )
  (reverse(iter l '()))

  ; Iteration 4
  (foldr (lambda (x acc) (if (number? x) acc (cons x acc) )) '() l)
  
  )
;(no-nums '(5 pears 6 prunes 9 dates))

(define (eqan? a1 a2)
  (cond [(and (number? a1) (number? a2)) (= a1 a2)]
        [(or (number? a1) (number? a1)) #f]
        [else (eq? a1 a2)]
        )
  )


; Atom List-of-Atom -> Number
; counts the num of times atom a appears in a lat
(define (occur a lat)


  ; Iteration 1
  (cond [(empty? lat) 0]
        [(eq? a (car lat)) (add1 (occur a (cdr lat)))] ;add1 and recur
        [else (occur a (cdr lat))])
 

  ; Iteration 2
  ; accumulator acc counts the number of times atom a occurs on l
  (define (iter l acc)
    (cond [(empty? l) acc]
          [(eq? a (car l)) (iter (cdr l) (add1 acc))]
          [else (iter (cdr l) acc)]
          )
    )

  (foldr (lambda (x acc) (if (eq? x a) (+ 1 acc) acc)) 0 lat)
  
  )

(define (one? n)
  (= n 1)
  )
(one? 1)
(one? 3)