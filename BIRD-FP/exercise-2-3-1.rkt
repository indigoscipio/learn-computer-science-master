#lang racket

;2.3.1
; define function nextlet which takes letter of alphabet
; and returns the letter immediately after it
; assume letter A follows Z

(define (nextlet char)
  (cond [(eq? char #\z) #\a]
        [(eq? char #\Z) #\A]
        [else (integer->char (+ (char->integer char)  1))])
  )
(nextlet #\a) ;return b
(nextlet #\B) ;return c

;2.3.2
; define func digitval which converts digit char
; to its corresponding numerical value
(define (digitval digit)
  (- (char->integer digit) (char->integer #\0))
  )
(digitval #\8)

;2.3.3
; put the following strings in ascending order:
; McMillan, Macmillan, and MacMillan


; answer:
; since upercase is treater as having lower value
; MacMillan > Macmillan > McMillan

;2.3.4
; what are the valueus of the following expressions?
; show (show 42)
; show 42 (concat) show 42
; show "newline"

; ""42""
; "4242"
; #\n


;2.3.5
; define total versions of the justificationfunctions of section 2.3.2
; so (cjustify n x) returns x if its length is longer than n

; Number String -> String
; given a number and target string, returns a string with left padded n spaces
(define (ljustify n str)
  ; case 1: target str is longer than desired length - just return the string
  ; case 2: it fits, perform padding logic
  (cond [(> (string-length str) n) str]
        [else (string-append str (make-string (- n (string-length str) ) #\space)) ])
)
(ljustify 11 "hepl")

; Number String -> String
; given a number and target string, returns a string with left padded n spaces
(define (rjustify n str)
  ; case 1: target str is longer than desired length - just return the string
  ; case 2: it fits, perform padding logic
  (cond [(> (string-length str) n) str]
        [else (string-append (make-string (- n (string-length str) ) #\space) str  ) ])
)

(define (cjustify n str)
  (cond [(> (string-length str) n) str]
        [else (string-append (make-string (/ (- n (string-length str)) 2) #\space)
                             str
                             (make-string (- (- n (string-length str)) (/ (- n (string-length str)) 2) ) #\space)
                             ) ])
  )
(cjustify 11 "hey")