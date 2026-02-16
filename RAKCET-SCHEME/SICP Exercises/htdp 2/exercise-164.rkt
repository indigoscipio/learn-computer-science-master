;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-164) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define empty-loc '())
(define sample-loc (cons 1 (cons 5 '())) )

;1 USD = 0.97 EUR

;usd-to-eur is a function that converts USD to eur currency
; Number -> Number
(define (usd-to-eur n)
  (* n 0.97)
  )

(define (usd-to-eur* er n)
  (* n er)
  )


;function convert-euro converts a list of US$ into a list of EUR amount.
; List-of-currency -> List-of-curency
; List-of-currency is one of
; '()
; List-of-currency '()

(define (convert-euro loc)
  (cond [(empty? loc) '()]
        [else (cons (usd-to-eur (first loc)) (convert-euro (rest loc))) ]
        )
  )

;convert-euro* is a function that takes an exchange rate value and list of USD amount
;and converts the latter into a list of EUR amounts
; Number List-of-currency -> List-of-currency
(define (convert-euro* er loc)
    (cond [(empty? loc) '()]
        [else (cons (usd-to-eur* er (first loc)) (convert-euro* er (rest loc))) ]
        )
  )

(convert-euro empty-loc)
(convert-euro sample-loc)

(convert-euro* .97 empty-loc)
(convert-euro* .97 sample-loc)