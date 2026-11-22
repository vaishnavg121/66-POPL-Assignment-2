#lang racket

(require rackunit
         rackunit/text-ui
         racket/runtime-path)

(define-runtime-path solution "../code/66_q3.rkt")

(dynamic-require solution #f)
(define solution-namespace (module->namespace solution))
(define print-inorder (eval 'print-inorder solution-namespace))
(define print-all-traversals (eval 'print-all-traversals solution-namespace))
(define print-height-and-leaves (eval 'print-height-and-leaves solution-namespace))

;; Compare each entry point with the expected lines for the same tree.
(define (my-check-tree tree inorder preorder postorder height-and-leaves)
  (check-equal? (with-output-to-string (lambda () (print-inorder tree)))
                inorder
                "print-inorder")
  (check-equal? (with-output-to-string (lambda () (print-all-traversals tree)))
                (string-append inorder preorder postorder)
                "print-all-traversals")
  (check-equal? (with-output-to-string (lambda () (print-height-and-leaves tree)))
                height-and-leaves
                "print-height-and-leaves"))

(define s1-tests
  (test-suite
   "S1 binary tree traversals"
   (test-case "t1"
     (my-check-tree '(4 (2 (1 () ()) (3 () ())) (6 (5 () ()) (7 () ())))
                    "(1 2 3 4 5 6 7)\n" "(4 2 1 3 6 5 7)\n" "(1 3 2 5 7 6 4)\n" "(3 4)\n"))
   (test-case "t2"
     (my-check-tree '(1 () (2 () (3 () ())))
                    "(1 2 3)\n" "(1 2 3)\n" "(3 2 1)\n" "(3 1)\n"))
   (test-case "t3"
     (my-check-tree '(a (b () ()) (c () ()))
                    "(b a c)\n" "(a b c)\n" "(b c a)\n" "(2 2)\n"))
   (test-case "empty tree"
     (my-check-tree '() "()\n" "()\n" "()\n" "(0 0)\n"))
   (test-case "single node"
     (my-check-tree '(x () ()) "(x)\n" "(x)\n" "(x)\n" "(1 1)\n"))
   (test-case "left-skewed tree"
     (my-check-tree '(3 (2 (1 () ()) ()) ())
                    "(1 2 3)\n" "(3 2 1)\n" "(1 2 3)\n" "(3 1)\n"))
   (test-case "right-skewed tree"
     (my-check-tree '(a () (b () (c () (d () ()))))
                    "(a b c d)\n" "(a b c d)\n" "(d c b a)\n" "(4 1)\n"))
   (test-case "tree of height 1000"
     (define tree
       (for/fold ([child '()]) ([value (in-range 1 1001)])
         (list value child '())))
     (define ascending (format "~a\n" (range 1 1001)))
     (define descending (format "~a\n" (range 1000 0 -1)))
     (my-check-tree tree ascending descending ascending "(1000 1)\n"))
   (test-case "running the solution directly is silent"
     (define racket-executable (find-executable-path (find-system-path 'exec-file)))
     (define stderr (open-output-string))
     (define stdout
       (with-output-to-string
         (lambda ()
           (parameterize ([current-error-port stderr])
             (check-equal? (system*/exit-code racket-executable solution) 0)))))
     (check-equal? stdout "" "stdout")
     (check-equal? (get-output-string stderr) "" "stderr"))))

(module+ main
  (exit (if (zero? (run-tests s1-tests)) 0 1)))
