grammar Lambda

entry _Expression:
    (_Atom | _Lambda | _Let | _If | _Call | _List);

_Atom:
    (_Identifier | _NumberLiteral | _BooleanLiteral | _StringLiteral);

_Lambda:
    '(' 'lambda' binding=_Identifier body=_Expression ')';

_Let:
    '(' 'let' binding=_Identifier value=_Expression body=_Expression ')';

_If:
    '(' 'if' condition=_Expression then_br=_Expression else_br=_Expression ')';

_Call:
    '(' func=_Expression (arguments+=_Expression)* ')';

_List:
    '[' (entries+=_Expression)* ']';

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
