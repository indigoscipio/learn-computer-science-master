;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-276b) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
; the 2htdp/itunes teachpack documentation, part 1: 
(require 2htdp/itunes)

(define ITUNES-LOCATION "C:/Users/Samuel Oktavianus/Documents/itunes-simple.xml")


; An LTracks is one of:
; – '()
; – (cons Track LTracks)
(define itunes-tracks
  (read-itunes-as-tracks ITUNES-LOCATION))
itunes-tracks

;total-time consumes an element of LTracks and produces the total amount of play time.
;Track -> Number
(define (total-time track)
  (track-time track) 
  )


; A Date is a structure:
;   (make-date N N N N N N)
; (define-struct date [year month day hour minute second]
; the date's year, month (between 1 and 12 inclusive), 
; day (between 1 and 31), hour (between 0 
; and 23), minute (between 0 and 59), and 
; second (also between 0 and 59).
;date after is a function that compares two Date
;it returns true if d1 occurs after d2
;itunes-tracks
; Date Date -> Boolean
(define (date-after? d1 d2)
   (cond 
    [(> (date-year d1) (date-year d2)) #true]
    [(< (date-year d1) (date-year d2)) #false]
    [(> (date-month d1) (date-month d2)) #true]
    [(< (date-month d1) (date-month d2)) #false]
    [(> (date-day d1) (date-day d2)) #true]
    [(< (date-day d1) (date-day d2)) #false]
    [(> (date-hour d1) (date-hour d2)) #true]
    [(< (date-hour d1) (date-hour d2)) #false]
    [(> (date-minute d1) (date-minute d2)) #true]
    [(< (date-minute d1) (date-minute d2)) #false]
    [(> (date-second d1) (date-second d2)) #true]
    [else #false]) )


;(date-after? (track-played (first itunes-tracks)) (track-played (second itunes-tracks)) )

;select-album-date consumes the title of an album, a date and an LTracks
;it extracks from the latter the list of tracks that belong to the given album
; and have been played after the given date
; hint you m ust design a function that consumes two dates and determines wheter the first occurs before the second.
; String Date LTracks -> [List-of-tracks]
(define (select-album-date at ad ltracks)
  (local (;(X -> boolean)
          (define (matches? track)
            (and (date-after? (track-played track) ad)
                 (equal? (track-album track) at )
                 )
            )) 
    (filter matches? ltracks)
    )
  )


 
; String LTracks -> LoS
; select-tracks-by-album-name consumes a String and LTracks
; it produces a list of all album tracks names that belong the given album title
(define (select-all-tracks an ltracks)
  (cond [(empty? ltracks) '()]
        [else (cons (track-name (first ltracks)) (select-all-tracks an (rest (select-album an ltracks) ))) ])
  ) 
;(select-all-tracks "A Day Without Rain" itunes-tracks)

 

; LoS (List of unique album titles) LTracks -> Ltracks
;group-tracks-by-unique-albums consumes loat and ltracks, and produces a list of list of strings
(define (group-tracks-by-unique-albums loat ltracks)
  (cond [(empty? loat) '()]
        [else (cons (select-all-tracks (first loat) ltracks)
                    (group-tracks-by-unique-albums (rest loat) ltracks) ) ]
      )
  ) 


;select-albums consumes an element of Ltracks
;it produces a list of ltracks, one per album.
;each album is uniquely identified by its title and and shows up in the result only once.
; hint (1) you want to use some of the solutions from the previous exercise
; (2) the functino that groups consumes two lists: the list of album titles and the list of tracks;
; it considers the latter as atomic until it is hanedd over to an auxiliary function
(define (select-albums ltracks)
  (group-tracks-by-unique-albums (select-album-titles/unique ltracks) ltracks)
  )