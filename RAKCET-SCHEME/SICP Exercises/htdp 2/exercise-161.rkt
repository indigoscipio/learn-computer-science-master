;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-161) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Number -> Number
; computes the wage for h hours of work
(define HOURLY-WAGE 14)

(define (wage h)
  (* HOURLY-WAGE h))

(define empty-wage '())
(define sample-wage (cons 4 (cons 2 '())))
(define sample-wage-exceeds-100 (cons 100 (cons 108 (cons 4 (cons 2 '())))))


; List-of-numbers -> List-of-numbers
; computes the weekly wages for the weekly hours
(define (wage* whrs)

  (cond [(empty? whrs) '()]
        [(> (first whrs) 100) (error "hour exceed more than 100") ]
        [else (cons (wage (first whrs)) (wage* (rest whrs)))  ])
  )


(wage* empty-wage)
(wage* sample-wage)
(wage* sample-wage-exceeds-100)