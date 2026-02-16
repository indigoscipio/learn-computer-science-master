;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise-197) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define FILE-LOCATION "C:/Users/Samuel Oktavianus/Documents/dictionary-simple.txt")
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

; Letter Count is a struct
; define-struct String Number
(define-struct lc [letter number])

;letter-freq lopos through letters a-z and find its letter occurence in a given dictionary
; List-of-1s Dictionary -> List-of-Letter-Count
(define (letter-freq l d)
  (cond [(empty? l) '() ]
        [else (cons  (make-lc (first l) (starts-with# (first l) d)) (letter-freq (rest l) d)) ])
  )  


;count-by-letter consumes a dictionary and counts how often each letter is used
; as THE FIRST ONE of a word in the given dictionary
; its result is a list of letter-counts, a piece of data that combines letters and counts
; Dictionary -> List-of-Letter-Count
(define (count-by-letter d)
  (letter-freq LETTERS d)
  )
;(count-by-letter DICTIONARY)


;find-max is function that counts the max amount of number ina given List of LC
; LC (current max, default start with first element) List-of-LC -> LC 
(define (find-max curr-max-lc lolc)
  (cond [(empty? lolc) curr-max-lc] 
        [(> (lc-number (first lolc)) (lc-number curr-max-lc)) (find-max (first lolc) (rest lolc))]
        [else (find-max curr-max-lc (rest lolc))]
        )
  )
;(find-max (first (count-by-letter DICTIONARY)) (count-by-letter DICTIONARY))

;Approach 1: Pick the Pair with the Maximum Count:
;most-frequent consumes a dictionary
;and produces the Letter-count for the letter that occurs most often as the first one in the given dicitonary
; Dictionary -> Letter Count
(define (most-frequent d)
  (find-max (first (count-by-letter d)) (count-by-letter d))
  )
;(most-frequent DICTIONARY)


;Approach 2: Sort the List of Letter-Counts:
(define (most-frequent.v2 d)
  (first (sort-lolc (count-by-letter d)))
  )

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

;sort is a function that takes List-of-Letter-Count and returns a sorted lolc
; highest to smallest number
; LoLC (Unsorted) -> LoLC (Sorted)
(define (sort-lolc lolc)
  (cond [(empty? lolc) '()]
        [else (insert-lolc (first lolc) (sort-lolc (rest lolc)))])
  )
;(most-frequent DICTIONARY)



;filter-by-letter is a function that filters words in a Dictionary by l
; 1String Dictionary -> Dictionary (LoS)
(define (filter-by-letter l d)
  (cond [(empty? d) '()]
        ; if first letter matches, put it in front of the list
        [(is-first-letter? (first d) l) (cons (first d) (filter-by-letter l (rest d)) )]
        ;else recurse
        [else (filter-by-letter l (rest d))])
  )
;(filter-by-letter "b" DICTIONARY)


; words-by-first-letter consumes a dictionary and produces a list of dictionarys, one per letter
; Dictionary (LoS) -> List-of-dictionaries (LoLoS)
(define (words-by-first-letter alphabet d)
  ; find all words within given d
  (cond [(empty?  alphabet) '()]
        [(empty? (filter-by-letter (first alphabet) d)) 
     (words-by-first-letter (rest alphabet) d)] ; Skip empty lists
        [else (cons (filter-by-letter (first alphabet) d) (words-by-first-letter (rest alphabet) d)) ]
        )
  )
;(list 
;  (list "apple" "asphalt")  ; Words starting with "a"
;  (list "banana" "boat")    ; Words starting with "b"
;  (list "cherry" "cheese")  ; Words starting with "c"
;)
(words-by-first-letter LETTERS DICTIONARY)

(cons (list "apple" "asphalt")
      (cons (list "boat" "bat")
            (cons (list "cat" "car")'())) )

