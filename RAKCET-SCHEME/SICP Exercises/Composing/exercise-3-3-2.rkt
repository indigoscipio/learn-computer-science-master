;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-3-3-2) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))


(define (inches-to-cm inches)
  (* inches 2.54)
  )

(define (feet-to-inches feet)
  (* feet 12)
  )

(define (yards-to-feet yards)
  (* yards 3)
  )

(define (rods-to-yards rods)
  (* rods 5.5)
  )

(define (furlongs-to-rods furlongs)
  (* furlongs 40)
  )

(define (miles-to-furlongs miles)
  (* miles 8)
  )

(define (feet-to-cm feet)
  (inches-to-cm (feet-to-inches feet))
  )

(define (yards-to-cm yards)
   (feet-to-cm (yards-to-feet yards)) 
  )

(define (rods-to-inches rods)
  (yards-to-cm (rods-to-yards rods)) 
  )

(rods-to-inches 1)