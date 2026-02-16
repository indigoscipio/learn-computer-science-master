;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-271) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
;Exercise 268. An inventory record specifies the name of an item, a description,
;the acquisition price, and the recommended sales price.
;Define a function that sorts a list of inventory records by the difference between the two prices. 

(define-struct IR [n d ap rsp])
(define sample-IR1 (make-IR "name1" "description1" 50 100))
(define sample-IR2 (make-IR "name2" "description2" 50 200))
(define sample-IR3 (make-IR "name3" "description3" 50 300))
(define sample-loIR (list sample-IR1 sample-IR2 sample-IR3))
(define sample-los1 (list "Alice" "Bob" "Charlie"))
(define sample-los2 (list "Alice" "Delta" "Eagle" "Charlie"))

;[List-of-IRs] -> [List-of-IRS]
;sorts a list of IRs by the differnece between the two prices
(define (sort-IR l)
  (local (; IR -> Number
          ; IR -> Boolean
          (define (compare-profit IR1 IR2)
            (> (- (IR-rsp IR1) (IR-ap IR1))
               (- (IR-rsp IR2) (IR-ap IR2)))
            )
          )
    (sort l compare-profit)
    )
  )
;(sort-IR sample-loIR)


;Exercise 269. Define eliminate-expensive.
;The function consumes a number ua, and a list of inventory records
;and it produces a list of all those structures whose sales price is below ua.

; Number
(define (eliminate-expensive ua l) 
  (local ( ;IR -> Boolean
          (define (price-threshold IR)
            (< (IR-rsp IR) ua)
            ) )
    (filter price-threshold l) 
    )
  )
;(eliminate-expensive 150 sample-loIR)

;Then use filter to define recall, which consumes the name of an inventory item, called ty,
;and a list of inventory records and which produces a list of inventory records that do not use the name ty.
; String [List-of-IRs] -> [List-of-IRs]
(define (recall ty l)
  (local ( (define (is-name-equal? IR)
             (not (equal? (IR-n IR) ty))
             ) )
    (filter is-name-equal? l)
    )
  )
;(recall "name1" sample-loIR)


;In addition, define selection, which consumes two lists of names
;and selects all those from the second one that are also on the first.
; [List-of-string List-of-string -> List-of-string]
(define (selection lx ly)
  (local (  ; X -> Boolean
          (define (is-member? s)
             (member? s lx)))
    (filter is-member? ly)
    )
  )
;(selection sample-los1 sample-los2)

;Exercise 271. Use ormap to define find-name.
;The function consumes a name and a list of names.
;It determines whether any of the names on the latter are equal to or an extension of the former.
; String [List-of-X] -> Boolean
(define (find-name n l)
  (local (;String -> Boolean checki if given string contains extension
          (define (check-prefix s)
            (or (string=? n s)
                (string-prefix? n s) )
            )

          (define (string-prefix? prefix s)
            (if (<= (string-length prefix) (string-length s))
                (string=? prefix (substring s 0 (string-length prefix)) )
                #false
                )
            )
          )
    (ormap check-prefix l)
    )
  )
;(find-name "rob" (list "cassie" "robert" "rodney"))

;With andmap you can define a function that checks all
;names on a list of names that start with the letter "a".
(define (starts-with? l)
  (local (; String -> Boolean
          (define (check-first-letter s)
             (string=? (string-ith s 0) "a") ))
    (andmap check-first-letter l)
    )
  )
;(starts-with? (list "abby" "aldo" "blternate") )

;Use foldr to define append-from-fold.
;What happens if you replace foldr with foldl?
;(define sample-lon (list 1 2 3 4 5 6 7 8 9))
;(foldr + 0 sample-lon)
;(foldr * 1 sample-lon)
(define CIRCLE (circle 5 "solid" "red"))
;(foldr beside empty-image (list CIRCLE CIRCLE CIRCLE CIRCLE))
;(foldr above empty-image (list CIRCLE CIRCLE CIRCLE CIRCLE))


(define (append-from-fold l)
  (foldr cons (list 4 5 6 7 8) (list 1 2 3))
  )
(append-from-fold 5)


(define sample-loi (list 3 4))
(define (map-from-fold op l)
  (local ((define (helper x acc)
            (cons (op x) acc)))
    (foldr helper '() l)))
(map-from-fold * sample-loi)
;Use fold to define map
;(define (process-teim ))

