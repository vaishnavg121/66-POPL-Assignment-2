#lang racket/base

;; An empty remainder returns the count. Otherwise count its first element
;; and continue with the rest without descending into sublists.
(define (my-length lst)
  (let my-count ([remaining lst] [count 0])
    (if (null? remaining)
        count
        (my-count (cdr remaining) (+ count 1)))))

;; An empty list returns the accumulator. Otherwise move the first value to
;; the front of the accumulator and continue with the rest.
(define (my-reverse values reversed)
  (if (null? values)
      reversed
      (my-reverse (cdr values) (cons (car values) reversed))))

;; Apply f to the first remaining element and collect its result, then recur.
;; When no elements remain, restore the original order.
(define (my-map f lst)
  (let my-collect ([remaining lst] [mapped-reversed '()])
    (if (null? remaining)
        (my-reverse mapped-reversed '())
        (my-collect (cdr remaining)
                    (cons (f (car remaining)) mapped-reversed)))))
