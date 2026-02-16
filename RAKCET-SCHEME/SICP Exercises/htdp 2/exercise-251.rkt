;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise-251) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
(define sample-list (list 1 2 3 4))
; [List-of Number] -> Number
; computes the sum of 
; the numbers on l
(define (sum l)
  (cond
    [(empty? l) 0] 
    [else
     (+ (first l)
        (sum (rest l)))]))
(sum (list 1 2 3 4))

; [List-of Number] -> Number
; computes the product of 
; the numbers on l
(define (product l)
  (cond
    [(empty? l) 1]
    [else
     (* (first l)
        (product (rest l)))]))
(product (list 1 2 3 4))


; [List-of-Number] [Math Operator] Number (Base Case) -> Number
(define (fold1 lon op bc)
  (cond [(empty? lon) bc]
        [else (op (first lon)
                  (fold1 (rest lon) op bc)
                  )])
  )


(define (sum-from-fold1 lon)
  (fold1 lon + 0)
  )
(sum-from-fold1 sample-list)

(define (product-from-fold1 lon)
  (fold1 lon * 1)
  )
(product-from-fold1 sample-list)