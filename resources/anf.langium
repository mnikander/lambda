/*
A-Normal Form

    An example of an A-Normal Form (ANF) inspired by ML and Scheme.
    ANF consists of blocks of zero or more let-bindings, followed by one mandatory expression.
    That final expression in a block is called the 'tail'.
    Let bindings can bind to literals, variables, blocks, unary lambda expressions, and unary function calls.
    Blocks can be nested.
    Control flow constructs such as if-then-else, loop, try-catch, perform-handle, are ONLY allowed in the tail position.
    The resulting language is an A-Normal Form, with syntax that is a blend of ML-style let-bindings and nested blocks that can look like Scheme code.
    All function definitions and function applications are unary, so they bind and apply exactly one argument.
    No enclosing parentheses are needed, though if they are inside a block it may _appear_ as though parentheses are enclosing a function creation or application.
    All functions are anonymous functions as in lambda calculus.

 */

grammar A_Normal_Form

entry _Block:
    '(' (lines+=_Let)* tail=_Tail ')';

_Let:
    'let' binding=_Identifier '=' value=_Atomic 'in';

_Tail:
    _Atomic | _Complex;

_Atomic:
    _Literal | _Identifier | _Block | _UnaryLambda | _UnaryCall;

_Primitive:
    _Literal | _Identifier | _Block;

_Complex:
    _If;

_Literal:
    _NumberLiteral | _BooleanLiteral | _StringLiteral;

_UnaryLambda:
    'lambda' binding=_Identifier body=_Block;

_UnaryCall:
    func=_Primitive arguments=_Primitive;

_If:
    'if' condition=_Primitive 'then' then_br=_Block 'else' else_br=_Block;

_Identifier:
    value=(ID | OP);

_NumberLiteral:
    value=(INT | FLOAT);

_BooleanLiteral:
    value=('true' | 'false');

_StringLiteral:
    value=STRING;

hidden terminal WS: /\s+/;
hidden terminal SL_COMMENT: /\#[^\n\r]*/;
terminal ID: /[_a-zA-Z][\w_]*/;
terminal OP: /[!?<>\=\@\#\$\+\-\*\/\%\&\|\^\~]+/;
terminal INT returns number: /[0-9]+/;
terminal FLOAT returns number: /[-+]?((\d+\.\d*)|(\d*\.\d+))/;
terminal STRING: /"(\\.|[^"\\])*"|'(\\.|[^'\\])*'/;

/* 
Examples:

(
    let adder =
    (
        let constant = 37 in
        (+ constant)
    ) in
    let apply  = lambda f ( (f 5) ) in
    let answer = (apply adder) in
    answer
)


The following example creates a multi-argument function using nested lambdas:


(
    let first   = lambda a ( lambda b (a) ) in
    let partial = first 1 in
    let answer  = partial 2 in
    answer
)


Interestingly, the nesting of blocks, where each block consists only of one expression without any prior let-bindings, results in code which looks exactly like Lisp/Scheme code.


(
    let first  = lambda a ( lambda b (a) ) in
    ((first 1) 2)
)


Here is a more sophisticated example, which show-cases the use of branching
control flow, in the tail position of a sub-block:


(
    let adder =
    (
        let is_positive = < 0 in
        let condition   = is_positive 1 in
        if condition
        then
        (
            let constant = 37 in
            + constant
        )
        else
        (
            - 5
        )
    ) in
    let apply  = lambda f ( f 5 ) in
    let answer = apply adder in
    answer
)


It can be compacted to:


(
    let adder =
    (
        let is_positive = < 0 in
        let condition   = is_positive 1 in
        if condition
        then ( + 37 )
        else ( - 5 )
    ) in
    let apply  = lambda f ( f 5 ) in
    let answer = apply adder in
    answer
)


*/
