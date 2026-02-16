;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-499) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

; List-of-numbers -> Number
; Computes the product of a list of numbers
(define (product l)
  (local (; List-of-number Number -> Number
          ; Accumulator acc is the total product accumulated so far
          ; with first item in l0
          (define (product/a l0 acc)
            (cond [(empty? l0) acc]
                  [else (product/a (rest l0) (* (first l0) acc)) ])
            ))
    (product/a l 1)
    )
  )
(product (list 1 2 3 4))

;The performance of product is O(n) where n is the length of the list.
;Does the accumulator version improve on this?
; answer: I think it's still o(n) because it processes the list one at atime
; however it's more efficient in terms of space complexity since it doesn't build chain of multiplications.


;List-of-X -> Number
; determines the number of items on a list
(define (how-many l)
  (local (; List-of-X Number -> Number
          ; invariant: acc is the total number of items in the list being counted so far
          (define (how-many/a l0 acc)
            (cond [(empty? l0) acc]
                  [else (how-many/a (rest l0) (add1 acc) ) ]
                  ))
          )
    (how-many/a l 0)
    )
  )
(check-expect (how-many '(1 2 3 4 5)) 5)
(how-many '(1 2 3 4 5))

;Does the accumulator reduce the amount of space needed to compute the resutl?
; Yes because unlike structural recursion, accumulator doesn't build up stack or perform chain of additions
; In terms of performance, it is still O(n) because we're checking each item 1 by 1