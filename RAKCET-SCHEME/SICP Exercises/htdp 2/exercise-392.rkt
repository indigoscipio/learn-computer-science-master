;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-392) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define-struct branch [left right])
 
; A TOS is one of:
; – Symbol
; – (make-branch TOS TOS)
(define sample-tos1 (make-branch 'a (make-branch 'a 'b)))
(define sample-tos2 (make-branch 'x 'y))
(define sample-tos3 (make-branch (make-branch 'f 'g) 'h))
(branch-left sample-tos1)

 ; A Direction is one of:
; – 'left
; – 'right

; A list of Directions is also called a path. 
(define sample-lod1 (list 'right 'left))
(define sample-lod2 (list 'right))
(define sample-lod3 (list 'left))
(define sample-lod4 '())
(define sample-lod5 (list 'left 'right))

;Exercise 390. Design the function tree-pick.
;The function consumes a tree of symbols and a list of directions:
; TOS List-of-directions (Path) -> Symbol Or Error
(define (tree-pick tos lod)
  (cond [(symbol? tos) (cond [(empty? lod) tos] 
                             [else (error "Reached but there's no direction left")])]
        [(empty? lod) tos]
        [else (tree-pick ((if (equal? (first lod) 'left)
                               branch-left
                               branch-right) tos) (rest lod))]
        )
  )
;(error "tree not found")
(check-expect (tree-pick sample-tos1 sample-lod1) 'a)
(check-expect (tree-pick sample-tos2 '()) sample-tos2) 
(check-expect (tree-pick sample-tos3 sample-lod3) (make-branch 'f 'g))
