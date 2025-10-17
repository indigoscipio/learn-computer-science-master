#lang racket

; an Anagram is a String
; its a rearrangement of current letters that form new word/meaning
; - a word repeated itself is not an anagram
; - each letter must appear the same number of time

; a AS (Anagram Set) is a list of anagrams
; '("stone" "tones" "seton")

; string->sorted-list : String -> (Listof Char)
; lowercases and sorts a string
(define (string->sorted-list s)
  (let* ((normalized-s (string-downcase s))
        (chars (string->list normalized-s))
        )
    (sort chars char-ci<?)
    )
  )

; checks if a anagram is a candidate for the target
; String String -> Boolean
(define (is-anagram? candidate target)
  (if (string-ci=? candidate target)
      #f
      (equal? (string->sorted-list candidate)
              (string->sorted-list target))
      )  
  )

; given a target words & set of candidate words
; find the subset of the candidates that are anagrams of the target
; String List-of-string -> List-of-string
(define (anagram target words)
  
  ; build the list using recursion
  (cond [(null? words) '()]
        [(is-anagram? target (car words)) (cons (car words) (anagram target (cdr words)))]
        [else (anagram target (cdr words))]
        )

  ; iteration 2, using filter
  (filter (lambda (word) (is-anagram? word target) ) words)

  ; iteration 3, using fold
  (foldr (lambda (word acc) (if (is-anagram? word target)
                                (cons word acc)
                                acc
                                )) '() words)

  ; iteration 4, using map + filter
  (map car (filter (lambda (pair) (eq? (cdr pair) #t)) (map (lambda (word) (cons word (is-anagram? word target) )) words)))

  ; iteration 5, using for/lsit
  (for/list ([w words]
             #:when (is-anagram? w target))  ; filtering *during* iteration
    w)                                      ; body only runs if condition is true

  ; iteration 5, using build-list
  ; [Nmuber X->Y] -> List-of-string
  (filter (lambda (word) word) (build-list (length words) (lambda (i) (if (is-anagram? (list-ref words i) target)
                                                                          (list-ref words i)
                                                                          #f
                                                                          ) ) ))
  
  )
(anagram "stone" '("baNana" "oNets" "toNes" "sETon"))
(anagram "stone" '("Stone" "tones" "notes" "banana" "Seton"))

