# CS F301 Principles of Programming Languages: Assignment 2

Group ID: 66

## Members

| Name | Student ID |
| --- | --- |
| Venkatanaga Vaishnav Gadamsetty | 2024A7PS0026H |
| Chaitrali Dharmadhikari | 2024A7PS0133H |

## Repository layout

```text
.
├── .github/
│   └── workflows/
│       └── test.yml
├── 66/
│   ├── code/
│   │   ├── 66_q1.pl
│   │   ├── 66_q2.pl
│   │   ├── 66_q3.rkt
│   │   └── 66_q4.rkt
│   ├── tests/
│   │   ├── run_all.sh
│   │   ├── test_p1.pl
│   │   ├── test_p2.pl
│   │   ├── test_s1.rkt
│   │   └── test_s2.rkt
│   ├── skills/
│   │   ├── prolog-dev/
│   │   │   └── SKILL.md
│   │   └── scheme-dev/
│   │       └── SKILL.md
│   ├── prompts/
│   │   ├── SETUP.md
│   │   ├── P1.md
│   │   ├── P2.md
│   │   ├── S1.md
│   │   └── S2.md
│   └── P1_REPORT.md
├── .gitignore
└── README.md
```

The local assignment handout lives at `handout/assignment.pdf`.

## How to run

Run these commands from the repository root with SWI-Prolog 9.x and Racket 8.x.

### Prolog

P1 prints one solution. The P2 example queries `all_equations/2` and prints the returned list.

```bash
swipl -q -f 66/code/66_q1.pl -g main -t halt
swipl -q -f 66/code/66_q2.pl -g "all_equations([4,2,5,3],E),writeq(E),nl" -t halt
```

### Racket

Both files load silently. The grader appends its own function calls.

```bash
racket 66/code/66_q3.rkt
racket 66/code/66_q4.rkt
```

### Tests

Run all four test suites.

```bash
bash 66/tests/run_all.sh
```
