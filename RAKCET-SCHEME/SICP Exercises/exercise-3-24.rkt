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

|#

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


; Number Number -> Boolean
; custom closeness procedure that checks if two numbers are within certain thereshold
(define (is-close-enough? x y)
  (< (abs (- x y)) 0.01)
  )


; For standard equality comparison (using equal?)
(define operations-table (make-table equal?))
(define get-op (operations-table 'lookup))
(define put-op (operations-table 'insert!))

(get-op 'math '+)
(put-op 'math '/ 99)
(get-op 'math '/)
