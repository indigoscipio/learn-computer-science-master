;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise-194) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

; a plain background image 
(define MT (empty-scene 50 50))
(define LINE-COLOR "red")
(define tri-posn1 (make-posn 20 10))
(define tri-posn2 (make-posn 20 20))
(define tri-posn3 (make-posn 30 20))
(define sample-tri1 (list tri-posn1 tri-posn2 tri-posn3) )
(define sample-tri2 (list tri-posn1 tri-posn2))
(define sample-tri3 (list tri-posn1))

(define rec-posn1 (make-posn 20 10))
(define rec-posn2 (make-posn 20 20))
(define rec-posn3 (make-posn 30 20))
(define rec-posn4 (make-posn 30 10))
(define sample-rec (list rec-posn1 rec-posn2 rec-posn3 rec-posn4) )

;render-line draws a red line from posn p to posn q into img
; Image Posn Posn -> Image
(define (render-line img p q)
  (scene+line img (posn-x p) (posn-y p) (posn-x q) (posn-y q) LINE-COLOR)
  )
(render-line MT tri-posn1 tri-posn2)
; An NELoP is one of: 
; – (cons Posn '())
; – (cons Posn NELoP)

; Image NELoP -> Image 
; connects the dots in p by rendering lines in img
(define (connect-dots img p)
  (cond [(empty? (rest p)) img ]
        [else (render-line
       (connect-dots img (rest p))
       (first p)
       (second p)) ]
        )
  ) 


; NELoP -> Posn
; extracts the last item from p
(define (last p)
  (cond
    [(empty? (rest (rest (rest p)))) (third p)]
    [else (last (rest p))]))


; Image Polygon -> Image 
; adds an image of p to img
(define (render-poly img p)
  (render-line (connect-dots img p)
               (first p)
               (last p)))
