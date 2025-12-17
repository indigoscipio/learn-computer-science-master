#lang racket

; a Word is a list-of-chars
; '(#\h #\e #\y)

; a sentence is a list-of-words
; '((#\H #\e #\y) (#\y #\o #\u))

(define (is-whitespace? char)
  (or (eq? char #\space)
      (eq? char #\newline))
  )

; given a list of chars, return all chars accumulated until
; the first occurence of whitespace
; List-of-chars -> Pair-of List-of-chars (extracted word) List-of-chars (rest of the sentence, chars AFTER whitespace)
; given a list of chars, return all chars accumulated until
; the first occurence of whitespace
; List-of-chars -> Pair-of List-of-chars (extracted word) List-of-chars (rest of the sentence)
(define (split-at-whitespace chars)
  (define (loop lst result)
    (cond [(null? lst) (cons (reverse result) '())]
          [(is-whitespace? (car lst)) (cons (reverse result) (cdr lst))]
          [else (loop (cdr lst) (cons (car lst) result))]))
  (loop chars '()))

; reverse words in a sentence
; String -> String
(define (reverse-sentence sentence)
  (let* ((sentence-char-reversed (reverse (string->list sentence)) )
         )

    ; Chars Chars -> Chars
    (define (loop lst result)
      (cond [(null? lst) result]
            [else (let* (
                         (split-result (split-at-whitespace lst))
                         (curr-word (car split-result))
                         (rest (cdr split-result))
                         (rev-word (reverse curr-word))
                         )
                    (if (null? rest)
                        (append result rev-word)
                        (loop rest (append result rev-word (list #\space) ) )
                        )
                    )])
      ) 
    ;sentence-char-reversed
    (list->string (loop sentence-char-reversed '()))
    )
  )
(reverse-sentence "My name is Chris")