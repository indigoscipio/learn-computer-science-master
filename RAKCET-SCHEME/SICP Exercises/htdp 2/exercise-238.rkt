;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise-238) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
(define sample-lon (list 10 3 7 5))
(define sample-lon1 (list 25 24 23 22 21 20 19 18 17 16 15 14 13
      12 11 10 9 8 7 6 5 4 3 2 1))
(define sample-lon2 (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
      17 18 19 20 21 22 23 24 25))
(define sample-lon5 (list 0 0))


; Nelon -> Number
; determines the smallest 
; number on l
(define (inf l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (if (< (first l)           (inf (rest l)))
              (first l)
              (inf (rest l)))]))


(define (sup l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (if (> (first l)
            (sup (rest l)))
         (first l)
         (sup (rest l)))]))
;(sup sample-lon)



;find takes a Comparison Operator (<, >) and a List-of-Number
; < = smallest, > = largest
;and finds a single value/number from a given lon that matches the operator
; Operator Nelon -> Number
(define (find op nelon)
  (cond [(empty? (rest nelon)) (first nelon)]
        [else (if (op (first nelon) (find op (rest nelon)))
                  (first nelon)
                  (find op (rest nelon)))])
  )
(define (inf-1 nelon) (find < nelon))
(define (sup-1 nelon) (find > nelon))




;find takes a Compa rison Operator (<, >) and a List-of-Number
; < = smallest, > = largest
;and finds a single value/number from a given lon that matches the operator
; Operator Nelon -> Number
(define (find2 op nelon)
  (cond [(empty? (rest nelon)) (first nelon)]
        [else (op (first nelon) (find2 op (rest nelon)))])
  )
(define (inf-2 nelon) (find2 min nelon))
(define (sup-2 nelon) (find2 max nelon))

