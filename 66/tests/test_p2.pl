:- ensure_loaded('../code/66_q2.pl').

:- begin_tests(p2).

% handout_equations(-Numbers, -Equations) holds for each exact example in P2.
handout_equations([4,2,5,3],
                  ["4*2-5=3", "4*2=5+3", "4-2=5-3", "4/2=5-3",
                   "4=2*(5-3)", "4=2+(5-3)", "4=2+5-3"]).
handout_equations([2,3,4], []).
handout_equations([2,4,8], ["2*4=8"]).

% format_case(-Tree, -Expected) holds for each canonical example and a leaf.
format_case(op('*', op('+', num(4), num(2)), num(3)), "(4+2)*3").
format_case(op('+', num(4), op('*', num(2), num(3))), "4+2*3").
format_case(op('*', op('/', num(8), num(4)), num(2)), "8/4*2").
format_case(op('/', num(8), op('*', num(4), num(2))), "8/(4*2)").
format_case(op('-', op('-', num(1), num(2)), num(3)), "1-2-3").
format_case(op('-', num(1), op('-', num(2), num(3))), "1-(2-3)").
format_case(op('+', num(1), op('+', num(2), num(3))), "1+(2+3)").
format_case(op('+', op('+', num(1), num(2)), num(3)), "1+2+3").
format_case(num(123), "123").

test(all_equations_handout,
     [forall(handout_equations(Numbers, Expected)), true(Actual == Expected)]) :-
    all_equations(Numbers, Actual).

test(generate_handout_strings,
     [forall(handout_equations(Numbers, Expected)), true(Actual == Expected)]) :-
    findall(Equation, generate_equation(Numbers, Equation), Generated),
    maplist(string, Generated),
    sort(Generated, Actual).

test(generate_fails_without_error,
     [forall(member(Numbers, [[], [7], [2,3,4]])), fail]) :-
    generate_equation(Numbers, _).

test(zero_divisor_tree, [fail]) :-
    expression([6,0], Tree, _),
    Tree == op('/', num(6), num(0)).

test(zero_divisors_in_equations, [true(Equations == ["6*0=0"])]) :-
    all_equations([6,0,0], Equations).

test(nested_inexact_division_tree, [fail]) :-
    expression([7,2,3], Tree, _),
    Tree == op('/', op('/', num(7), num(2)), num(3)).

test(nested_inexact_division_in_equations, [fail]) :-
    generate_equation([7,2,3,1], Equation),
    Equation == "7/2/3=1".

test(negative_intermediate) :-
    once((generate_equation([2,1,3,0,1], Equation),
          Equation == "2/(1-3)=0-1")).

test(zeros, [true(Equations == Expected)]) :-
    all_equations([0,0,0], Equations),
    Expected = ["0*0=0", "0+0=0", "0-0=0", "0=0*0", "0=0+0", "0=0-0"].

test(repeated_numbers_preserve_distinct_shapes) :-
    all_equations([1,1,1,3], Equations),
    memberchk("1+(1+1)=3", Equations),
    memberchk("1+1+1=3", Equations),
    sort(Equations, Equations).

test(format_expression,
     [forall(format_case(Tree, Expected)), true(Actual == Expected)]) :-
    format_expression(Tree, Actual).

test(count_agrees_with_all_equations,
     [forall(member(Numbers, [[], [7], [4,2,5,3], [2,3,4], [2,4,8],
                              [6,0,0], [7,2,3,1], [0,0,0], [1,1,1,3]])),
      true(Count == Expected)]) :-
    all_equations(Numbers, Equations),
    length(Equations, Expected),
    count_equations(Numbers, Count).

:- end_tests(p2).
