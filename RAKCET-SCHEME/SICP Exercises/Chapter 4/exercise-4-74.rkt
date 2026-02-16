#lang sicp

; Exercise 4.71


; why does simple-query and disjoin implmeented using explicit delay instead of

(define (simple-query query-pattern frame-stream)
  (stream-flatmap
   (lambda (frame)
     (stream-append
      (find-assertions query-pattern frame)
      (apply-rules query-pattern frame)))
   frame-stream))

(define (disjoin disjuncts frame-stream)
  (if (empty-disjunction? disjuncts)
      the-empty-stream
      (interleave
       (qeval (first-disjunct disjuncts)
              frame-stream)
       (disjoin (rest-disjuncts disjuncts)
                frame-stream))))

; give examples of queries where these simpler definitions would lead to an undesirable behaviour
; because the eval has already a built in delay

; in the original code the stream is delayed and it might produce infinite answers, without delay you'll never reach the cdr


; ===============================
; Exercise 4.72

; why do disjoin and stream-flatmap interleve the streams rather than simply append them?
; give examples that illustrate why interleaving works better
; answer: interleave ensures every element from different streams will eventually be reached.
; interleave takes eleemnts alternately from two different streams and every element of the 2nd stream will find its way to the interlaved
; even if the first stream is infinite


; ===========================
; Exercise 4.73
; why does flatten-stream use delay explicitly? What would be wrong with defining it as follows:


(define (flatten-stream stream)
  (if (stream-null? stream)
      the-empty-stream
      (interleave
       (stream-car stream)
       (flatten-stream (stream-cdr stream)))))

; because without (delay), you would lose the benefit of a lazy stream
; this can cuase a inifinte calls to flatten-stream, creating a endless chain/stack

; ===========================
; Exercise 4.74
; Alyssa's code

(define (simple-stream-flatmap proc s)
  (simple-flatten (stream-map proc s)))
(define (simple-flatten stream)
  (stream-map stream-car
              (stream-filter (lambda (s) (not (stream-null? s)) ) stream)))
