;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-399) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of 1Strings (letters)

; A List-of-words is either the following
; '() or
; (cons Word List-of-words)
; example: (List (list "c" "a" "t") (list "m" "e" "o" "w" "s"))

; 1S LoW -> LoW 
(define (prepend-to-all 1s low)
  (cond [(empty? low) '()]
        [else (cons (cons 1s (first low)) (prepend-to-all 1s (rest low)))  ])
  )

; 1String Word -> LoW
; inserts 1s everywhere at all possible positions
(define (insert-everywhere 1s w)
  (cond [(empty? w) (list (list 1s))]
        [else (cons (cons 1s w) (prepend-to-all (first w) (insert-everywhere 1s (rest w))) )  ]  
        )
  ) 

;1String LoW -> LoW
;produces a list of words like its second argument
;but with the first argument inserted at the beginning, between all letters, and at the end of all words at the given list
(define (insert-everywhere/in-all-words 1s low)
  (cond [(empty? low) '()]
        [else (append (insert-everywhere 1s (first low)) (insert-everywhere/in-all-words 1s (rest low))) ] )
  )
;(insert-everywhere/in-all-words "d" (list (list "a") (list "c")))
;(insert-everywhere/in-all-words "x" (list (list "y" "z")))
; should return (list (list "a" "d") (list "d" "a") (list "d c") (list "c" "a") )

(define names (list "Louise" "Jane" "Laura"))
; Word -> List-of-words
; creates all rearrangements of the letters in w
(define (arrangements w)
  (cond [(empty? w) (list '())]
        [else (insert-everywhere/in-all-words (first w) (arrangements (rest w)))  ]))


; [List-of String] [List-of [List-of String]] ->  [List-of [List-of String]]
; produces the list of those lists in ll that do not agree with names at any place 
(define (non-same names lol)
  (cond [(empty? lol) '()]
        [(equal? names (first lol)) (non-same names (rest lol)) ] ;remove the list and recurse
        [else (cons (first lol)
                    (non-same names (rest lol)))]; keep the list and recurse
        )
  )
;(non-same names (arrangements names))
;(arrangements names)
;(length (arrangements names))

; selects one random arrangement from the filtered list
(define (random-pick l)
  (list-ref l (random (length l) ))
  )
;(random-pick (arrangements names))

(define (gift-pick names)
  (random-pick (non-same names (arrangements names))))
(gift-pick names)
