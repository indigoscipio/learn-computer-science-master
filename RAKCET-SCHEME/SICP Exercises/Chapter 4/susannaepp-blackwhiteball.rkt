#lang racket

(define BLACK_BALL 50)
(define WHITE_BALL 50)


; urn contains a mixture of white and black balls
; in each move you remove two balls from the urn without looking at their color
; if the balls are the same color, you put in one black ball
; if the balls are different colors, you put the white ball back into the urn and keep the black ball out
; 