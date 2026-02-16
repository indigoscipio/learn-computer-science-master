;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise-201) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; the 2htdp/itunes teachpack documentation, part 1: 
(require 2htdp/itunes)

(define ITUNES-LOCATION "C:/Users/Samuel Oktavianus/Documents/itunes-simple.xml")


; An LTracks is one of:
; – '()
; – (cons Track LTracks)
(define itunes-tracks
  (read-itunes-as-tracks ITUNES-LOCATION))

;total-time consumes an element of LTracks and produces the total amount of play time.
;Track -> Number
(define (total-time track)
  (track-time track)
  )

;total-itunes-collection-playtime sums total amount of playtime in all given list of tracks
;Ltracks -> Number
(define (total-itunes-collection-playtime ltracks)
  (cond [(empty? ltracks) 0]
        [else (+ (track-time (first ltracks)) (total-itunes-collection-playtime (rest ltracks)) )])
  )


;select-all-album-titles is a function that aconsumes an ltracks and produces the list of album title as list-of-strings
; LTracks -> List-of-strings
(define (select-all-album-titles ltracks)
  (cond [(empty? ltracks) '() ]
        [else (cons (track-album (first ltracks)) (select-all-album-titles (rest ltracks)))])
  )
;(select-all-album-titles itunes-tracks)


;is-duplicate checks if a LoS contains a duplicate of s
;if it is, return true; otherwise false.
;String -> LoS
(define (is-duplicate? s los)
  (cond [(empty? los) #false]
        [(equal? s (first los)) #true]
        [else (is-duplicate? s (rest los)) ])
  )



;create-set consumes a LoS and constructs one that contains every String from the given list exactly once
;If String s is at the front of the given list and occurs in the rest of the list, too, create-set does not keep s
;LoS LoS -> LoS
(define (create-set los unique-los)
  (cond [(empty? los) (reverse unique-los)]
        ;check for duplicates, if there's any duplicates then skip it and recurse with the skipped checked item
        [(is-duplicate? (first los) unique-los) (create-set (rest los) unique-los ) ]
        ;if the string isn't already in the set, add it into the unique set.
        [else (create-set (rest los) (cons (first los) unique-los)) ])
  )

; select-album-titles/unique consumes an LTracks and produces a list of unique album titles
; LTracks -> LoS
(define (select-album-titles/unique ltracks)
  (cond [(empty? ltracks) '()]
        [else (create-set (select-all-album-titles ltracks) '())])
  )

(define (select-album) )