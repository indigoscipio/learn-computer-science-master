#lang racket

; A Poly is a (make-poly Symbol (listof Term))
; (make-poly 'x (list t1 t2 ...)) represents a polynomial in variable x
(define-struct poly [variable terms])


; A Term is a (make-term Number Number)
; (make-term p c) represents the term c*x^p
(define-struct term [power coeff])

(define t1 (make-term 3 5)) ; 5x^3
(define t2 (make-term 1 2)) ; 2x
(define t3 (make-term 0 1)) ; 1
(define t4 (make-term 2 2)) ; 6x^2
(define t5 (make-term 1 1)) ; x
(define t6 (make-term 0 8)) ; 8


(define p1 (make-poly 'x (list t1 t2 t3))) ; 5x^3 + 2x + 1
(define p2 (make-poly 'x (list t4 t5 t6)))

; List-of-Terms List-of-Terms -> List-of-Terms
(define (add-terms terms1 terms2)
  (cond [(empty? terms1) terms2]
        [(empty? terms2) terms1]
        [else (let ((t1 (first terms1))
                    (t2 (first terms2))
                    (p1 (term-power t1))
                    (p2 (term-power t2))
                    )
                (cond [(> p1 p2) (cons t1 (add-terms (rest terms1) terms2) )]
                      [(> p2 p1) (cons t2 (add-terms terms1 (rest terms2)))]
                      [else (let ((new-coeff (+ (term-coeff t1) (term-coeff t2))))
                              (cond  [(= new-coeff 0) (add-terms (rest terms1) (rest terms2))]
                                     [else (cons (make-term p1 new-coeff) (add-terms (rest terms1) (rest terms2)))])
                              )]
                      )
                )]
        )
  )
(add-terms (list t1 t2) (list t3 t4))

; Term -> Term
; negates a term's coefficient
(define (negate-term term)
  (make-term (term-power term) (- (term-coeff term)))
  )

; Poly Poly -> Poly
; Adds two polys
(define (add-poly p1 p2)
  (cond [(equal? (poly-variable p1) (poly-variable p2)) (add-terms (poly-terms p1) (poly-terms p2))] ;if the variable is equal, add the terms
        [else (error "Variable are not the same:" (poly-variable p1) (poly-variable p2))]; else signal error
        )
  )

; Poly Poly -> Poly
; Subtracts two polys
(define (sub-poly p1 p2)
  (cond [(equal? (poly-variable p1) (poly-variable p2)) (add-terms (poly-terms p1) (map negate-term (poly-terms p2))) ]
        [else (error "Variable are not the same: "(poly-variable p1) (poly-variable p2))])
  )

; Adjoins a term into term-list
; Term -> List-of-terms
(define (adjoin-term term term-list)
  (cond [(zero? (term-coeff term)) term-list]
        [else (cons term term-list )])
  )

; List-of-Number -> Poly
; creates a dense poly from a list of a list of coefficients
(define (make-dense-poly loc)
  (make-poly 'x (map (lambda (power coeff)
                       (make-term power coeff))
                     (range (length loc))
                     loc)))


(define (div-terms L1 L2)
  (if (empty? L1)
      (list '() '())
      (let ((t1 (car L1))
            (t2 (car L2)))
        (if (> (term-power t2) (term-power t1))
            (list '() L1)
            (let ((new-c (/ (term-coeff t1) (term-coeff t2)))
                  (new-p (- (term-power t1) (term-power t2))))
              (let ((rest-of-result (div-terms (rest L1) (rest L2)) ))
                (cons (list new-p new-c) rest-of-result ) ))))))
