#lang racket

; a Word is a String
; it can contain an apostrophe
; it can contain a number/digit
; it contain a letter
; examples: "123", "one", "two", "you're"

; a Sentence is a String
; "That's the password!", "Cried the special agent"
; can be seperated by any form of punctuation (!, ?, :) or whitespace (\t, \r, \n, \s)

; a WordCount is a list of [cons Word Number]
; example: '((one . 3)(word . 5)(each . 4))

; Character -> Boolean
; given a char, checks if its a whitespace
(define (char-whitespace? char)
  (or (eq? char #\tab)
      (eq? char #\return)
      (eq? char #\newline)
      (eq? char #\space)
      )
  )

; checks if a given char is a valid word-char
; that is, it's either a number, alphabetic or apostrophe'
(define (word-char? char)
  (or (char-alphabetic? char)
      (char-numeric? char) ; how to check number?
      (eq? char #\')
      )
  )

; List-of-characters -> Boolean
; Given a list of chars (already lowercased), replace every character
; that is NOT a word-character (letters, digits, apostrophe) with #\space.
(define (normalize-seperators chars)
  ; using filter/hi-ord
  (filter (lambda (char) (word-char? char)) chars)

  ; using structural recursion
  ; build the list on each iteration
  (define (loop l)
    (cond [(null? l) '()]
          [(not (word-char? (car l))) (cons #\space (loop (cdr l))) ]
          [else (cons (car l) (loop (cdr l)))]
          )
    )
  (loop chars)  
  )
(normalize-seperators '(#\w #\o #\r #\d #\! #\1 #\;))

#|
; collects valid chars until the first whitespace is found
; List-of-chars -> String
(define (collect-word chars)
  ; List-of-chars -> List-of-chars
  ; acc holds each valid characters/result
  (define (loop l acc)
    (cond [(empty? l) (reverse acc)]
          [(char-whitespace? (car l)) (reverse acc)]
          [else (loop (cdr l) (cons (car l) acc))]
          )
    )
   (list->string (loop chars '()))
  )
;(collect-word '(#\w #\o #\r #\d #\space)); should return "word"
;(collect-word '()) ; return '()
;(collect-word '(#\space)) ; return '()
;(collect-word '(#\h #\e #\y #\' #\s #\newline)) ; should return "hey's"


; List-of-chars -> List-of-chars
; drops character until the first occurence of whitespace, the whitespace is included
(define (drop-until-whitespace chars)
  (cond [(null? chars) '()]
        [(char-whitespace? (car chars)) chars]
        [else (drop-until-whitespace (cdr chars))]
        )
  )
;(drop-until-whitespace '(#\w #\o #\r #\d #\space #\p #\i #\e #\s))



; given a list of words, count how many times target occurs
; Word -> List-of-words (Sentence)
(define (count-word target words)
  (cond [(null? words) 0]
        [(equal? (car words) target) (+ 1 (count-word target (cdr words)))]
        [else (count-word target (cdr words))]
        )
  )
;(count-word "don't" '("don't" "laugh" "don't" "cry"))


; Given a list of words, returns a unique set
; List-of-words -> List-of-words
(define (filter-unique words)
  ; build the list with acc
  ; on each iteration check if the seen word is within acc
  (define (iter l acc)
    (cond [(null? l) (reverse acc)]
          [(member (car l) acc) (iter (cdr l) acc)] ;skip it
          [else (iter (cdr l) (cons (car l) acc))] ;put it in acc
          )
    )
  (iter words '())    
  )
;(filter-unique '("hello" "it's" "me" "hello" "me"))

;drop-leading-apostrophes : List-of-Char -> List-of-Char
;; removes all apostrophes from the start until it hits a non-apostrophe
(define (drop-leading-apostrophes chars)
  (define (loop l)
    (cond [(null? l) '()]
          [(eq? (car l) #\') (loop (cdr l))]
          [else l]
          )
    )
  (loop chars)
  )

; given a lowercase word, strips out its inner and outer apostrophes
; Word -> Word
(define (strip-outer-apostrophes word)
  (let ((chars (string->list word)))
    (list->string (drop-leading-apostrophes (reverse (drop-leading-apostrophes (reverse chars)))))
    )
  )
;(strip-outer-apostrophes "''large''''")
;(strip-outer-apostrophes "'three")

; String -> WordCount
; given a string, lists all unique occurence of word and its word count
(define (word-count sentence)
  (define valid-chars (normalize-seperators (string->list (string-downcase sentence))))
  ; list-of-chars -> String
  ; for each valid chars, build one sentence each
  (define (iter l acc)
    (cond [(null? l) (reverse acc)]
          [(char-whitespace? (car l)) (iter (cdr l) acc)]
          [else (iter (drop-until-whitespace (cdr l)) (cons (collect-word l) acc ))])
    )

  (define valid-words (map strip-outer-apostrophes (iter valid-chars '()))) 
  (define valid-unique-words (filter-unique valid-words) )

  ; List-of-words -> WordCount
  ; for each unique words, count how many times it appears in the original word list
  ; then pair it with that count
  (define (count l)
    (cond [(null? l) '()]
          [else (cons (cons (car l) (count-word (car l) valid-words) ) (count (cdr l)))]
          )
    )
  
  (count valid-unique-words)
  )
#|
(word-count "this !!!is a,..,, word!! word")
(word-count "WORD! !WORD., word: word:;,., , that's
;");1
(word-count "one of each each each") ;3
(word-count "one fissh two fish red fish blue fish")
(word-count "First: don't laugh. Then: don't cry.")
(word-count "one,two,three")
(word-count "car: carpet as java: javascript!!&@$%^&")
(word-count "Joe can't tell between 'large' and large.")
(word-count ",\n,one,\n ,two \n 'three'")
|#


|#