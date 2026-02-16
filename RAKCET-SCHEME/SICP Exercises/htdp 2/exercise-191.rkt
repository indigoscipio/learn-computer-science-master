;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise-191) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))


(define sample-lo1s (list "a" "b" "c"))
(define single-lo1s (list "a"))
(define empty-lo1s (list))


;prefixes consumes a list of 1Strings and produces a list of all prefixes
; A list p is a prefix of l if p and l are the same up through all items in p
; (list "a" "b" "c") -> (list '() (list  "a") (list "a" "b") (list "a" "b" "c"))
; List-of-1string -> List-of-prefixes
(define (prefixes lo1s)
  ; Start with an empty accumulator and the input list
  (acc-prefix '() lo1s))

;acc-prefix accumulates a list of prefixes
; a Prefix is one of
; ()'
; 1String List-of-1string

; a Lsit of prefixes is one of
; '()
; Prefix List-of-Prefixes

(define (acc-prefix acc lo1s)
  (cond
    [(empty? lo1s) (list (reverse acc))]
    [else
     (cons (reverse acc) 
           (acc-prefix (cons (first lo1s) acc)
                       (rest lo1s)))]))



;suffixes consumes a list of 1Strings
;and produces all suffixes
; a list of lus is a suffix of lo1s are the same from the end, up through all items in lus
; lo1s (list "b" "c" "d") is a suffix of itself and (list "a" "b" "c" "d")
; List-of-1string -> list-of-suffixes
(define (suffixes lo1s)
  (acc-suffix '() lo1s)
  )


;acc-suffix accumulates a list of suffixes
; a Suffix is one of
; ()'
; 1String List-of-1string

; a List of suffixes is one of
; '()
; Suffix List-of-Suffixes

;List-of-1String list-of-1String -> List-of-suffie 
(define (acc-suffix acc lo1s)
  (cond [(empty? lo1s) (list lo1s) ]
        [else (cons lo1s (acc-suffix (first lo1s) (rest lo1s) ) ) ]
        )
  )

(suffixes empty-lo1s)
(suffixes sample-lo1s) 