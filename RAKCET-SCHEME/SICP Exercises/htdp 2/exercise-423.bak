;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-423) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define sample-list (list "a" "b" "c" "d" "e" "f" "g" "h"))

; [List-of X] N -> [List-of X]
; keeps the first n items from l if possible or everything
(define (take l n)
  (cond [(zero? n) '()]
        [(empty? l) '()]
        [else (cons (first l)
                    (take (rest l) (sub1 n))) ])
  )


; [List-of X] N -> [List-of X]
; removes the first n items from l if possible or everything
(define (drop l n)
  (cond [(zero? n) l] ; stop dropping
        [(empty? l) l]
        [else (drop (rest l) (sub1 n)) ]
        )
  )


;consumes l and natural number n, ;outputs a list of chunks of size n
;each chunk represents a sub-sequence of items in l
;Use list->chunks to define bundle via function composition. 

; [List-of-X N] -> [List-of-[List-of-Y]]
(define (list->chunks l n)
    (cond [(or (empty? l) (zero? n)) '()]
        [else (cons (take l n)
                    (list->chunks (drop l n) n))]
        )
  )

; [List-of 1String] N -> [List-of String]
; bundles chunks of s into strings of length n
(define (bundle s n)
  (map implode (list->chunks s n))
  )

;exercise 423 ;Define partition. It consumes a String s and a natural number n.
;The function produces a list of string chunks of size n.
;Hint Have partition produce its natural result for the empty string. For the case where n is 0, see exercise 421.


;String Number -> List-of-string (with chunk size of n)

(define (partition s n)
  (cond [(or (empty? s) (zero? n)) '()]
        [(< (string-length s) n) (list s) ] 
        [else (cons (substring s 0 n)
                    (partition (substring s n) n))] 
        )
  ) 
(partition "abcdefg" 3)
(check-expect (partition "abcdefg" 3) (list "abc" "def" "g"))


(substring "abcdef" 0 3)
;(substring "abcdef" 8)
(string-length "abc")