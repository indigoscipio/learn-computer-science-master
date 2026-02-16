;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-276) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
(define FILE-LOCATION "C:/Users/Samuel Oktavianus/Documents/dictionary.txt")
;(read-lines FILE-LOCATION)

; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))
;(member? "a" LETTERS)

; A Dictionary is a List-of-strings.
(define DICTIONARY (read-lines FILE-LOCATION))

; Letter Count is a struct
; define-struct String Number
(define-struct lc [letter number])

; Check if a word starts with the given letter
(define (is-first-letter? s 1s)
  (equal? (substring s 0 1) 1s)
  )

; Count how many words start with the given letter
(define (starts-with# 1s d)
  (local ((define (count-helper word acc)
            (if (is-first-letter? word 1s)
                (+ 1 acc)
                acc
                ) ) )
    (foldr count-helper 0 d) 
    )
  )

;List-of-1s -> List-of-Letter-Count
; Generate a list of lc structs for a given list of letters

(define (letter-freq lo1s)
  (local (; 1string -> List-of-LCs
          (define (create-lc 1s)
            (make-lc 1s (starts-with# 1s DICTIONARY))
            ) )
    (map create-lc lo1s)
    )
  )

; Generate a list of lc structs for all letters in LETTERS
(define (count-by-letter d)
  (letter-freq LETTERS)
  )
 
; Dictionary -> Letter Count
; It produces the Letter-Count for the letter that occurs most often as the first one in the given Dictionary.
(define (most-frequent.v2 d)
  (argmax lc-number (count-by-letter d))
  )
(most-frequent.v2 DICTIONARY)

; insert-lolc is  a function that inserts a lc into a sorted lolc
; LC LoLC (Sorted) -> LoLC (Sorted)
(define (insert-lolc lc s-lolc)
  ;if the sorted list is empty, return a list with the element
  ;if the elemnt is bigger than the first element, add it to the front
  ;else recurse and insert it into the rest the the sorted list
  (cond [(empty? s-lolc) (list lc) ]
        [(> (lc-number lc) (lc-number (first s-lolc))) (cons lc s-lolc)]
        [else (cons (first s-lolc) (insert-lolc lc (rest s-lolc)) ) ])
  )

;filter-by-letter is a function that filters words in a Dictionary by l
; 1String Dictionary -> Dictionary (LoS)
(define (filter-by-letter 1s d)

  (local ( (define (filter-helper word)
             (is-first-letter? word 1s)
             ))
    (filter filter-helper d) 
    ) 
  )
;(filter-by-letter "b" DICTIONARY)


; words-by-first-letter consumes a dictionary and produces a list of dictionarys, one per letter
; Dictionary (LoS) -> List-of-dictionaries (LoLoS)
(define (words-by-first-letter d)
  ; find all words within given d
  (local ( (define (helper x)
             (filter-by-letter x d)
             )
           (define (non-empty? l)
             (not (empty? l))
             )
           )
    (filter non-empty? (map helper LETTERS))
    )
  #| 
  (cond [(empty?  alphabet) '()]
        [(empty? (filter-by-letter (first alphabet) d)) 
     (words-by-first-letter (rest alphabet) d)] ; Skip empty lists
        [else (cons (filter-by-letter (first alphabet) d) (words-by-first-letter (rest alphabet) d)) ]
        )
  |#
  )
(words-by-first-letter DICTIONARY)