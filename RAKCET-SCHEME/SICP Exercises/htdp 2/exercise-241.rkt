;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise-241) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; An NEList-of-temperatures is one of: 
; – (cons CTemperature '()) - a single list of CTemperature
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures 


;NEList-of-booleans is one of
; (cons Boolean '()) - a single boolean list
; (cons Boolean NEList-of-booleans): a list with one or more booleans

; a [NEList-of-T] is one of:
;- (cons T '()) - a single list of T
;- (cons T [NEList-of-T])


;instantiation of data structure
; a [NEList-of-temperatures] is one of
;- (cons Temperature '())
; (cons Temperature [NEList-of-temperaters])