;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-173) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

;design a program that removes all articles from a text file
; the program consumes the name n of a file
; reads the file, removes the article
; and writes the result to a file whose name is the result of concatenating "no-articles-" with n
; an article is one of the following words:
; "a", "an", and "the"

;contains article checks wheter a given string is is "a", "an", or "the"
;returns true if so and false if its not
; String -> Boolean
(define (contains-article? s)
  (if (or (equal? s "a") (equal? s "an") (equal? s "the"))
      #true
      #false
      )
  )


;remove-all-articles/line is a function that takes a list of string
; and removes any articles if theres any occurence within each los
; List-of-string -> String
; List of string is one of the following
; '()
; String List-of-string
(define line1 (cons "hello" (cons "an" '())))
(define line2 (cons "a" (cons "line" '())))
(define line3 (cons "the" (cons "third" (cons "an" '()))))
(define line4 (cons "a" '()))
(define empty-line '())
(define sample-lol (cons line1 (cons line2 '())))
(define sample-lol2 (cons line1 (cons line2 (cons line3 (cons line4 '())))))

(define (remove-all-articles/line los)
  (cond [(empty? los) ""]
        ;if it contains article, filter/skip that word
        [(empty? (rest los)) (string-append (first los) (remove-all-articles/line (rest los))) ]
        [(contains-article? (first los))  (remove-all-articles/line (rest los)) ]
        ;else append that word into string
        [else (string-append (first los) " " (remove-all-articles/line (rest los)) )  ])

  ;(cons (first los) (remove-all-articles/line (rest los)))
  )
;(check-expect (remove-all-articles/line line1) "hello")
;(remove-all-articles/line line1)
;(remove-all-articles/line line2)
;(remove-all-articles/line line3)
;(remove-all-articles/line line4)


;function collapse converts a list of lines into a string
;the strings should be seperated by blank spaces (" ")
;lines should be seperated by a new line ("\n")
; a list of lines is the following:
; '()
; Line List-of-lines
; List-of-lines -> String
(define (collapse lol)
  ; if it's an empty lol, return empty list '()
  (cond [(empty? lol) ""]
        ;for each line, combine the strings into a string
        ;then append "\n at the end of each string"
        [(empty? (rest lol)) (remove-all-articles/line (first lol))] ; Last line, no newline
        [else (string-append (remove-all-articles/line (first lol)) "\n" (collapse (rest lol)) ) ])
  )
(collapse sample-lol)
(collapse sample-lol2)


;main function
; File -> File
(define (remove-all-articles-main n)

  ;read the file
  (write-file "C:\\Users\\Samuel Oktavianus\\Documents\\no-articles-test.txt"
            (collapse (read-words/line n)))
  ;(collapse (read-words/line n))
  ;remove the article
  ;write the result into a file with "no-articles-n"
  
  )

(remove-all-articles-main "C:\\Users\\Samuel Oktavianus\\Documents\\test.txt")