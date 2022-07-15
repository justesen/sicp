#lang sicp

; Exercise 2.71
;
; Suppose we have a Huffman tree for an alphabet of n symbols, and that the
; relative frequencies of the symbols are 1,2,4,…,2^{n−1}. Sketch the tree for
; n=5; for n=10. In such a tree (for general n) how many bits are required to
; encode the most frequent symbol? The least frequent symbol?

; Such a tree would just be a "spine" with the symbols all hanging off to the left. For n=5:
;
;   {A B C D E}
;  /           \
; A         {B C D E}
;          /         \
;         B        {C D E}
;                 /       \
;                C       {D E}
;                       /     \
;                      D       E
;
; 1 bit is required for the most frequent symbol and n-1 for the least
; frequent.
