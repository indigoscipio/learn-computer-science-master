;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-438) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
; N[>= 1] N[>= 1] -> N
; finds the greatest common divisor of n and m
;gcd with structural recursion

(define (sr-gcd n m)
    (cond [(= m 0) n]
          [else (sr-gcd m (remainder n m))])

  )

(define (gcd-structural n m)
  (local (; N -> N
          ; determines the gcd of n and m less than i
          (define (greatest-divisor-<= i)
            (cond
              [(= i 1) 1]
              [else
               (if (= (remainder n i) (remainder m i) 0)
                   i
                   (greatest-divisor-<= (- i 1)))])))
    (greatest-divisor-<= (min n m))))

(time (gcd-structural 101135853 45014640))


(check-expect (sr-gcd 6 25) 1)
(check-expect (sr-gcd 18 24) 6)

(remainder 12 7)
(remainder 7 12)
(remainder 7 32)

#|
Exercise 438. In your words: how does greatest-divisor-<= work?
Use the design recipe to find the right words.
Why does the locally defined greatest-divisor-<= recur on (min n m)?(time (gcd-structural 101135853 45014640))



answer:
The function takes  minimum value of n and m as it sargument
N -> N
this is because in finding the gcd the smallest cannot exceed tha maximum as the common factor

greatest divisor-<=1 takes a number i (te minimum of two gcd inputs earlier) and returns a number

Base Case
then it checks wheter i is euqal to 1. This is because 1 is alwasy the minimum gcd for all numbers and its also the bcase case

Recursive Step
chekck for the two remindainers of m and n with i
If the remainder of n divided with i and reminder of m divided by i equals to 0,
return i
otherwise recurse, with i subtracted by 1 


|#
