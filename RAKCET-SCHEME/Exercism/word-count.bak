#lang racket

; if message = ends with ? -> "Sure"
; if message = ALLCAPS -> "chill!"
; if message = ends with ! -> "calm down!"
; if message = nothing (empty whitespaces) -> "fine, be that way"
; else "whatever"

; determines what bob will reply to someone when they say something to him
; or ask him a question
; String -> String
(define (response-for message)
  (cond [(and (ends-with-char? message #\?) (yelling? message)) "Calm down, I know what I'm doing!"]
        [(yelling? message) "Whoa, chill out!"]
        [(ends-with-char? message #\?) "Sure."]
        [(silence? message) "Fine. Be that way!"]
        [else "Whatever."]
        )
  )

; String -> Boolean
; checks if a given message/string is yelling.
; a yell is when only at least one character is uppercase or all uppercase
(define (yelling? s)
  (let ((chars (string->list s)))

    
    ; String Boolean -> Boolean
    (define (iter l has-letter? has-lowercase?)
      (cond [(null? l) (and has-letter? (not has-lowercase?)) ]
            [(char-alphabetic? (car l))  (if (char-lower-case? (car l))
                                             (iter (cdr l) #t #t)
                                             (iter (cdr l) #t has-lowercase?)
                                             )] ; check if its' a letter, and then check if it's uppercase
            [else (iter (cdr l) has-letter? has-lowercase?)] ; else recurse
            ) 
      )
    (iter chars #f #f)


    
    )  
  )

string-trim

; Character -> Boolean
; checks if a character contains whitespace
(define (char-whitespace? char)
  (or (eq? char #\space)
      (eq? char #\newline)
      (eq? char #\tab)
      (eq? char #\return)
      )
  )

; Checks if a string ends with a target character
; ignoring the remaining whitespace
; String Character -> Boolean
(define (ends-with-char? s target)
  (let ((chars (string->list s)))
    ; iteration 1, using structural recursion
    (define (loop l)
      (cond [(null? l) #f]
            [(char-whitespace? (car l)) (loop (cdr l))]
            [(eq? (car l) target) #t]
            [else #f]
            )
      )
    (loop (reverse chars))


    ; iteration 2, fold
    ; acc holds the last character flag seen so far
    (eq? (foldl (lambda (char acc) (if (char-whitespace? char)
                                  acc ; skip it
                                  char
                                  ) ) #f chars) target)
    )  
  )


; Check if a message is Silent
; a silent message contain the following: #\space, #\newline, and #\tab
; String -> Boolean
(define (silence? s)
  (let ((chars (string->list s)))    
    ; String Boolean -> Boolean
    (define (loop l)
      (cond [(null? l) #t]
            [(char-whitespace? (car l)) (loop (cdr l))]
            [else #f]
            )
      )    
    (loop chars)
    
    ; using andmap
    (andmap (lambda (char) (char-whitespace? char)) chars)    
    )
  )
(response-for "Does this cryogenic chamber make me look fat?")