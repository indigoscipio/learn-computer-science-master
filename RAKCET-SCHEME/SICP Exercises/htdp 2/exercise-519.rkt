;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-519) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))


(define-struct cpair [count left right])
; A [MyList X] is one of:
; – '()
; – (make-cpair (tech "N") X [MyList X])
; accumulator the count field is the number of cpairs

(define cpair0 (make-cpair 3 'a (make-cpair 2 'b (make-cpair 1 'c '()))))

(define (our-cons f r)
  (cond [(empty? r) (make-cpair 1 f r)]
        [(cpair? r) (make-cpair (+ (cpair-count r) 1) f r) ]
        [else (error "our cons expects first and rest")]
        )
  )
(our-cons (cpair-left cpair0) (cpair-right cpair0))

; Any -> N
; how many items does l contain
(define (our-length l)
  (cond [(empty? l) 0]
        [(cpair? l) (cpair-count l) ]
        [else (error "our length expects l")]
        )
  )
(our-length cpair0)