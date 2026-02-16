;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-388c) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
; employee is a struct
; make-employee [String Number Number]
; interpretation employee's Name, Social Security Number (let's assume 4 digit for now) and Pay Rate
(define-struct employee [name ssn wage])
(define sample-employee1 (make-employee "Marc" 1234 35))
(define sample-employee2 (make-employee "Tio" 5478 25))
(define sample-loe1 (list sample-employee1 sample-employee2))
sample-loe1

; work record is a struct
; make-wr [String Number]
; interpretation Emplyee Name, hours worked in a week
(define-struct wr [name hours])
(define sample-wr1 (make-wr (employee-name sample-employee1) 8))
(define sample-wr2 (make-wr (employee-name sample-employee2) 16))
(define sample-lowr1 (list sample-wr1 sample-wr2) )
sample-lowr1

; computes weekly wage of an employee
(define (compute-weekly-wage pay-rate hours-worked)
  (* pay-rate hours-worked)
  )

; find-employee-pay-rate : String [List-of Employee] -> Number
; Returns the pay rate of an employee with the given name
(define (find-employee-pay-rate s loe)
  (cond [(string=? s (employee-name (first loe))) (employee-wage (first loe)) ]
        [else (find-employee-pay-rate s (rest loe)) ])
  ) 


; [List-of Employee] [List-of WR] -> [List-of [List-of String Number]] 
(define (wages*.v2 loe lowr)
  (cond [(empty? lowr) '()]
        [else (cons (list (wr-name(first lowr))
                          (compute-weekly-wage  (find-employee-pay-rate (wr-name (first lowr))  loe  )
                                                (wr-hours (first lowr))
                                                )) 
                    (wages*.v2 loe (rest lowr)) 
                    )]
        )
  )
(check-expect (wages*.v2 sample-loe1 sample-lowr1) (list (list "Marc" 280) (list "Tio" 400)))
