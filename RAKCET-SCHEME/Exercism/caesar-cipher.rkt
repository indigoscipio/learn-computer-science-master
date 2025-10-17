#lang racket

(define (rotate phrase dx)
  (define loc (string->list phrase))
  
  ; an Index corresponds to alphabetic number from 0 - 25 for lowercase
  (define (rotate-char c dx) (cond [(char-upper-case? c) (integer->char (+ (modulo (+ (- (char->integer c) (char->integer #\A)) dx) 26)
                                                                           (char->integer #\A)) ) ]
                                   [(char-lower-case? c) (integer->char (+ (modulo (+ (- (char->integer c) (char->integer #\a)) dx) 26)
                                                                           (char->integer #\a)) ) ]
                                   [else c])
    ) 
  
  ; List-of-number List-of-Characters -> List-of-characters
  ; takes a list of characters and rotates it based on a given dx
  (list->string (map (lambda (char) (rotate-char char dx)) loc))
  
  )
(rotate "omg" 5) ;should return trl
(rotate "c" 0);should return c
(rotate "cool" 26);should return cool
;(rotate "The quick brown fox jumps over the lazy dog." 13)
