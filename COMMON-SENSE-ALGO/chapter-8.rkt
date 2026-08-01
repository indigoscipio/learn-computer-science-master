#lang racket

; CHAPTER 8
; HASHTABLES


(make-hash)

(define menu (hash 'key1 '0.75 'key2 '2.5))
(hash-ref menu 'key1)

(define ht (make-hash))
(hash-set! ht 'key0 66)
ht
(hash-set! ht 'key1 100)
ht
(hash-ref menu 'key2)

(hash-set menu 'key1 8)


#|
#hash -> immutable
hash ... -> immutable
hash-set -> immutable

(make-hash) -> mutable
hash-set! -> mutable
|#

; COLLISION -> when index is filled, just do i+1
; HOW HASHING WORKS
; hash the key -> turns into number -> jumps to index with that number

; =====================================
; THESAURUS
(define thesaurus (make-hash))
(hash-set! thesaurus 'bad 'evil)
(hash-set! thesaurus 'cab 'taxi)
(hash-set! thesaurus 'ace 'star)
thesaurus
(hash-ref thesaurus 'bad)

; SEPERATE CHAINING
; happens when theres a 'collision' when hashing to same index
; solution? make that index into a subarray -> perform n search

; EFFICIENT HASH TABLE
; LOAD FACTOR AROUND 70-80%

; OTHER HASH FUNCTION
; doesn't always need to check for key . value
; sometimes key lookup is also needed, no need to check value

; =======================================

; SUBSET
; finds which array is smaller
; iterate thorugh smaller

; checks if xs is a subset of ys
; regular method
(define (subset xs ys)
  (let ((larger-xs (if (> (length xs) (length ys)) xs ys))
        (smaller-xs (if (<= (length xs) (length ys)) xs ys )))

    (define (helper lst)
      ; fix xs, do membership
      (cond [(null? lst) #t]
            [(member (car lst) larger-xs) (helper (cdr lst)) ]
            [else #f]
            )
      )
    (helper smaller-xs)
    )
  )
(subset '('a 'b 'c 'd 'e 'f) '('b 'd 'f)) ;should return true
(subset '('a 'b 'c 'd 'e 'f) '('b 'd 'f h)) ;should return false



; with hash table
; map larger array to hash (a: true, b: true, ...)
; for each smaller arry item, check if its there
(define (subset-hash xs ys)
  (let ((larger-xs (if (> (length xs) (length ys)) xs ys))
        (smaller-xs (if (<= (length xs) (length ys)) xs ys))
        (ht (make-hash)))

    ; populates hash table with larger xs and value all true
    ; list-of-x -> void
    (define (fill-ht lst)
      (cond [(null? lst) 'done]
            [else (begin (hash-set! ht (car lst) #t)
                         (fill-ht (cdr lst))
                         ) ]
            )
      )
    
    ; list-of-x -> boolean
    (define (subset-helper lst)
      (cond [(null? lst) #t]
            [else (let ((key-exists? (hash-has-key? ht (car lst)) ))
                    (if key-exists?
                        (subset-helper (cdr lst))
                        #f
                        )
                    )]
            )
      )
    
    (fill-ht larger-xs)
           (subset-helper smaller-xs)
    
    )
  )
(subset-hash '('a 'b 'c 'd 'e 'f) '('b 'd 'f)) ;should return true
(subset-hash '('a 'b 'c 'd 'e 'f) '('b 'd 'f h)) ;should return false

; =======================================


; HASH FUNCTION
; just makeit very simple
; key -> number
(define (hash-function key)
  (equal-hash-code key)
  )
(hash-function 'a)
(hash-function 'apple)
(hash-function 42)

; CONSTRUCTORS
; hash table from scratch
(define (my-make-hash)
  (make-vector 0)
  )
(my-make-hash)

(define (my-hash-set!)
  0
  )

; SELECTORS
(define (my-get-hash)
  0
  )

; =======================================