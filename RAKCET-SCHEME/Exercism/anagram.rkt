#lang racket

; an Anagram is a String
; its a rearrangement of current letters that form new word/meaning
; - a word repeated itself is not an anagram
; - each letter must appear the same number of time

; a AS (Anagram Set) is a list of anagrams
; '("stone" "tones" "seton")

; checks if a anagram is a candidate for the target
; String String -> Boolean
(define (is-anagram? candidate target)
  (let* ((normalized-candidate (string->list (string-downcase candidate)))
         (normalized-target (string->list (string-downcase target)))
         )
    ; sort each char and compare
    (if (string-ci=? candidate target)
        #f
        (equal? (sort normalized-candidate char-ci<?)
                (sort normalized-target char-ci<?))
        )
    
    )  
  )
(is-anagram? "sTone" "tonEs")

; given a target words & set of candidate words
; find the subset of the candidates that are anagrams of the target
; String List-of-string -> List-of-string
(define (anagram target words)
  ; build the list using recursion
  (cond [(null? words) '()]
        [(is-anagram? target (car words)) (cons (car words) (anagram target (cdr words)))]
        [else (anagram target (cdr words))]
        )
  )