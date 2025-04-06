grammar FirstLambda

entry Model:
    ast=Expression;

Expression:
    value=(Atom | Call | List);

Atom:
    value=(Identifier | NumberLiteral | StringLiteral | TypeLiteral);

Call:
    '(' func=Expression (arguments+=Expression)* ')';

List:
    '[' (entries+=Expression)* ']';

Identifier:
    value=(ID | '==' | '!=' | '+' | '-' | '*' | '/' | '%' | '^' | 'sqrt' |
          '<' | '>' | '<=' | '>=' | '&' | '|' | '!' | '->' | 'lambda' |
          'if' | 'conditional' | 'until' | 'do' | '|>' | '>>=' |
          'display' | 'declare' | 'define' | ':' |
          'List' | 'head' | 'tail' | 'Variant' | 'Tuple' | 'Array' |
          'copy' | 'move' | 'lend'
          );

NumberLiteral:
    value=(INT | FLOAT);

StringLiteral:
    value=STRING;

TypeLiteral:
    value=('Type' | 'Empty' | 'Boolean' | 'Byte' | 'Ascii' | 'I8' | 'I16' | 'I32' | 'I64' | 'F32' | 'F64');

hidden terminal WS: /\s+/;
hidden terminal SL_COMMENT: /\#[^\n\r]*/;
terminal ID: /[_a-zA-Z][\w_]*/;
terminal INT returns number: /[0-9]+/;
terminal FLOAT returns number: /[-+]?((\d+\.\d*)|(\d*\.\d+))/;
terminal STRING: /"(\\.|[^"\\])*"|'(\\.|[^'\\])*'/;
