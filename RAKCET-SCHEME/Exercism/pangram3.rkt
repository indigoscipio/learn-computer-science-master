#lang racket

(define alphabets
  "abcdefghijklmnopqrstuvwxyz"
  )

; removes a given character c from a list of letters
; Character -> List-of-Character
(define (remove-char c l)
  (filter (lambda (char) (not (eq? char c)) ) l)
  )

; a Phrase is  a string
; String -> Boolean
(define (pangram? phrase)
  (let ((phrase-seq (string->list (string-downcase phrase)))
        (alphabets-seq (string->list alphabets))
        )
    ; accumulator starts with all 26 chars'(#\a #\b #\c ...)
    ; (remove letter from acc if found)
    (define (iter l acc)
      (cond [(null? l) acc]
            [(member (car l) acc) (iter (cdr l) (remove-char (car l) acc) )]
            [else (iter (cdr l) acc)]
            )
      )
    (null? (iter phrase-seq alphabets-seq))

    (null? (foldr (lambda (char acc) (if (member char alphabets-seq)
                                         (remove-char char acc)
                                         acc
                                         )) alphabets-seq phrase-seq))
    
    )
  )
(pangram? "five boxing wizards jump quickly at it")
(pangram? "the quick brown fox jumps over the lazy dog")
