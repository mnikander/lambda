grammar A_Normal_Form

entry _Block:
    '{' (lines+=_Let)* tail=_Tail '}';

_Let:
    'let' binding=_Identifier '=' value=_Atomic 'in';

_Tail:
    _Atomic | _Complex;

_Atomic:
    (_Literal | _List | _Identifier | _UnaryLambda | _UnaryCall | _Block);

_Complex:
    _If;

_Literal:
    _NumberLiteral | _BooleanLiteral | _StringLiteral;

_List:
    '[' (entries+=_Atomic)* ']';

_UnaryLambda:
    '(' 'lambda' binding=_Identifier body=_Atomic ')';

_UnaryCall:
    '(' func=_Atomic arguments=_Atomic ')';

_If:
    'if' condition=_Atomic 'then' then_br=_Atomic 'else' else_br=_Atomic;

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
        (+ constant)
    } in
    let apply  = (lambda f (f 5)) in
    let answer = (apply adder) in
    answer
}


Here is a more sophisticated example, which show-cases the use of branching
control flow, in the tail position of a sub-block:


{
    let adder =
    {
        let predicate = ((< 0) 1) in
        if predicate then
        {
            let constant = 37 in
            (+ constant)
        }
        else
        {
            (- 5)
        }
    } in
    let apply  = (lambda f (f 5)) in
    let answer = (apply adder) in
    answer
}


*/
