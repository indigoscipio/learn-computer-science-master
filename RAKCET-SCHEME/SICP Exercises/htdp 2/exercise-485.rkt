;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-485) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

;A NT (Number Tree) is one of the following:
; Number
; List-of-[Number Number]
(define nt1 1)
(define nt2 (list 2 3))
(define nt3 (list (list 1 2) 3))
(define nt4 (list 1 (list 2 3) (list 4 5)))


; NT -> Number
; determines the sum of numbers in a tree
(define (sum-tree t)
  (cond [(empty? t) 0] ;determine if it's a single number or a list
        ; if its a list, then find the sum of the pair and process the rest
        [(number? (first t)) (+ (first t) (sum-tree (rest t)) )]
        [else (+ (+ (first (first t))
                    (second (first t))) (sum-tree (rest t)) )]
        )
  )
(sum-tree nt2)
(sum-tree nt3)
(sum-tree nt4)

; abstract running time:
; n time complexity???

; worst possible shape: deeply nested list
; if the input is a deeply nested list, it's also n since we only recurse one time

; best possible shape: only a single number/input
; if the input is a single number, it's n time complexity