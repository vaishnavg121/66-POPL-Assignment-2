#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

swipl -f none -s test_p1.pl -g run_tests -t halt
swipl -f none -s test_p2.pl -g run_tests -t halt
racket test_s1.rkt
racket test_s2.rkt
