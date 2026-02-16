;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-103) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Spider: (make-spider Number Number)
(define-struct spider [remaining-legs space-required] )

; Elephant: (make-elephant Number)
(define-struct elephant [space-required])


; BoaConstrictor: (make-boa-constrictor Number Number)
; Interpretation: 
; - length is the length of the boa in meters.
; - girth is the girth of the boa in meters.
(define-struct boa-constrictor [length girth])



; Armadillo: (make-armadillos Number Boolean)
; Interpretation: 
; - space-required is the space needed for transport.
; - curled? indicates if the armadillo is curled (True/False), which might affect space needed.
(define-struct armadillos [space-required curled?])



; Animal CageVolume -> Boolean
; interpretation fits? is a function that determines wheter the cage's volume is large animal for a given animal
; example: (fits? spider cage-volume) outputs true or false depending on their size
(define (fits? animal cage)
  
  )

