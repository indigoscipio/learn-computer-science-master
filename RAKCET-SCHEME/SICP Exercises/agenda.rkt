#lang sicp

;; make-wire : -> wire
;; A wire is a procedure that accepts messages:
;;  - 'get-signal → returns current signal
;;  - 'set-signal! v → sets signal to v, if different, and runs actions
;;  - 'add-action! proc → adds proc to actions list
(define (make-wire)
  ; action procs stores a list of lambda
  (let ((signal-value 0)
        (action-procs '())
        )

    ; Calls all procedures from a given list of procs
    ; List-of-procs -> 'done
    (define (call-each-procs procs)
      (cond [(null? procs) 'done]
            [else ((car procs)) (call-each-procs (cdr procs))])
      )

    ; (number -> symbol) ; sets signal, returns 'unchanged or 'updated
    (define (set-signal! new-value)
      (cond [(= signal-value new-value) 'unchanged]
            [else (set! signal-value new-value)
                  (call-each-procs action-procs)
                  'updated])
      )

    ; Adds action to a wire
    ;((-> void) -> void) ; adds procedure to run on change
    (define (accept-action-procedure! proc)
      (set! action-procs (cons proc action-procs))
      (proc)
      )

    ; Dispatches message
    (define (dispatch m)
      (cond [(eq? m 'get-signal) signal-value]
            [(eq? m 'set-signal!) set-signal!]
            [(eq? m 'add-action!) accept-action-procedure!]
            [else (error "Unknown Message make-wire" m)]
            )
      )
  
    dispatch
    )
  )

(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))
(define (set-front-ptr! queue item)
  (set-car! queue item))
(define (set-rear-ptr! queue item)
  (set-cdr! queue item))
(define (empty-queue? queue)
  (null? (front-ptr queue)))
(define (make-queue) (cons '() '()))
(define (front-queue queue)
  (if (empty-queue? queue)
      (error "FRONT called with an empty queue" queue)
      (car (front-ptr queue))))
(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)  (else
                    (set-cdr! (rear-ptr queue) new-pair)
                    (set-rear-ptr! queue new-pair)
                    queue))))
(define (delete-queue! queue)
  (cond ((empty-queue? queue)
         (error "DELETE! called with an empty queue" queue))
        (else (set-front-ptr! queue (cdr (front-ptr queue)))
              queue)))

; A Segement (Time Segments) is a pair
; cons Time Queue where time = Number and queue = List-of-procesures
(define (make-time-segment time queue)
  (cons time queue)
  )
(define ts-example (make-time-segment 0 (list (lambda (x) x) (lambda (x) x))))

(define (segment-time s) (car s))
;(segment-time ts-example)

(define (segment-queue s) (cdr s))
;(segment-queue ts-example)


; =============================================

; Creates a empty agenda
; An agenda is a list of time segments
(define proc-a (lambda () (display "A")))
(define proc-b (lambda () (display "B")))
(define proc-c (lambda () (display "C")))
(define queue-1 (list proc-a))          ; for time = 5
(define queue-2 (list proc-b proc-c))   ; for time = 10
(define segment-1 (cons 8 queue-1))     ; (5 . (proc-a))
(define segment-2 (cons 12 queue-2))    ; (10 . (proc-b proc-c))


(define (make-agenda) (list 0))
(define my-agenda (cons 0 (list segment-1 segment-2)))


; returns the current simulation time
; Agenda -> Number
(define (current-time agenda)
  (car agenda)
  )

; Extracts the list of time segments of an agenda
; Agenda -> List-of-[Segments]
(define (segments agenda)
  (cdr agenda)
  )

; Extracts the first segments of an agenda
(define (first-segment agenda)
  (car (segments agenda))
  )

; Extracts the rest segments of an agenda
(define (rest-segments agenda)
  (cdr(segments agenda))  
  )

; sets the segments of an agenda
; List-of-segments -> agenda #void
(define (set-segments! agenda segments)
  (set-cdr! agenda segments)
  )

; sets current time to an agenda
; Agenda Number -> #void
(define (set-current-time! agenda time)
  (set-car! agenda time)
  )

; Checks if an agenda is empty
; An agenda is empty if it has no time segments
; Agenda -> Boolean
(define (empty-agenda? agenda)
  (null? (segments agenda))
  )

; =============================================

; Number [Procedure] Agenda -> #Void
; Adds action procedure to agenda
; If there's already a time segment at that time, put it in that segment’s queue
; If not, create a new segment and insert it in the correct position (time-sorted order).
(define (add-to-agenda! time action agenda)

  ; Checks if a time segment should be inserted before the given list of segments
  (define (belongs-before? segments)
    (or (null? segments) (< time (segment-time (car segments))))
    )

  ;Creates a brand new time segment with just one action in its queue.
  (define (make-new-time-segment time action)
    (let ((q (make-queue)))
      (insert-queue! q action) ;insert the queue
      (make-time-segment time q);return the reate new time segment
      )
    )

  ; Adds action to a segment
  (define (add-to-segments! segments)
    (cond [(= (segment-time (car segments)) time) (insert-queue! (segment-queue (car segments)) action )] ; add the action to that segment's queue
          [else (cond [(belongs-before? (cdr segments)) (set-cdr! segments (cons (make-new-time-segment time action) (cdr segments))) ] ;create new segment
                      [else (add-to-segments! (cdr segments))] ;else recurse
                      )
                ]
          )
    )

  (let ((segments (segments agenda)))
    (cond [(belongs-before? segments) (set-segments! agenda (cons (make-new-time-segment time action) segments))]
          [else (add-to-segments! segments)])
    )

  )
(add-to-agenda! 55 'f my-agenda)
my-agenda
(add-to-agenda! 50 'g my-agenda)
my-agenda
(add-to-agenda! 55 'c my-agenda)
my-agenda

(define (remove-first-agenda-item! agenda)
  (let ((q (segment-queue (first-segment agenda))))
    (delete-queue! q)
    (if (empty-queue? q)
        (set-segments! agenda (rest-segments agenda)))))

(define (first-agenda-item agenda)
  (if (empty-agenda? agenda)
      (error "Agenda is empty: FIRST-AGENDA-ITEM")
      (let ((first-seg (first-segment agenda)))
        (set-current-time! agenda
                           (segment-time first-seg))
        (front-queue (segment-queue first-seg)))))

(first-agenda-item my-agenda)
