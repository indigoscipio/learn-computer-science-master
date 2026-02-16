;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise-262) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))

; a Row is a list of Numbers
; '()
; Number List-of-number

; A Matrix is a list of rows
;where the items of each row has the same index as the column (ri = ji)
; '()
; Row List-of-rows
(define sample-row1 (list 0 1 0))
(define sample-row2 (list 0 1 0))
(define sample-row3 (list 1 1 0))
(define sample-matrix (list sample-row1 sample-row2 sample-row3))


(define (identityM n)
  (local (
          ;Number Number -> List-of-numbers
          ; r = row index (vertical)
          ; c = col index (horizontal/length)
          ; n = total length of the matrix (n x n)
          (define (build-row col-index row-index) 
             (cond [(> col-index n) '()]
                   [else (cons (if (= col-index row-index) 1 0)
                               (build-row (add1 col-index) row-index))])
            )
          ; Number Number -> List-of-rows (Matrix)
          ;creates a matrix table with n x n cells
          (define (build-rows row-index)
            (cond [(> row-index n) '()]
                  [else (cons (build-row 1 row-index ) (build-rows (add1 row-index)) )])
            ) 
          )
    (build-rows 1)
    ) 
  )
(identityM 6)

 



;(identityM 1)
;should return (list (list 1))
;(identityM 2)
;should return (list (list 1 0) (list 0 1))