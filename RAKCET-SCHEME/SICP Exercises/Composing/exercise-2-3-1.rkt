;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-2-3-1) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
(define (wage h)
  (* 12 h)
  )


(define (tax x)
  (* x 0.15)
  )

(define (netpay w t)
  (- (wage w) (tax t))
  )

(tax 9)
(wage 9)
(netpay 9 9)