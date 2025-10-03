grammar Inspired_by_ANF

entry _Block:
    '{' (lines+=_Let)* tail=_Tail '}';

_Let:
    'let' binding=_Identifier '=' value=_Atomic 'in';

_Tail:
    _Atomic | _Complex;

_Atomic:
    _Literal | _Identifier | _Block | _UnaryLambda | _UnaryCall;

_Complex:
    _If;

_Literal:
    _NumberLiteral | _BooleanLiteral | _StringLiteral;

_UnaryLambda:
    'lambda' binding=_Identifier body=_Block;

_UnaryCall:
    '(' func=_Atomic arguments=_Atomic ')';

_If:
    'if' condition=_Atomic 'then' then_br=_Block 'else' else_br=_Block;

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
An example of a language inspired by ML, Scheme, and ANF.
The overall syntax is inspired by ML.
Like ANF it forces control flow constructs to be in the tail position.
ANF would require that everything is be decomposed into let-bindings with atomic expressions on the right hand side.
Unlike ANF, this language it allows nesting of expressions, similar to Scheme.


{
    let adder =
    {
        let constant = 37 in
        (+ constant)
    } in
    let apply  = lambda f { (f 5) } in
    let answer = (apply adder) in
    answer
}


Here is a more sophisticated example, which show-cases the use of branching
control flow, in the tail position of a sub-block:


{
    let adder =
    {
        let condition = ((< 0) 1) in
        if condition then
        {
            let constant = 37 in
            (+ constant)
        }
        else
        {
            (- 5)
        }
    } in
    let apply  = lambda f { (f 5) } in
    let answer = (apply adder) in
    answer
}


It can be compacted to:


{
    let adder =
    {
        if ((< 0) 1)
        then { lambda x {x} }
        else { (- 5) }
    } in
    let answer = (lambda f { (f 5) } adder) in
    answer
}


*/
