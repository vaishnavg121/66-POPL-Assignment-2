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
