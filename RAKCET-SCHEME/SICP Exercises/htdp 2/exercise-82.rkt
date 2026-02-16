;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-82) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

; Word is a structure
; (make-word String String String)
; purpose: to ensure each word contains only three letters
(define-struct word [l1 l2 l3])
(define word-sample1 (make-word "X" "a" "V"))
(define word-sample2 (make-word "X" "c" "c"))


; compare-word is a function that takes two 3-letter word
; it produces a word that indicates where the given ones agree and disagree
; the function retains the content of the structure fields if the two agree
; otherwise it places #false in the field of the resulting word
; Hint The exercises mentions two tasks: the comparison of words and the comparison of “letters.” 
; Word Word -> Word
(define (compare-word w1 w2)
  
  (make-word
  ;compare 1st index
  (if (equal? (word-l1 w1) (word-l1 w2))
      (word-l1 w1)
      #false
      )

    ;compare 2nd index
    (if (equal? (word-l2 w1) (word-l2 w2))
      (word-l2 w1)
      #false
      )

    ;compare 3rd index
      (if (equal? (word-l3 w1) (word-l3 w2))
      (word-l3 w1)
      #false
      )
   )
  )
(compare-word word-sample1 word-sample2)