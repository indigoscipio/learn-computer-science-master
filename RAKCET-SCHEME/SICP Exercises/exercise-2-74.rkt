#lang racket


;Exercise 2.73
(define *op-table* (make-hash))

;; put : op type proc -> Void
; List Op-Name Type is the key
; Proc is the value
(define (put op-name type proc)
  (hash-set! *op-table* (list op-name type) proc))     


;; get : op type -> proc or #f
; List Op-name Type is the key
(define (get op-name type)
  (hash-ref *op-table* (list op-name type) #f))


; ???
(define (attach-tag type-tag contents)
  (cons type-tag contents))

; ???
(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum: TYPE-TAG" datum)))

; ???
(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum: CONTENTS" datum)))

; Symbol Any -> Tagged
(define (tag x name) (attach-tag name x))

; Different Personnel Files Data

;A Record is a List of file
;A File is a ??

;Division A:
;String DivisionAFile -> MaybeRecord
(define division-a-file
  (tag '(("Alice" ("address" "123 Street") ("salary" 50000))
          ("John"  ("address" "789 Road") ("salary" 55000))) 'division-a )
  )

; Division B
; String DivisionBFile -> MaybeRecord
(define division-b-file
  (tag '(("Bob" ("address" "123 Street") ("salary" 1000))
         ("Chase"  ("address" "789 Road") ("salary" 1000))) 'division-b)
  )

; String TaggedPersonnelFile -> MaybeRecord
; Given an employee name and a personnel file (tagged by division),
; retrieve the employee's record if it exists, otherwise return #f.
(define (get-record employee-name personnel-file)
  (let* ((tag (type-tag personnel-file) )
         (proc (get 'get-record tag))
         )
    (cond [(false? proc) (error "Unknown file type -- GET-RECORD" tag)]
          [else (proc employee-name (contents personnel-file))]
          )
    )
  )

; String DivisionAFile -> MaybeRecord
; Looks up the employee-name in the association list representing the personnel file.
(define (get-record-division-a employee-name file)
   (assoc employee-name file)
  )

; returns a salary information of a given employee name
(define (get-salary employee-name personnel-file)
  (let* ((tag (type-tag personnel-file) )
         (proc (get 'get-record tag))
         )
    (proc employee-name (contents personnel-file))
    )
  )


; String DivisionAFile
(define (get-salary-division-a employee-name file)
  (let* ((record (assoc employee-name (contents file)))
        )
    (cond [(false? record) #f]
          [else (second (assoc "salary" (cdr record)))])
    )
  )
;(put 'get-salary 'division-a get-salary-division-a)
;((get 'get-salary 'division-a) "John"  division-a-file)

; List-of-Records (File) -> MaybeRecord
(define (find-employee-record employee-name file)
  ; using assoc
  ;(assoc employee-name file)

  ; using recursion

  (cond [(empty? file) #f]
        [(equal? (car (car file)) employee-name ) (car file) ]
        [else (find-employee-record employee-name (cdr file))]
        )

  )
(find-employee-record "Chase" '(("Bob" ("address" "123 Street") ("salary" 1000))
                       ("Chase"  ("address" "789 Road") ("salary" 1000))))