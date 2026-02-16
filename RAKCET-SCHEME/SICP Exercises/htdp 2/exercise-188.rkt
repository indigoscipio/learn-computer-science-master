;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise-188) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct email [from date message])
; An Email Message is a structure: 
;   (make-email String Number String)
; interpretation (make-email f d m) represents text m 
; sent by f, d seconds after the beginning of time 

(define sample-email1 (make-email "Zeta" 2009 "Message from the past"))
(define sample-email2 (make-email "Cecilia" 2025 "Message From the present"))
(define sample-email3 (make-email "Amber" 2099 "Message from the future"))
(define sample-loem (list sample-email1 sample-email2 sample-email3) )

;function sort-email-by-date takes a list of email
;and returns a sorted list of email by date (Newest - Oldest)
; List-of-emails -> List-of-emails
(define (sort-email-by-date loem)
  (cond [(empty? loem) '()]
         [else (insert (first loem) (sort-email-by-date (rest loem) )) ])
  )


; Email List-of-emails -> List-of-emails
; function insert inserts email into the SORTED list of emails 
(define (insert email loem)
  (cond [(empty? loem) (cons email '()) ]
        [else (if (>= (email-date email) (email-date (first loem)) )
                  (cons email loem)
                  (cons (first loem) (insert email (rest loem)) )
                  ) ]
        )
  )
;(check-expect (sort-email-by-date sample-loem) (list sample-email3 sample-email2 sample-email1) )
;(sort-email-by-date sample-loem)



(define (insert-name email loem)
    (cond [(empty? loem) (cons email '()) ]
        [else (if (string<? (email-from email) (email-from (first loem)) )
                  (cons email loem)
                  (cons (first loem) (insert-name email (rest loem)) )
                  ) ]
        )
  )


; sort-email-by-name is a function that takes a list of emails
; and returns a sorted list of emails by name (A - Z)
; List-of-emails -> List-of-emails
(define (sort-email-by-name loem)
 (cond [(empty? loem) '()]
       [else (insert-name (first loem) (sort-email-by-name (rest loem))) ]
       )
  ) 
(sort-email-by-name sample-loem)
(check-expect (sort-email-by-name sample-loem) (list sample-email3 sample-email2 sample-email1))
