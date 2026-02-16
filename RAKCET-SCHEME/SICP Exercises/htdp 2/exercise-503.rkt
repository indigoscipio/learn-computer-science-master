;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-503) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))


; A Row is a list of numbers
; (list 1 2 3 4)
; Matrix (List-of-rows) -> Boolean
(define (rows-start-with-zero? M)
  (cond [(empty? M) #t]
        [(not (zero? (first (first M)))) #f ]
        [else (rows-start-with-zero? (rest M)) ])
  )
(rows-start-with-zero? (list (list 1 2 3) (list 0 2 5)))

; Matrix -> Matrix 
; finds a row that doesn't start with 0 and
; uses it as the first one
; generative moves the first row to last place 
; no termination if all rows start with 0
(define (my-rotate M)
  (cond
    [(rows-start-with-zero? M) (error "Error: all rows starts with zero")]
    [(not (= (first (first M)) 0)) M]
    [else
     (my-rotate (append (rest M) (list (first M))))]
    ))


(define (my-rotate.v2 M)
  (local (; Matrix Matrix -> Matrix 
          ; accumulator acc stores list of rows (matrix) that starts with zero
          (define (my-rotate.v2/a M acc)
            (cond [(empty? M) (error "no valid row found")]
                  [(not (equal? (first (first M)) 0)) (append M acc)]
                  [else (my-rotate.v2/a (rest M) (cons (first M) acc) )]
                  )
            )
          )
    (my-rotate.v2/a M '()) 
    )
  )


(my-rotate '((0 4 5) (1 2 3) (0 3 3)))
(check-expect (my-rotate '((0 4 5) (1 2 3)))
              '((1 2 3) (0 4 5)))

