;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-170) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

(define-struct phone [area switch four])
; A Phone is a structure: 
;   (make-phone Three Three Four)
; A Three is a Number between 100 and 999. 
; A Four is a Number between 1000 and 9999.
(define sample-phone1 (make-phone 713 888 1518))
(define sample-phone2 (make-phone 555 518 713))
(define sample-phone3 (make-phone 713 123 1234))

(define sample-lop (cons sample-phone1 (cons sample-phone2 (cons sample-phone3 '()))))


;convert phone area is a function that cheks wheter the given input is 713
;if so, replace that number with 281
;else return the input number
;Number -> Number
(define (convert-phone-area pa)
  (if (equal? pa 713)
      281
      pa)
  )

; replace is a function that consumes and produces a list of phones
; it replaces all occurence of area code 713 with 281
; List-of-phones -> List-of-phones
; List if phone is the following
; '()
; Phone List-of-phones
(define (replace lop)
  (cond [(empty? lop) '() ]
        [else (cons (make-phone (convert-phone-area (phone-area (first lop)))
                                (phone-switch (first lop))
                                (phone-four (first lop)) ) (replace (rest lop)))]

)
       
  )
(replace sample-lop)


(check-expect (replace sample-lop) (cons (make-phone 281 888 1518) (cons (make-phone 555 518 713) (cons (make-phone 281 123 1234) '()))))