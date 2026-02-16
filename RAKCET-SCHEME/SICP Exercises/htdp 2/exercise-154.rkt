;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise-154) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct layer [color doll])

; An RD (short for Russian doll) is one of: 
; – String 
; – (make-layer String RD)
(define sample-rd (make-layer "yellow" (make-layer "green" "red"))) 
(define single-rd "green")

; RD -> Number
; how many dolls are part of an-rd 
(define (depth an-rd)
  (cond
    [(string? an-rd) 1]
    [else (+ (depth (layer-doll an-rd)) 1) ]
    )
  )

;function colors consumes a russian doll
;and produces a string of all colors seperated by a comma and psace
; eg "yellow, green, red"
(define (colors an-rd)
  ;check if its' the innermost layer, if so extract that color
  (cond [(string? an-rd) an-rd ]
        ;else recurse and extract each of the dolls' color = List of layer-color
        [else (string-append (layer-color an-rd) ", " (colors (layer-doll an-rd ))  ) ]
         )
  )
(colors sample-rd)


;design the function inner which consumes an RD
; and produces the (color of the) innermost doll
; RD -> String
(define (inner an-rd)
  (cond [(string? an-rd) an-rd]
        [else (inner (layer-doll an-rd) ) ])
  )