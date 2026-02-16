;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-423b) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))

;Number [List-of-number] -> [List-of-number]
; consumes a pivot number and a list of number
; returns list of number smaller than the pivot
(define (smaller p l)
  (cond [(empty? l) l];nothing more to process, reutrn the final list
        [(< (first l) p) (cons (first l) (smaller p (rest l)))]
        [else (smaller p (rest l))];it's bigger, skip)
        ))
;(smaller 3 '(0 1 8 9 -12 -15))

; Number [List-of-number] -> [List-of-number]
; consumes pivot p and list of number l
; returnst list of number larger than given p
(define (larger p l)
  (cond [(empty? l) l]
        [(> (first l) p) (cons (first l) (larger p (rest l)))]
        [else (larger p (rest l))])
  )

; [List-of Number] -> [List-of Number]
; produces a sorted version of alon
(define (quick-sort< alon)
  (cond [(empty? alon) '()]
        [else (append  (quick-sort< (smaller (first alon) alon))
                       (list (first alon))
                       (quick-sort< (larger (first alon) alon))) ]))

(quick-sort< '(0 5 -4 8 444 59 -19))