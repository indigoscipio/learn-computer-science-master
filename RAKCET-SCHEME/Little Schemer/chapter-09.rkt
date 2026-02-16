#lang racket

#|
; Atom List-of-Atom
(define (looking a lat)
  (keep-looking a (pick 1 lat) lat)
  )
|#

; starts at index 1
(define (pick n lat)
  (list-ref lat (sub1 n))
  )
;(pick 6 '(6 2 4 caviar 5 7 3))

; sorn = symbol or number
(define (keep-looking a sorn lat)
  (cond [(number? sorn) (keep-looking a (pick sorn lat) lat) ]
        [else (eq? sorn a)])
  )

(define (eternity x)
  (eternity x)
  )

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

; Pair -> Pair
; takes a pair whose first component is a pair
; and builds a pair by shifting the second part of the first component
; into the second component
(define (shift pair)

  (build (first (first pair))
         (build (second (first pair)) (second pair) ))


  )
;(shift '((a b) c))
;(shift '((a b) (c d)))

; PairOrAtom -> PairOrAtom
(define (align pora)
  (cond [(not(pair? pora)) pora]
        [(pair? (first pora)) (align (shift pora))]
        [else (build (first pora) (align (second pora)) )]
        )
  )

(define (length* l)
  (cond [(not(pair? l)) 1]
        [else (+ (length* (first l)) (length* (second l))) ]
        )
  )

(define (weight* pora)
  (cond [(not(pair? pora)) 1]
        [else (+ (* (weight* (first pora)) 2) (weight* (second pora)))])
  )

; Reveses a pair's content
; Pair -> Pair
(define (revpair p)
  (build (second p) (first p))
  )


; builds a list
(define (shuffle pora)
  (cond [(not(pair? pora)) pora]
        [(pair? (car pora)) (shuffle (revpair pora))]
        [else (build (first pora) (shuffle (second pora)))]
        )
  )

(define (C n)
  (cond [(= n 1) 1]
        [else (if (even? n)
                  (C (/ n 2))
                  (C (add1 (* 3 n)))
                  )])
  )

(define (A n m)
  (cond [(zero? n) (add1 m)]
        [(zero? m) (A (sub1 n) 1)]
        [else (A (sub1 n) (A n (sub1 m)))]
        )
  )

(define (will-stop? f)
  (f '())
  )



(((lambda (mk-length) 
    (mk-length mk-length)) 
  (lambda (mk-length) 
    (lambda (l) 
      (cond ((null? l) 0) 
            (else (add1 ((mk-length eternity) (cdr l)))))))) 
 '(apples))

; A = (lambda (mk-length) (mk-length mk-length) ) ; outer lambda
; B = (lambda (mk-length) (lambda (l) ...)) ; inner lambda
; structure wise this is similar to (A B) - apply a to b with b as the argument of a

; calls outer lambda with inner lambda as the argument
; evaluates (mk-length mk-length) so it binds outer lambda as the argument to this
; so (mk length (the outer lambda) mk-length (the outer lambda))

(define Y 
  (lambda (le) 
    ((lambda (f) (f f)) 
     (lambda(f) 
       (le (lambda (x) ((f f) x))))))) 