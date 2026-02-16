;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-411) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define-struct db [schema content])
; A DB is a structure: (make-db Schema Content)
 
; A Schema is a [List-of Spec]

(define-struct spec [label predicate])
; Spec is a structure: (make-spec Label Predicate)
; A Label is a String
; A Predicate is a [Any -> Boolean]
 
; A (piece of) Content is a [List-of Row]
; A Row is a [List-of Cell]
; A Cell is Any
; constraint cells do not contain functions 
 
; integrity constraint In (make-db sch con), 
; for every row in con,
; (I1) its length is the same as sch's, and
; (I2) its ith Cell satisfies the ith Predicate in sch

(define school-schema (list (make-spec "Name" string?)
                            (make-spec "Age" number?)
                            (make-spec "Present" boolean?)
                            ))
(define school-content (list (list "Alice" 35 #t)
                             (list "Bob" 25 #f)
                             (list "Carol" 30 #t)
                             (list "Dave" 32 #f)) )
(define school-db (make-db school-schema school-content))


(define school-schema2 (list (make-spec "Present" boolean?)
                             (make-spec "Description" string?)
                             ))
(define school-content2 (list (list #t "presence")
                              (list #t "here")
                              (list #f "absence")
                              (list #f "there")) )
(define school-db2 (make-db school-schema2 school-content2))


(define presence-schema (list (make-spec "Present" boolean?)
                              (make-spec "Description" string?)
                              ))
(define presence-content (list (list #t "presence")
                               (list #f "absence")))
(define presence-db (make-db presence-schema
                             presence-content))


; DB DB -> DB
; Joins db-1 and db-2 by replacing the last cell in each row of db-1 with the translation from db-2.
(define (join db1 db2)
  (local ((define content1 (db-content db1))
          (define content2 (db-content db2))
          (define schema1 (db-schema db1))
          (define schema2 (db-schema db2))

          ; Helper function to find matching rows in db-2
          (define find-matching-rows cell)
   
          
          ; Helper function to replace the last cell in a row

          ; Combine all rows



          )
    ;Main function goes here
    (map third content1)
    )
  )
(join school-db school-db2)
