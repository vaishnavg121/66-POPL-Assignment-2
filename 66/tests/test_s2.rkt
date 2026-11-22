#lang racket

(require rackunit
         rackunit/text-ui
         racket/runtime-path)

(define-runtime-path solution "../code/66_q4.rkt")

(dynamic-require solution #f)
(define solution-namespace (module->namespace solution))
(define print-insert-result (eval 'print-insert-result solution-namespace))
(define my-length (eval 'my-length solution-namespace))
(define my-map (eval 'my-map solution-namespace))
(define make-inserter (eval 'make-inserter solution-namespace))
(define insert-if-short (eval 'insert-if-short solution-namespace))

;; Feed one input to the printer and check its whole output, including the newline.
(define (my-check-print input expected)
  (check-equal? (with-output-to-string
                  (lambda ()
                    (with-input-from-string input print-insert-result)))
                expected))

(define s2-tests
  (test-suite
   "S2 nested list insertion"
   (test-case "handout example 1"
     (my-check-print "42 ((1 2) (3 4 5) (6) ()) 3\n"
                     "((42 1 2) (3 4 5) (42 6) (42))\n"))
   (test-case "handout example 2"
     (my-check-print "0 (((1) 2) (3) ((4 5 6) ())) 3\n"
                     "((0 (0 1) 2) (0 3) (0 (4 5 6) (0)))\n"))
   (test-case "handout example 3"
     (my-check-print "7 () 3\n" "(7)\n"))
   (test-case "handout example 4"
     (my-check-print "7 () 0\n" "()\n"))
   (test-case "my-length counts top-level elements"
     (check-equal? (my-length '()) 0)
     (check-equal? (my-length '((a b) () (c (d e)) f)) 4)
     (check-equal? (my-length (range 10000)) 10000))
   (test-case "my-map preserves order and treats sublists as elements"
     (check-equal? (my-map (lambda (_) (error "callback called on empty input")) '())
                   '())
     (check-equal? (my-map list '(a (b c) () d)) '((a) ((b c)) (()) (d)))
     (check-equal? (my-map add1 (range 10000)) (range 1 10001)))
   (test-case "make-inserter accepts a custom length predicate"
     (define insert-at-two (make-inserter 'x (lambda (size) (= size 2))))
     (check-equal? (procedure-arity insert-at-two) 1)
     (check-equal? (insert-at-two '((a b) (() c d))) '(x (x a b) (() c d))))
   (test-case "zero threshold preserves a nested list"
     (define original '(a () ((b) c)))
     (check-equal? (insert-if-short 'x original 0) original))
   (test-case "length equal to the threshold prevents insertion at that level"
     (check-equal? (insert-if-short 'x '(a (b c) ()) 3) '(a (x b c) (x)))
     (check-equal? (insert-if-short 'x '((a b)) 2) '(x (a b))))
   (test-case "symbol atoms in input and output"
     (my-check-print "tag ((red blue) green ()) 4\n" "(tag (tag red blue) green (tag))\n"))
   (test-case "nesting depth 100"
     (define nested
       (for/fold ([lst '(leaf)]) ([_ (in-range 99)])
         (list lst)))
     (define expected
       (for/fold ([lst '(tag leaf)]) ([_ (in-range 99)])
         (list 'tag lst)))
     (check-equal? (insert-if-short 'tag nested 2) expected))
   (test-case "10,000 elements on both sides of the threshold"
     (define wide (range 10000))
     (check-equal? (insert-if-short 'x wide 9999) wide)
     (check-equal? (insert-if-short 'x wide 10001) (cons 'x wide)))
   (test-case "running the solution directly is silent"
     (define racket-executable (find-executable-path (find-system-path 'exec-file)))
     (define stderr (open-output-string))
     (define stdout
       (with-output-to-string
         (lambda ()
           (parameterize ([current-input-port (open-input-string "")]
                          [current-error-port stderr])
             (check-equal? (system*/exit-code racket-executable solution) 0)))))
     (check-equal? stdout "" "stdout")
     (check-equal? (get-output-string stderr) "" "stderr"))))

(module+ test
  (unless (zero? (run-tests s2-tests))
    (error 'test-s2 "RackUnit suite failed")))

(module+ main
  (require (submod ".." test)))
