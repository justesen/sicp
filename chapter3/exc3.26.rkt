#lang sicp

; Exercise 3.26
;
; To search a table as implemented above, one needs to scan through the list of
; records. This is basically the unordered list representation of 2.3.3. For
; large tables, it may be more efficient to structure the table in a different
; manner. Describe a table implementation where the (key, value) records are
; organized using a binary tree, assuming that keys can be ordered in some way
; (e.g., numerically or alphabetically). (Compare Exercise 2.66 of Chapter 2.)

; Instead of each (sub) table being a list, it would be a binary tree
; structure.
