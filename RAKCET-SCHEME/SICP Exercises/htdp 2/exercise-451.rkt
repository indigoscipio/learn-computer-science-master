;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-451) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define-struct table [length array])
; A Table is a structure:
;   (make-table N [N -> Number])


(define table1 (make-table 3 (lambda (i) i)))
; 0 1 2
 
; N -> Number
(define (a2 i)
  (if (= i 0)
      pi
      (error "table2 is not defined for i =!= 0")))
 
(define table2 (make-table 1 a2))

; Table N -> Number
; looks up the ith value in array of t 
(define (table-ref t i)
  ((table-array t) i))
(table-ref table1 4.5)
(table-length table1)




; Table -> Number (Root Index)
;finds smallest index i where table-ref t i == 0
(define (find-linear t)
  (local ( ; Table Number -> Index
          (define (find-linear-helper t i)
            (cond [(>= i (table-length t)) (error "Not found") ]
                  [(=  (table-ref t i) 0) i] ; root is found
                  [else (find-linear-helper t (add1 i)) ])
            )
          )
    (find-linear-helper t 0)
    )  
  )

; Table -> Number (Root Index)
; finds smallest index i where table-ref t i == 0 (by generative recursion)
(define (find-binary t)
  (local (
          (define (find-binary-helper left right)
            (if (>= left right)
                left ; Base case: return the smallest index
                (local ((define mid (quotient (+ left right) 2)) ; Compute midpoint
                        (define f-mid (table-ref t mid))) 
                  (cond [(= f-mid 0) mid]  ; Found root exactly
                        [(> f-mid 0) (find-binary-helper left mid)]  ; Search left half
                        [else (find-binary-helper (add1 mid) right)])))) ; Search right half
          )
    (find-binary-helper 0 (- (table-length t) 1)) ; Initial call with full range
    ))

; Test
(find-binary table1)
