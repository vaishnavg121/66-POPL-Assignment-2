:- ensure_loaded('../code/66_q1.pl').

:- begin_tests(p1).

:- use_module(library(pcre), [re_match/2, re_matchsub/4]).
:- use_module(library(readutil), [read_file_to_string/3]).

% final_solution(-Solution) holds for the assignment that satisfies all nine clues.
final_solution([p('Alex', design, java, embedded),
                p('Ben', development, javascript, web),
                p('Carla', testing, python, 'AI'),
                p('Dana', research, 'c++', data)]).

% counterexample(-Solution) holds for a bijective assignment that violates clues 1–8.
counterexample([p('Alex', research, 'c++', web),
                p('Ben', testing, java, data),
                p('Carla', design, javascript, embedded),
                p('Dana', development, python, 'AI')]).

% count_case(-Active, -Expected) holds for each clue list and its expected count.
count_case([], 13824).
count_case([1,2,3,4,5,6,7,8], 3).
count_case([1,2,3,4,5,6,7,8,9], 1).
count_case([8,7,6,5,4,3,2,1], 3).
count_case([1,2,3,4,5,6,7,8,9,3], 1).

test(clue_accepts_final_solution, [forall(between(1, 9, N))]) :-
    final_solution(Solution),
    once(clue(N, Solution)).

test(clue_rejects_counterexample, [forall(between(1, 8, N)), fail]) :-
    counterexample(Solution),
    clue(N, Solution).

test(count_solutions, [forall(count_case(Active, Expected)), true(N == Expected)]) :-
    count_solutions(Active, N).

test(main_output, [true(Output == Expected)]) :-
    with_output_to(string(Output), main),
    atomics_to_string(["Alex = [design, java, embedded]",
                       "Ben = [development, javascript, web]",
                       "Carla = [testing, python, AI]",
                       "Dana = [research, c++, data]",
                       ""], "\n", Expected).

test(clue_9_has_a_comment_without_names) :-
    predicate_property(clue(9, _), file(File)),
    read_file_to_string(File, Source, []),
    Pattern = "(?m)^% CLUE 9:[ \t]+(?<comment>[^\r\n]+)\r?\n[ \t]*clue\\(\\s*9\\s*,",
    re_matchsub(Pattern, Source, Match, []),
    \+ re_match("\\b(alex|ben|carla|dana)\\b"/i, Match.comment).

test(clue_9_has_no_name_in_its_clause, [fail]) :-
    Head = clue(9, _),
    clause(Head, Body),
    sub_term(Atom, (Head :- Body)),
    atom(Atom),
    downcase_atom(Atom, Name),
    memberchk(Name, [alex, ben, carla, dana]).

:- end_tests(p1).
