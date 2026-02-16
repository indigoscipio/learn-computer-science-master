#lang sicp


;; A Node is (cons Any (cons Node-or-false Node-or-false))
;; Interpretation: (cons v (cons next prev))
;; next and prev are either nodes or '() if there's nothing in that direction.
; node = (cons value links)
; links = (cons next previous)


(define (make-node value prev next)
  (cons value (cons prev next)))

(define node1 (make-node 1 0 2))
(define node2 (make-node 2 node1 3))

(define (node-val node) (car node))
(define (node-links node) (cdr node))
(define (node-next node) (cddr node))
(define (node-prev node) (cadr node))


(define (set-node-prev! node prev)
  (set-car! (cdr node) prev))
(define (set-node-next! node next)
  (set-cdr! (cdr node) next))

(define (make-deque) (cons '() '()))
(define dq (make-deque))


(define (front-ptr deque) (car deque))
(define (rear-ptr deque) (cdr deque))

; Deque Any -> Deque
(define (set-front-ptr! deque item)
  (set-car! deque item)
  )


; Deque Any -> Deque
(define (set-rear-ptr! deque item)
  (set-cdr! deque item)
  )

; Checks if a dequeue is empty
(define (empty-deque? deque)
  (or (null? (front-ptr deque))
      (null? (rear-ptr deque)))
  )


; Selects the front item of a deque
(define (front-deque deque)
  (cond [(empty-deque? deque) (error "front-dequeue is called with empty queue:" deque)]
        [else (front-ptr deque)])
  )

; Selects the rear item of a deque
(define (rear-deque deque)
  (cond [(empty-deque? deque) (error "rear-deque called with an empty deque" deque)]
        [else (node-val (rear-ptr deque)) ])
  )


; inserts new item into deque 
(define (front-insert-deque! deque item)
  (let ((new-node (make-node item '() (front-ptr deque) )))
    (cond [(empty-deque? deque) (set-front-ptr! deque new-node)
                                (set-rear-ptr! deque new-node)
                                ]
          [else (set-node-prev! (front-ptr deque) new-node)
                (set-front-ptr! deque new-node) ])
    )
  )

; inserts new item into deque 
(define (rear-insert-deque! deque item)
  (let ((new-node (make-node item (rear-ptr deque) '())))
    (cond ((empty-deque? deque)
           (set-front-ptr! deque new-node)
           (set-rear-ptr! deque new-node))
          (else
           (set-node-next! (rear-ptr deque) new-node)
           (set-rear-ptr! deque new-node)))))


