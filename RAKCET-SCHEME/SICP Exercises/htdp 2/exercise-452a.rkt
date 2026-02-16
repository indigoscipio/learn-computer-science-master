;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-452a) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define NEWLINE "\n")

; A File is one of: 
; – '()
; – (cons "\n" File)
; – (cons 1String File)
; interpretation represents the content of a file 
; "\n" is the newline character 

; A Line is a [List-of 1String].

; File -> Line
; retrieves the prefix of afile up to the first occurrence of NEWLINE
(define (first-line afile)
  (cond [(empty? afile) '() ] 
        [(string=? (first afile) NEWLINE) '()]
        [else (cons (first afile) (first-line (rest afile))) ])
  ) 
(check-expect (first-line (list "h" "e" "l" "\n" "l" "o")) (list "h" "e" "l"))
(check-expect (first-line (list)) (list))


; File -> File
; drops the prefix of afile up to the first occurrence of NEWLINE
(define (remove-first-line afile)
  (cond [(empty? afile) '()]
        [(string=? (first afile) NEWLINE) (rest afile) ] ;\n found,remove first until nth index of newline
        [else (remove-first-line (rest afile))]
        )
  )
(check-expect (remove-first-line (list "h" "e" "l" "\n" "l" "o")) (list "l" "o"))
(check-expect (remove-first-line (list)) (list))

; File -> [List-of Line]
; converts a file into a list of lines
(define (file->list-of-lines afile)
  ; if file is '() return '()
  ;file contains \n seperate it
  ;append into front of the list and recurse
  (cond [(empty? afile) '()]
        [else (cons (first-line afile) (file->list-of-lines (remove-first-line afile)) ) ])
  )

(check-expect (file->list-of-lines
               (list "a" "b" "c" "\n"
                     "d" "e" "\n"
                     "f" "g" "h" "\n"))
              (list (list "a" "b" "c")
                    (list "d" "e")
                    (list "f" "g" "h")))

(define ALPHABET (explode "abcdefghijklmnopqrstuvwxyz"))

;List-of-1string (Line) -> List-of [String [List-of-1String]]
;combines 1strings into words and seperate until " " (whitespace) occurence
(define (collect-letters line)
  (cond [(empty? line) '("" '())]
        [(string-whitespace? (first line)) (list "" line) ]  
        [(not (member? (first line) ALPHABET) ) (list "" line) ] 
        [else ( local ( (define result (collect-letters (rest line))) )
                 (list (string-append (first line) (first result))
                       (second result)) ; Append letter to word
                 ) ]  ;; Keep track of remaining characters
        )
  )
(check-expect (collect-letters '("h" "e" "l" "l" "o" " " "w" "o" "r" "l" "d" "!"))
              '("hello" (" " "w" "o" "r" "l" "d" "!")))

; List-of-1string (Line) -> List-of-tokens
; a Token is one of the follwing:
; 1String consists of lowercae eg. ("a")
; String consists of lowercae eg.  ("string")
; All whitespace 1strings are dropped and all other non-letters remain as is
(define (tokenize line)
  (cond [(empty? line) '()]  ; Base case: nothing to process
        [(member? (first line) ALPHABET) 
         (local [(define result (collect-letters line))] 
           (cons (first result) (tokenize (second result))))]
        [(string-whitespace? (first line)) (tokenize (rest line))] 
        [else (cons (first line) (tokenize (rest line)))]))  ; Keep other non-letters as single characters

(string-whitespace? " ")
(check-expect (tokenize '("h" "e" "y" " " "!")) '("hey" "!"))