#lang racket

(define alphabet "abcdefghijklmnopqrstuvwxyz")

; String -> String
; constructs a string of acronym from a given s
; hyphens are word seperators (like whitespace)
; all other punctuations can be removed from the input
(define (acronym test)
  (let ((string-chars (string->list (string-downcase test)))
        (alphabet-chars (string->list alphabet)))

    ; normalize seperators
    ;clean-char-list : String -> List-of-Char
    (define (clean-char-list s)
      (filter (lambda (char) (or (member char alphabet-chars)
                                 (eq? char #\-)
                                 (eq? char #\space)                               
                                 ) ) string-chars)
      )

    ;normalize-separators : List-of-Char -> List-of-Char
    (define (normalize-separators s)
      (map (lambda (x) (if (eq? x #\-) #\space x) ) s)
      )

    ;extract-acronym-letters : List-of-Char -> List-of-Char
    (define (iter l prev acc)
      (cond [(null? l) (reverse acc)]
            [(and (eq? prev #\space)
                  (char-alphabetic? (car l))) (iter (cdr l) (car l) (cons (car l) acc))] ; add it to the acc and set previous to current char
            [else (iter (cdr l) (car l) acc)] ;else skip it
            )
      )

    (define (extract-acronym-letters s) (iter s #\space '()))

    ;build-acronym : List-of-Char -> String
    (define (build-acronym s)
      (string-upcase (list->string s))
      )

    (build-acronym (extract-acronym-letters (normalize-separators (clean-char-list string-chars))))    
    )  
  )
(acronym "Portable Network Graphics")
(acronym "As Soon As Possible")
(acronym "Thank George It's Friday!")
(acronym "The-Road _Not_ Taken")
(acronym "Liquid-crystal Display")
(acronym "Something - I made up from thin air")