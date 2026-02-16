;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-175) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define word1 "Sample")
(define word2 "fC g")
(define line1 (cons "line" (cons "one" '())))
(define line2 (cons "2nd" (cons "line  x" '())))
(define line3 (cons "   " (cons "third" (cons "lines__ " '()))))
(define line4 (cons "final     " '()))
(define line5 (cons "$%&" '()))
(define sample-lol (cons line1 (cons line2 '())))
(define sample-lol2 (cons line1 (cons line2 (cons line3 (cons line4 '())))))
(define sample-lol3 (cons line4 (cons line5 '())))


;count-chars is a function that takes a list of 1String
; and counts how many characters are there in a word
; List-of-1string -> Number
(define (count-chars lo1s)
  (cond [(empty? lo1s) 0]
        [else (+ (count-chars (rest lo1s)) 1) ])
  )
;(check-expect (count-chars (explode word1)) 6)

;count-words is a function that takes a list of words
;and counts how many words are there in a line
; List-of-strings -> Number
(define (count-words los)
  (cond [(empty? los) 0]
        [else (+ (count-words (rest los)) 1) ]
        )
  )
;(check-expect (count-words line1) 2)
;(check-expect (count-words line3) 3)

;count-lines is a function that takes a list of lines
;and counts how many lines it has
; List-of-lines -> Number
(define (count-lines lol)
  (cond [(empty? lol) 0]
        [else (+ (count-lines (rest lol) ) 1 ) ])
  )
;(check-expect (count-lines sample-lol) 2)
;(check-expect (count-lines sample-lol2) 4) 
;(check-expect (count-lines sample-lol3) 2)


; wc is a function that does the following
; counts a total number of 1string in a given file
; counts the total number of words in a given file
; counts a total number of lines in a given file
; it consumes a file and produces a value that consists of three numbers char: X words: X lines: X
; File -> String
(define (wc n)
  (string-append "Lines:" (number->string (count-lines (read-lines n)))
                 " "
                 "Words:" (number->string (count-words (read-words n)))
                 " "
                 "Characters:" (number->string (count-chars (read-1strings n)))
                 )
  )
(wc "C:\\Users\\Samuel Oktavianus\\Documents\\test.txt")


;SAMPLE FILE
;a quick brown fox
;the lazy dog
;jumps over an obstacle
;(read-words/line "C:\\Users\\Samuel Oktavianus\\Documents\\test.txt")
(read-words "C:\\Users\\Samuel Oktavianus\\Documents\\test.txt")
;(read-lines "C:\\Users\\Samuel Oktavianus\\Documents\\test.txt");