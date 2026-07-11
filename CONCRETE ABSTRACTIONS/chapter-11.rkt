#lang racket

; SLIM -> super-lean instruction machine
; adding 5 and 6
; copy value inside mem address 5 to reg
; copy value inside mem address 6 to second reg
; ALU perform additino

; instruction memory -> permanent -> holds functions that tells the control unit what to do
; eg JUMP, ADD, LOAD
; data memory -> temorary

; add 17 2 5
; 17 -> dest register
; 2 5 -> source register