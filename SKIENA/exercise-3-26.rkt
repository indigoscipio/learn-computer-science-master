#lang racket

; a Word is a string
; "Hello", "Word"

; a sentence is a string;
; "Hello, world"

; a word-char is a list-of-char
; example: '(#\h #\e #\l #\l #\o)

; a sentence-char is a list-of-word-char
; example: '((#\h #\e #\y) (#\y #\o #\u))

; dont reverse the letters in each word

; String -> String
; given a word, reverses each letter
; seperate string into char -> cons 1 by 1 - On time complexity
(define (reverse-word word)
  (let ((word-char (string->list word)))
    (define (loop list acc)
      (cond [(null? list)acc]
            [else (loop (cdr list) (cons (car list) acc))])
      )
    (loop word-char '())
    )
  )
(reverse-word "niggaz    11")

; reverse words in a sentence
; String -> String
(define (reverse-sentence sentence)
  0
  )
(reverse-sentence "My name is Chris")