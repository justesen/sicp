#lang sicp

; Exercise 2.76
;
; As a large system with generic operations evolves, new types of data objects
; or new operations may be needed. For each of the three strategies—generic
; operations with explicit dispatch, data-directed style, and
; message-passing-style—describe the changes that must be made to a system in
; order to add new types or new operations. Which organization would be most
; appropriate for a system in which new types must often be added? Which would
; be most appropriate for a system in which new operations must often be added?

; With explicit dispatch, a new constructor/selector must be created for each
; type that's added. In all operations, we have to add this new type to the
; internal dispatch. This works well if there are few operations. Example with
; deriv: To add exponentiation, we added new selectors/constructors
; (base/exponent/make-exponent) and added another case to cond in the deriv
; procedure.

; With a data-directed style, we can just add a new package, the higher-level
; operations stay the same. Example with deriv: To add exponentiation, we added
; new selectors/constructors (base/exponent/make-exponent) and added a
; procedure for finding derivatives of an exponent *all in one place*, the
; package. To add a new operation (integration?), we'd have to add that
; procedure to each package.

; With a message-passing style, errh, I'm not quite sure...
