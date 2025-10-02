grammar Lambda

entry Expression:
    (Atom | Call | List);

Atom:
    (Identifier | NumberLiteral | BooleanLiteral | StringLiteral);

Call:
    '(' func=Expression (arguments+=Expression)* ')';

List:
    '[' (entries+=Expression)* ']';

Identifier:
    value=(ID | OP);

NumberLiteral:
    value=(INT | FLOAT);

BooleanLiteral:
    value=('true' | 'false');

StringLiteral:
    value=STRING;

hidden terminal WS: /\s+/;
hidden terminal SL_COMMENT: /\#[^\n\r]*/;
terminal ID: /[_a-zA-Z][\w_]*/;
terminal OP: /[!?<>\=\@\#\$\+\-\*\/\%\&\|\^\~]+/;
terminal INT returns number: /[0-9]+/;
terminal FLOAT returns number: /[-+]?((\d+\.\d*)|(\d*\.\d+))/;
terminal STRING: /"(\\.|[^"\\])*"|'(\\.|[^'\\])*'/;
