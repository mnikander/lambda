grammar A_Normal_Form

entry _Block:
    '{' (lines+=_Let)* tail=_Tail '}';

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
An example of ANF written in ML-style code:


{
    let adder =
    {
        let constant = 37 in
        + constant
    } in
    let apply  = lambda f {f 5} in
    let answer = apply adder in
    answer
}


Here is a more sophisticated example, which show-cases the use of branching
control flow, in the tail position of a sub-block:


{
    let adder =
    {
        let is_positive = < 0 in
        let predicate   = is_positive 1 in
        if predicate
        then
        {
            let constant = 37 in
            + constant
        }
        else
        {
            - 5
        }
    } in
    let apply  = lambda f {f 5} in
    let answer = apply adder in
    answer
}


Note that the following example is INVALID code.
It does satisfy the grammar, but the 'body' expression uses an undefined variable 'f'.
When 'f' is undefined, the expression '(f 5)' is does not represent a Value.
'f' is only introduced in the lambda in the subsequent line.

{
    let adder =
    {
        let constant = 37 in
        + constant
    } in
    let body   = f 5 in
    let apply  = lambda f {body} in
    let answer = apply adder in
    answer
}


{
    let adder  = {
        let is_positive = < 0 in
        let condition = is_positive 1 in
        if condition then {+ 37} else {- 5}
    } in
    let apply  = lambda f {f 5} in
    let answer = apply adder in
    answer
}



*/
