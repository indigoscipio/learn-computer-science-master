;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-57) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define EXPENSIVE-ITEM 10000)
(define MODERATE-ITEM 1000)
(define UNTAXED-ITEM 0)
(define UNTAXED-ITEM-TAX-RATE 0)
(define MODERATE-ITEM-TAX-RATE 0.05)
(define EXPENSIVE-ITEM-TAX-RATE 0.08)

; Item Price -> Number
; 0 - 1000
; 1000 - 10000
; 10000 above
; interpretation the price of an item
(define (sales-tax item-price)
  (cond [(and (>= item-price 0) (< item-price 1000)) 0]
        [(and (>= item-price 1000) (< item-price 10000)) (* item-price 0.05) ]
        [(>= item-price 10000) (* item-price 0.08 )]
        )
  
  )

(sales-tax 1000)

(check-expect (sales-tax 537) 0)
(check-expect (sales-tax 1000) (* 0.05 1000))
(check-expect (sales-tax 12017) (* 0.08 12017))
