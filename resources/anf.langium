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
    '('? func=_Primitive arguments=_Primitive ')'?;

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
An example of an A-Normal Form inspired by ML and Scheme.
The overall syntax is inspired by ML.


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


The following example creates a multi-argument function using nested lambdas:
    

{
    let first   = lambda a {lambda b {a}} in
    let partial = (first 1) in
    let answer  = (partial 2) in
    answer
}


Here is a more sophisticated example, which show-cases the use of branching
control flow, in the tail position of a sub-block:


{
    let adder =
    {
        let is_positive = < 0 in
        let condition   = is_positive 1 in
        if condition
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
    let apply  = lambda f { f 5 } in
    let answer = apply adder in
    answer
}


It can be compacted to:


{
    let adder =
    {
        let is_positive = < 0 in
        let condition   = is_positive 1 in
        if condition
        then { + 37 }
        else { - 5 }
    } in
    let apply  = lambda f { f 5 } in
    let answer = apply adder in
    answer
}


*/
