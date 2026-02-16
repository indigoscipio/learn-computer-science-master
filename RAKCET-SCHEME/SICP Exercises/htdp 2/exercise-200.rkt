;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise-200) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; the 2htdp/itunes teachpack documentation, part 1: 
(require 2htdp/itunes)

(define ITUNES-LOCATION "C:/Users/Samuel Oktavianus/Documents/itunes-simple.xml")


; An LTracks is one of:
; – '()
; – (cons Track LTracks)
(define itunes-tracks
  (read-itunes-as-tracks ITUNES-LOCATION))

;(define-struct date [year month day hour minute second])
; A Date is a structure:
[define-struct date-ex [year month day hour min sec]]
(define sample-date1 (make-date-ex 2023 1 26 14 30 0)) ; January 26, 2023, 2:30 PM
(define sample-date2 (make-date-ex 2022 12 31 23 59 59)) ; December 31, 2022, 11:59:59 PM

; A Track is a structure:
(define-struct track-ex
  [name artist album time track# added play# played])
(define sample-track1 (make-track-ex "Track Name 1" "Artist Name 1" "Album Name 1" 15018 48 sample-date1 8 sample-date1))
(define sample-track2 (make-track-ex "Track Name 2" "Artist Name 2" "Album Name 2" 4178 1122 sample-date2 55 sample-date2))
(define sample-ltracks (list sample-track1 sample-track2) )


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
(total-itunes-collection-playtime itunes-tracks)


;select-all-album-titles is a function that aconsumes an ltracks and produces the list of album title as list-of-strings
; LTracks -> List-of-strings
(define (select-all-album-titles ltracks)
  (cond [(empty? ltracks) '() ]
        [else (cons (track-album (first ltracks)) (select-all-album-titles (rest ltracks)))])
  )
(select-all-album-titles itunes-tracks)
