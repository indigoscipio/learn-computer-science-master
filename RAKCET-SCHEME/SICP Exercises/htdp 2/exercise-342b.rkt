;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-342b) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(require htdp/dir) 
; A Dir.v3 is a structure: 
;   (make-dir.v3 String (List-of Dir.v3) (List-of File.v3))
;(define-struct file [name size content])

 
; A File.v3 is a structure: 
;   (make-file String N String)
;(define-struct dir [name dirs files])

; String -> Dir.v3
; creates a representation of the a-path directory 
(define dir-location (create-dir "C:\\Users\\Samuel Oktavianus\\Documents\\sample-dir"))


(define (how-many dir)
  (+ (length (dir-files dir))
     (foldr + 0 (map how-many (dir-dirs dir) ) ))

  #|
  (cond [(and (empty? (dir-dirs dir)) (empty? (dir-files dir))) 0]
        ; does current dir contains any file? If so count that file and recurse to the next directory
        [else (+ (length (dir-files dir)) (how-many-dirs (dir-dirs dir)) ) ]

        )
  |#
  )
;(how-many dir-location)


;Exercise 340. Design the function ls,
;which lists the names of all files and directories in a given Dir.

; List-of-files.v3 -> List-of-string
;Extracts all of the file names from a lof
(define (get-file-names lof)
  (map (lambda (x) (file-name x)) lof)
  )
;(get-file-names (dir-files dir-location) )

; List-of-dirs.v3 -> List-of-string
; extracts all of the dir names from a lod
(define (get-dir-names lod)
  (map dir-name lod)
  )

;Dir.v3 -> List-of-string
(define (ls dir)
  (append (list (dir-name dir))
          (get-file-names (dir-files dir)) 
          ;(get-dir-names (dir-dirs dir))
          (combine-subdirs (dir-dirs dir))
          )  
  )

; List-of-dirs.v3 -> List-of-string
(define (combine-subdirs lod)
  (cond [(empty? lod ) '()]
        [else (append (ls (first lod))
                      (combine-subdirs (rest lod)) )])
  )
;(combine-subdirs (dir-dirs dir-location))
;(ls dir-location)



;Exercise 341. Design du, a function that consumes a Dir and computes the total size of all the files
;in the entire directory tree. Assume that storing a directory in a Dir structure costs 1 file storage unit.
;In the real world, a directory is basically a special file, and its size depends on how large its associated directory is.

;List-of-files -> Number
;computes the total of all files size in a given lof
(define (compute-files-size lof)
  (cond [(empty? lof) 0]
        [else (+ (file-size (first lof)) (compute-files-size (rest lof)))])
  )
;(compute-files-size (dir-files dir-location))

;LIst-of-dirs -> Number
;computes total of all nested subdirectories
(define (compute-dirs-size lod)
  (cond [(empty? lod) 0];base case: return 0 if theres no more subdirectory to find
        [else (+ (du (first lod))
                 (compute-dirs-size (rest lod)))])
  )

(define (du dir)
  (+ 1 (compute-files-size (dir-files dir))
     (compute-dirs-size (dir-dirs dir))
     ) 
  )

;(du dir-location)
; List-of-file String Path -> [Maybe Path]
;; Dir -> [List-of Path]
;; Purpose: Lists all file paths in the given directory and its subdirectories.
(define (ls-R dir)
  (local ( ;; Helper function to list all files in the current directory
          ;List-of-files.v3 -> [List-of-string]
          (define (list-files lof path)
            (cond [(empty? lof) '()]
                  [else (cons (append (list path (file-name (first lof))))(list-files (rest lof) path))  ])
            )
          ;; Helper function to recursively list files in subdirectories
          ; List-of-dirs.v3 -> [List-of-string] 
          (define (list-subdirs lod path)
            (cond [(empty? lod) '()]
                  [else (append (ls-R-helper (first lod) path)
                                (list-subdirs (rest lod) path))])
            )
          ;; Main recursive function with accumulated path
          ; Dir.v3 -> List-of-[List-of-string]
          (define (ls-R-helper dir path)
            (append (list-files (dir-files dir) path)
                    (list-subdirs (dir-dirs dir) path))
            )
          )
    (ls-R-helper dir (list ))
    )
  )
(ls-R dir-location)