;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise-196) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
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


; is-first-letter? is a function that checks if the given letter l is the first letter of s
; List-of-String Letter -> Boolean
(define (is-first-letter? s l)
  (equal? (substring s 0 1) l)
  )
;(check-expect (is-first-letter? (explode "nigga") "n") #true )

;starts-with# consumes a letter and dictionary
; and counts how many words in the given dictionary start with the given letter.
; Letter Dictionary -> Number
(define (starts-with# l d)
  (cond [(empty? d) 0]
        [(is-first-letter? (first d) l) (+  (starts-with# l (rest d)) 1)]
        [else (starts-with# l (rest d)) ]) 
  )

;(starts-with# "a" DICTIONARY)
;(starts-with# "b" DICTIONARY)


; Letter Count is a struct
; define-struct String Number
;(define-struct lc [String Number])

;letter-freq lopos through letters a-z and find its letter occurence in a given dictionary
; List-of-1s Dictionary -> List-of-Letter-Count
(define (letter-freq l d)
  (cond [(empty? l) '() ]
        [else (cons (list (first l) (starts-with# (first l) d))  (letter-freq (rest l) d)) ])
  )  
(letter-freq LETTERS DICTIONARY)

(cons (list "a" 3)
      (cons (list "b" 1)
            (cons (list "c" 1) '())  ))

(cons (list "a" 3)
      (cons (list "b" 1)
            (cons (list "c" 1) '())))



; (cons 7 (cons 6 '()))  = list (7 6)

;(letter-freq (first l) (cons (starts-with# (first l) d) '()) )

;(cons (first l) (cons (starts-with# (first l) d) '()))
;(make-lc (first d) (starts-with# "a" d ))

;(first DICTIONARY)
;(define loop-letters)

;count-by-letter consumes a dictionary and counts how often each letter is used
; as THE FIRST ONE of a word in the given dictionary
; its result is a list of letter-counts, a piece of data that combines letters and counts
; Dictionary -> List-of-Letter-Count
(define (count-by-letter d)
  ;check for every single line of dictionary
  ;and check how many occurence of each letter there within each dictionary line/string
  (cond [(empty? d) 0 ]
        [else (letter-freq LETTERS d) ])
  )
;(count-by-letter DICTIONARY)

(define (double-list lst)
  (cond
    [(empty? lst) '()]
    [else (cons (* 2 (first lst)) ; Double the first element
                (double-list (rest lst)))])) ; Recursively process the rest