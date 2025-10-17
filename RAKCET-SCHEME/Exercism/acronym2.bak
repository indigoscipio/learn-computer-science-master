#lang racket

(define alphabet "abcdefghijklmnopqrstuvwxyz")

; String -> String
; constructs a string of acronym from a given s
; hyphens are word seperators (like whitespace)
; all other punctuations can be removed from the input
(define (acronym test)
  (let ((string-chars (string->list (string-downcase test)))
        (alphabet-chars (string->list alphabet)))
    
    ; filter/clean the list    
    ; List-of-char -> List-of-char
    (define cleaned-list (filter (lambda (char) (or (member char alphabet-chars)
                                                    (eq? char #\-)
                                                    (eq? char #\space)                               
                                                    ) ) string-chars))
    

    ; normalize the seperators
    ; List-of-char -> List-of-char
    (define final-list (map (lambda (x) (if (eq? x #\-) #\space x) ) cleaned-list))
    

    ; get first letter of each word
    ; accumulator acc gathers the first char after space
    ; helper that tracks the previous character, and whenever the current char is a letter
    ; and the previous one is a space (or it's the first char), you collect it.
    ; List-of-chars Char List-of-chars -> List-of-chars
    (define (iter l prev acc)
      (cond [(null? l) (reverse acc)]
            [(and (eq? prev #\space)
                  (char-alphabetic? (car l))) (iter (cdr l) (car l) (cons (car l) acc))] ; add it to the acc and set previous to current char
            [else (iter (cdr l) (car l) acc)] ;else skip it
            )
      )   

    ; combine it
    (string-upcase (list->string (iter final-list #\space '())))
    
    )  
  )
(acronym " Portable Network Graphics")
(acronym "As Soon As Possible")
(acronym "Thank George It's Friday!")
(acronym "The-Road _Not_ Taken")
(acronym "Liquid-crystal Display")
(acronym "Something - I made up from thin air")