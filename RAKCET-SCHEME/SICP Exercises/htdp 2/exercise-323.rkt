;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-323) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))
(define-struct no-info [])
(define NONE (make-no-info))


; A BT (short for BinaryTree) is one of:
; – NONE
; – (make-node Number Symbol BT BT)
(define-struct node [ssn name left right])

(define sample-BT1 (make-node 15 'd NONE (make-node  24 'i NONE NONE)))
(define sample-BT2 (make-node 15 'd (make-node  87 'h NONE NONE) NONE))

;ontains-bt?, which determines whether a given number occurs in some given BT.
; Number BT -> Boolean
(define (contains-bt? n BT)
  (cond [(no-info? BT) #false]; base case: when BT is none, return #f
        ; check if each number is equal to given n. If so return #t. else recurse and traverse through the whole BT 
        [else (or (= (node-ssn BT) n)
                  (contains-bt? n (node-left BT))
                  (contains-bt? n (node-right BT)))]
        )) 

;(contains-bt? 15 sample-BT1)
;(check-expect (contains-bt? 15 sample-BT1) #t)
;(check-expect (contains-bt? 24 sample-BT1) #t)
;(check-expect (contains-bt? 87 sample-BT2) #t)
;(check-expect (contains-bt? 15 sample-BT2) #t)
;(check-expect (contains-bt? 0 sample-BT2) #f)

;search-bt consumes a number n and BT
; if the tree contains a node whose SSN field is n, the function produces the value of the name field in that node
;else produces #false. Hint: consider using contains-bt to check the entire tree first
;or boolean? to check the result of the natural recursion at each stage.
; Number BT -> MaybeSymbol? (Symbol or #false)
(define (search-bt n BT)
  (cond [(no-info? BT) #f]; base case: if BT is NONE, return #false
        [(= (node-ssn BT) n) (node-name BT)]; check if n contained in current BT, if so return the BT's symbol
        [else (local ( (define left-result (search-bt n (node-left BT)) ) )
                (if (false? left-result)
                    (search-bt n (node-right BT))
                    left-result) )
              ;check the left subtree, if it returns non false, tretun it
              ;otherwise return result from right tree
              ];else recurese
        )) 
(search-bt 24 sample-BT1)
(check-expect (search-bt 24 sample-BT1) 'i)
(check-expect (search-bt 16 sample-BT1) #f)
(check-expect (search-bt 15 sample-BT1) 'd)
(check-expect (search-bt 87 sample-BT2) 'h)
(check-expect (search-bt 15 sample-BT2) 'd)


