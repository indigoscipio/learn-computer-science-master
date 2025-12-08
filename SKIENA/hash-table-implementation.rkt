#lang racket

; A KVPair is (cons Key Value)
; A Bucket is (listof KVPair)
; A HashTable is (vectorof Bucket)
; where each Bucket is a list of pairs

(define vec (vector 10 20 30))
(define empty-ht (make-vector 5 '()))
(define bucket1 '((1 . 2)))
(define bucket2 '((3 . 4)))
(define ht1 (vector bucket1 bucket2) )

(vector-set! vec 0 12321321)
vec

; Key List-of Key Value -> MaybeValue
; performs a bucket lookup
(define (bucket-lookup k bucket)
  (cond [(null? bucket) #f]
        [(eq? k (car (car bucket))) (cdr (car bucket)) ] ;key found
        [else (bucket-lookup k (cdr bucket))]
        )
  )

; given a value and bucket, performs a put operation
; Key Value Bucket -> Bucket
(define (bucket-put k v bucket)
  (cond [(null? bucket) (cons (cons k v) bucket) ] ;key does not exist, just insert
        [(eq? k (car (car bucket))) (cons (cons k v) (cdr bucket)) ] ;key exists
        [else (cons (car bucket) (bucket-put k v (cdr bucket)) ) ] ;recurse and rebuild the whole list
        )
  )


; Key HashTable -> Number
(define (hash key ht)
  (modulo key (vector-length ht))
  )
(hash 1548 empty-ht)

; Key Value HashTable -> HashTable
; returns a new table with key added or updated
(define (put k v ht)
  ; check if key exists
  ; if not cons new pair
  ; update ht
  (let* ((bucket-index (hash k ht))
         (old-bucket (vector-ref ht bucket-index))
         (new-bucket (bucket-put k v old-bucket))
         )
    (vector-set! ht bucket-index new-bucket)
    ht
    )
  )

; Key HashTable -> MaybeValue
(define (get k ht)
  (let* ((bucket-index (hash k ht))
        (bucket (vector-ref ht bucket-index))
        )
    (bucket-lookup k bucket)
    )
  )
(get 3 ht1)