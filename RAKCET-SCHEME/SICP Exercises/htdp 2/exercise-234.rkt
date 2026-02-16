;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise-234) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
(define one-list
  '("Asia: Heat of the Moment"
    "U2: One"
    "The White Stripes: Seven Nation Army"))

;; List-of String -> List-of (List Number String)
(define (add-ranks los)
  (cond
    [(empty? los) '()]
    [else (cons (list (length los) (first los))
                (add-ranks (rest los)))]))


; List-of-string -> List-of-ranks
;produces a list of rankings of Number - Title from a given los
(define (ranking los)
  (reverse (add-ranks (reverse los))))


; Any -> ... nested list ...
; creates a cell for an HTML table from a number 
(define (make-cell s)
  (if (number? s)
      `(td ,(number->string s))
      `(td ,s)))

;Ranking (Number String) -> HTML Row
(define (make-ranking-row r)
  `(tr ,(make-cell (first r))
       ,(make-cell (second r)))
  )
(make-ranking-row (first (ranking one-list)))


; List-of-rankings -> List of ... nested list ...
(define (make-rows lor)
  (cond
    [(empty? lor) '()]
    [else (cons (make-ranking-row (first lor))
                (make-rows (rest lor)))]))
(make-rows (ranking one-list))


; list-of-rankings ->  HTML table
; creates an HTML table from a list of rankings
(define (make-table lor)
  `(table ((border "1")) ,@(make-rows (ranking lor)))
  )
(make-table one-list)


(define result
  `(html
    (head (title "Ranking"))
    (body
     ,(make-table one-list))))

 
;(show-in-browser result)

