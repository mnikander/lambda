grammar Lambda

entry Model:
    ast=Expression;

Expression:
    value=(Atom | Identifier | Call | List);

Atom:
    value=(NumberLiteral | BooleanLiteral | StringLiteral | TypeLiteral);

Call:
    '(' func=Expression (arguments+=Expression)* ')';

List:
    '[' (entries+=Expression)* ']';

Identifier:
    value=(ID | '==' | '!=' | '+' | '-' | '*' | '/' | '%' |
          '<' | '>' | '<=' | '>=' | '&' | '|' | '!' |
          'if' | 'conditional' | 'until' |
          '->' | 'fn' | 'lambda' | 'let' | '^' |
          ':' | 'List' | 'head' | 'tail' | 'Variant' | 'Tuple' | 'Array' |
          'display' | 'copy' | 'move' | 'lend'
          );

NumberLiteral:
    value=(INT | FLOAT);

BooleanLiteral:
    value=('True' | 'False');

StringLiteral:
    value=STRING;

TypeLiteral:
    value=('Type' | 'Empty' | 'Unit' | 'Boolean' | 'Byte' | 'Ascii' | 'I8' | 'I16' | 'I32' | 'I64' | 'F32' | 'F64');

hidden terminal WS: /\s+/;
hidden terminal SL_COMMENT: /\#[^\n\r]*/;
terminal ID: /[_a-zA-Z][\w_]*/;
terminal INT returns number: /[0-9]+/;
terminal FLOAT returns number: /[-+]?((\d+\.\d*)|(\d*\.\d+))/;
terminal STRING: /"(\\.|[^"\\])*"|'(\\.|[^'\\])*'/;
