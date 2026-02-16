#lang sicp

#|
; a Table is a list of TableHeader TableItems
; A Key-Value Pair is a (cons any any)
; a TableHeader is a Symbol
; TableItems is a [List-of-Key-Values]
(define (make-table)
  (list '*table* (cons 'a 1) (cons 'b 2) (cons 'c 3) )
  )

(define my-table (make-table))
my-table

; Gets the value of a Key-Value pair in a table
; Any Table -> MaybeAny
(define (lookup key table)
  (let ((record (assoc key (cdr table)) ))
    (cond [record (cdr record)]
          [else #f])
    ))

; Any Any Table -> 'ok
; Inserts new item into a table
(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (cond [record (set-cdr! record value)] ;check if record already exists with given key, if so replace the old value into the new value
          [else (set-cdr! table (cons (cons key value) (cdr table))) 'ok] ;else put new kv pair in front of the table 
          ) 
    )
  )

(define my-table (make-table))
;my-table

; creates a 2d table
(define (make-table)
  (list '*table*
        (list 'math
              (cons '+ 43) (cons '- 45) (cons '* 42))
        (list 'letters
              (cons 'a 97) (cons 'b 98)))
  )



; a lookup procedure for two dimensional table
(define (lookup key1 key2 table)
  (let ((subtable-record (assoc key1 (cdr table))))
    (cond [subtable-record (let ((record (assoc key2 (cdr subtable-record))))
                             (cond [record (cdr record)]
                                   [else #f])
                             )] ;if the subtable exists, get record based on the 2nd key
          [else #f] ;otherwise return false
          )
    )
  )
;(lookup 'math '+ my-table) ;should return 43


; Any Any Any Table -> #void
(define (insert key1 key2 value table)
  ; check if theres a subtable stored under the first key
  ; if not we build a new subtable containing the single record (key2, value)
  ; and insert it into the table under the first key

  ;if a subtable exists for the first key, we insert the new record into this subtable
  ; using the insertino method for the 1d table above
  (let ((subtable-record (assoc key1 (cdr table))))
    (cond [subtable-record (let ((record (assoc key2 (cdr subtable-record))))
                             (cond [record (set-cdr! record value) 'subtable-updated]
                                   [else (set-cdr! subtable-record (cons (cons key2 value) (cdr subtable-record)))] ;insert the new record into the subtable
                                   )
                             ) ]
          [else (set-cdr! table (cons (list key1 (cons key2 value)) (cdr table)))
                'subtable-created ] ;else create a new subtable record
          )
    )

  )

; creates a table message passing style
; [??? -> TableObject]
(define (make-table)
  (let ((local-table (list '*table*
                           (list 'math
                                 (cons '+ 43) (cons '- 45) (cons '* 42))
                           (list 'letters
                                 (cons 'a 97) (cons 'b 98)))))
    
    (define (lookup key1 key2)
      (let ((subtable-record (assoc key1 (cdr local-table))))
        (cond [subtable-record (let ((record (assoc key2 (cdr subtable-record))))
                                 (cond [record (cdr record)]
                                       [else #f])
                                 )]
              [else #f]
              )
        )
      )
  
    (define (insert! key1 key2 value)
      (let ((subtable-record (assoc key1 (cdr local-table))))
        (cond [subtable-record (let ((record (assoc key2 (cdr subtable-record))))
                                 (cond [record (set-cdr! record value) 'subtable-updated]
                                       [else (set-cdr! subtable-record (cons (cons key2 value) (cdr subtable-record)))] ;insert the new record into the subtable
                                       )
                                 ) ]
              [else (set-cdr! local-table (cons (list key1 (cons key2 value)) (cdr local-table)))
                    'subtable-created ] ;else create a new subtable record
              )
        )
      )

    (define (dispatch m)
      (cond [(eq? m 'lookup) lookup]
            [(eq? m 'insert!) insert!])
      )
    
    dispatch
    )
  )



; creates a table message passing style
; [(Any Any -> Boolean) -> TableObject]
; same-key? is a procedure that takes 2 values and checks whether they're good enough.
(define (make-table same-key?)
  (let ((local-table (list '*table*
                           (list 'math
                                 (cons '+ 43) (cons '- 45) (cons '* 42) (cons 'pi 3.14))
                           (list 'letters
                                 (cons 'a 97) (cons 'b 98))) ))

    ;; assoc-custom : Any (Any Any -> Boolean) ListofPair -> (or Pair #false)
    (define (assoc-custom key records same-key-proc)
      (cond [(null? records) #f]
            [(same-key-proc key (caar records)) (car records)]
            [else (assoc-custom key (cdr records) same-key-proc) ])
      )
    
    (define (lookup key1 key2)
      (let ((subtable-record (assoc-custom key1 (cdr local-table) same-key?)))
        (cond [subtable-record (let ((record (assoc-custom key2 (cdr subtable-record) same-key?)))
                                 (cond [record (cdr record)]
                                       [else #f])
                                 )]
              [else #f]
              )
        )      
      )
  
    (define (insert! key1 key2 value)
      (let ((subtable-record (assoc-custom key1 (cdr local-table) same-key?)))
        (cond [subtable-record (let ((record (assoc-custom key2 (cdr subtable-record) same-key?)))
                                 (cond [record (set-cdr! record value) 'subtable-updated]
                                       [else (set-cdr! subtable-record (cons (cons key2 value) (cdr subtable-record)))]
                                       )
                                 ) ]
              [else (set-cdr! local-table (cons (list key1 (cons key2 value)) (cdr local-table)))
                    'subtable-created]
              )
        )
      )
    
    (define (dispatch m)
      (cond [(eq? m 'lookup) lookup]
            [(eq? m 'insert!) insert!])
      )
    dispatch
    )
  )


; Exercise 3.25
; Creates a table where key is an arbitrary length
(define (make-table)
  (list '*table* (list (list 'math 'pi) 3.14 ) (list (list 'user 'alice 'gaming) 100) (list (list 'letters 'vowels 'a) 88) )
  )

(define my-table (make-table))
my-table

; Gets the value of a Key-Value pairs in a table
; Any Table -> MaybeValue
(define (lookup key table)
  (let ((record (assoc key (cdr table)) ))
    (cond [record (cdr record)]
          [else #f])
    )
  )
(lookup (list 'user 'alice 'gaming) my-table)
;(lookup (list 'math 'pi) my-table)
;(lookup (list 'doesnt 'exist) my-table)


; Any Any Table -> 'ok
; Inserts new item into a table
(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (cond [record (set-cdr! record value)] ;check if record already exists with given key, if so replace the old value into the new value
          [else (set-cdr! table (cons (cons key value) (cdr table))) 'ok] ;else put new kv pair in front of the table 
          ) 
    )
  )
(insert! (list 'user 'alice 'gaming) 1234 my-table)
(insert! (list 'new 'thing) 550 my-table)
my-table

|#

; Exercise 3.26
;; A BSTree is one of:
;; - '()
;; - (make-node Key Value BSTree BSTree)
;; where left subtree has key less than current thre
;; and right subtree has key more than curent tree

; Creates a BST Node
; Any Any BSTree BSTree -> BSTree
(define (make-node key value left right)
  (list key value left right)
  )

; Examples of a BSTree Data structure
(define node1 (make-node 0 'admin '() '())   )
(define node2 (make-node 2 'super '() '()))
(define node0 (make-node 1 'user node1 node2))
;node0

; Selectors
; BSTree -> Key
; selects the key of a BSTree node
(define (node-key node)
  (car node)
  )

; BSTree -> Value
; selects the value of a BSTree node
(define (node-value node)
  (cadr node)
  )

; BSTree -> BSTree
; Selects the left node of a BSTree node
(define (node-left node)
  (caddr node)
  )
(node-left node0)

; BSTree -> BSTree
; Selects the right node of a BSTree node
(define (node-right node)
  (cadddr node)
  )

; Dummy table creation with BSTree
(define (make-table) (list '*table* node0))
(define my-table (make-table))

; Key Table -> MaybeValue
(define (lookup key table)
  ; Key BSTree -> MaybeValue
  ; Recursively searches BSTree for a key
  (define (lookup-in-tree key tree)
    (cond [(null? tree) #f]
          [(eq? key (node-key tree)) (node-value tree)]
          [(< key (node-key tree)) (lookup-in-tree key (node-left tree)) ] ; if given key is less than curr tree, recurse to the left tree
          ; if given key is greater than curr tree, recurse to the right tree
          ; else return false
          [(> key (node-key tree)) (lookup-in-tree key (node-right tree))]
          [else #f]
          )
    )
  (lookup-in-tree key (cadr table))
  )
  
(lookup 0 my-table)
(lookup 1 my-table)

(define (insert key value table)
  (define (insert-in-tree key value tree)
    (cond [(null? tree) (make-node key value '() '()) ] ; all trees traversed, insert at current node
          [(equal? key (node-key tree)) (set-car! (cdr tree) value)  tree] ;if curr key is equal, update its value
          [(> key (node-key tree)) (insert-in-tree key value (node-right tree))]
          [else (insert-in-tree key value (node-left tree)) ]
          )
    )
  (insert-in-tree key value (cadr table))
  )

my-table
(insert 2 'hey my-table)
my-table
(insert 0 'hello my-table)
my-table
(insert 3 'new my-table)
my-table