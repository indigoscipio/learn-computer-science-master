;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise-206) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; the 2htdp/itunes teachpack documentation, part 1: 
(require 2htdp/itunes)

(define ITUNES-LOCATION "C:/Users/Samuel Oktavianus/Documents/itunes.xml")


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



;select album consumes the title of an album and L tracks
; it extracts from the latter the list of tracks that belong to the given album
(define (select-album at ltracks)
  (cond [(empty? ltracks) '()]
        ;check if album title of the current track matches at, if so include it in the result
        [(equal? (track-album (first ltracks)) at) (cons (first ltracks) (select-album at (rest ltracks)) ) ]
        ;else skip it & recurse
        [else (select-album at (rest ltracks)) ])
  )
;(select-album "Coldplay Live 2003" itunes-tracks)


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
(define (select-album-date at ad ltracks)
  (cond [(empty? ltracks) '()]
        [(and (date-after? (track-played (first ltracks)) ad) (equal? (track-album (first ltracks)) at)) (cons (first ltracks) (select-album-date at ad (rest ltracks)) )  ]
        [else (select-album-date at ad (rest ltracks))]
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


;(read-itunes-as-lists ITUNES-LOCATION)
; LLists example
; An LLists is one of:
; – '()
; – (cons LAssoc LLists)
; (list (list (list "Track ID" 111) (list "Name" "Name 1"))
;       (list (list "Track ID" 222) (list "Name" "Name 2")))

; LAssoc example:
; An LAssoc is one of: 
; – '()
; – (cons Association LAssoc)
; (list (list "Track ID" 442) (list "Album Name" "Album Name"))

; Association example
; (cons String (cons BSDN '())) -> BDSN = Boolean Number String Date
; (list "Track ID" 442) 
; (list "Name" "Wild Child")
; (list "Date Modified" (make-date 2002 7 18 0 0 22))

;
(define )