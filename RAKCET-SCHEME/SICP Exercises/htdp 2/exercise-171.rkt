;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-171) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/batch-io)




;List-of-string is the following:
; '()
; String List-of-string

(define read-file-alt (read-file "C:\\Users\\Samuel Oktavianus\\Documents\\ttt.txt"))


 
; LN -> List-of-numbers
; determines the number of words on each line 
(define (words-on-line lls) '())

(define line0 (cons "hello" (cons "world" '())))
(define line1 '())
 
(define lls0 '())
(define lls1 (cons line0 (cons line1 '())))


(check-expect (words-on-line lls0) '())
(check-expect (words-on-line lls1)
              (cons 2 (cons 0 '())))
