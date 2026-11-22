:- use_module(library(lists), [append/3]).

% expression(+Numbers, -Tree, -Value) holds when Tree uses Numbers in order
% and evaluates to the integer Value with only exact, nonzero-divisor divisions.
expression([Number], num(Number), Number).
expression(Numbers, op(Op, Left, Right), Value) :-
    LeftNumbers = [_|_],
    RightNumbers = [_|_],
    append(LeftNumbers, RightNumbers, Numbers),
    expression(LeftNumbers, Left, LeftValue),
    expression(RightNumbers, Right, RightValue),
    ( Op = '+',
      Value is LeftValue + RightValue
    ; Op = '-',
      Value is LeftValue - RightValue
    ; Op = '*',
      Value is LeftValue * RightValue
    ; Op = '/',
      RightValue =\= 0,
      0 is LeftValue mod RightValue,
      Value is LeftValue // RightValue
    ).

% format_expression(+Tree, -String) holds when String is the canonical rendering
% of Tree.
format_expression(Tree, String) :-
    format_expression(Tree, 0, String).

% format_expression(+Tree, +MinPrecedence, -String) holds when String renders
% Tree with parentheses around an operator below MinPrecedence.
format_expression(num(Number), _, String) :-
    format(string(String), '~d', [Number]).
format_expression(op(Op, Left, Right), MinPrecedence, String) :-
    expression_precedence(Op, Precedence),
    % The right operand needs strictly higher precedence to omit parentheses.
    RightMinPrecedence is Precedence + 1,
    format_expression(Left, Precedence, LeftString),
    format_expression(Right, RightMinPrecedence, RightString),
    ( Precedence < MinPrecedence ->
        format(string(String), '(~s~a~s)', [LeftString, Op, RightString])
    ; format(string(String), '~s~a~s', [LeftString, Op, RightString])
    ).

% expression_precedence(+Op, -Precedence) holds when Precedence is Op's
% binding strength, with larger numbers binding more tightly.
expression_precedence('+', 1).
expression_precedence('-', 1).
expression_precedence('*', 2).
expression_precedence('/', 2).

% generate_equation(+List, -Equation) holds when Equation joins two expressions
% that use List's numbers in order and evaluate to the same integer.
generate_equation(List, Equation) :-
    LeftNumbers = [_|_],
    RightNumbers = [_|_],
    append(LeftNumbers, RightNumbers, List),
    expression(LeftNumbers, Left, Value),
    expression(RightNumbers, Right, Value),
    format_expression(Left, LeftString),
    format_expression(Right, RightString),
    format(string(Equation), '~s=~s', [LeftString, RightString]).

% all_equations(+List, -Equations) holds when Equations is the sorted list of
% all distinct valid equation strings for List.
all_equations(List, Equations) :-
    findall(Equation, generate_equation(List, Equation), Generated),
    sort(Generated, Equations).

% count_equations(+List, -N) holds when N is the number of distinct valid
% equations for List.
count_equations(List, N) :-
    all_equations(List, Equations),
    length(Equations, N).
