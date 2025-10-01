# A Lambda Language

This small Scheme-like language is built using symbolic expressions.
All functions are unary, and partial application is supported.

<!-- to generate a pdf for monochrome printing: -->
<!-- pandoc summary.md -o summary.pdf --highlight-style=monochrome -V geometry:margin=1.5cm -->

## Special Forms and Built-in Functions

| symbols             | example                         | inputs                 // outputs       |
| :---                | :---                            | :---                                    |
|                     |                                 |                                         |
| **Special Forms**   |                                 |                                         |
| `( )`               | `(f 5)`                         | Expr => Expr, Expr     // Expr          |
| `let`               | `(let x 5 (display x))`         | Identifier, Expr, Expr // Expr          |
| `lambda`            | `(lambda a (lambda b (+ a b)))` | Identifier, Expr       // Expr → Expr   |
| `if`                | `(if true 42 0)`                | Boolean, A, B          // (Variant A B) |
|                     |                                 |                                         |
| **Arithmetic and Logic**|                             |                                         |
| `~`                 | `(~ a)`                         | Number                 // Number        |
| `!`                 | `(! a)`                         | Boolean                // Boolean       |
| `+  -  *  /  %`     | `(+ a b)`                       | Number, Number         // Number        |
| `==  !=`            | `(== a b)`                      | T, T                   // Boolean       |
| `<  >  <=  >=`      | `(< a b)`                       | Number, Number         // Boolean       |
| `|  &`              | `(& a b)`                       | Boolean, Boolean       // Boolean       |
|                     |                                 |                                         |
| **Recursion via Fix**|                                |                                         |
| `fix`               |                                 | ((F,A)=>B, A) => B, A  // B             |

## Grammar

This grammar is written in Augmented Backus-Naur Form (ABNF).
Note that this grammar is expression-only, has three special forms: `lambda`, `let`, and `if` and supports only unary functions.
Built-in functions, such as `+`, are treated like any other identifier.

```abnf
expression =  (atom / call / lambda / let / if ) [comment]
atom       =  identifier / binding / number-literal / boolean-literal / string-literal
call       =  "(" [sp]             expression sp expression               [sp] ")"
lambda     =  "(" [sp] "lambda" sp binding    sp expression               [sp] ")"
let        =  "(" [sp] "let"    sp binding    sp expression sp expression [sp] ")"
if         =  "(" [sp] "if"     sp expression sp expression sp expression [sp] ")"
```

The rest of the grammar can be found at: https://github.com/mnikander/lambda/blob/main/grammar.md

## Tokens

```typescript
type Token           = TokenBoolean | TokenNumber | TokenString | TokenIdentifier
                     | TokenOpen | TokenClose | TokenWhitespace;
type TokenBoolean    = { tag: 'Token', lexeme: 'BOOLEAN', id: number, offset: number, value: boolean }
type TokenNumber     = { tag: 'Token', lexeme: 'NUMBER', id: number, offset: number, value: number }
type TokenString     = { tag: 'Token', lexeme: 'STRING', id: number, offset: number, value: string }
type TokenIdentifier = { tag: 'Token', lexeme: 'IDENTIFIER', id: number, offset: number, value: string }
type TokenOpen       = { tag: 'Token', lexeme: 'OPEN', id: number, offset: number, value: '(' }
type TokenClose      = { tag: 'Token', lexeme: 'CLOSE', id: number, offset: number, value: ')' }
type TokenWhitespace = { tag: 'Token', lexeme: 'WHITESPACE', id: number, offset: number, value: string }
type Lexeme          = 'WHITESPACE' | 'OPEN' | 'CLOSE' | 'BOOLEAN' | 'NUMBER' | 'STRING' | 'IDENTIFIER';

const lexemes: Record<Lexeme, RegExp> = {
    'WHITESPACE': /^\s+/,
    'OPEN':       /^\(/,
    'CLOSE':      /^\)/,
    'BOOLEAN':    /^(true|false)/,
    'NUMBER':     /^[-+]?(?:\d*\.\d+|\d+\.\d*|\d+)/,
    'STRING':     /^"(\\.|[^"\\])*"|'(\\.|[^'\\])*'/,
    'IDENTIFIER': /^(?:([_a-zA-Z][_a-zA-Z0-9]*)|([.,:;!?<>\=\@\#\$\+\-\*\/\%\&\|\^\~]+))/,
};
```

## Nested AST

```typescript
type N_Expr       = N_Atom | N_Call | N_Lambda | N_Let | N_If;
type N_Atom       = N_Identifier | N_Binding | N_Boolean | N_Number | N_String;
type N_Boolean    = {id: number, tok: number, tag: 'N_Boolean', value: boolean};
type N_Number     = {id: number, tok: number, tag: 'N_Number', value: number};
type N_String     = {id: number, tok: number, tag: 'N_String', value: string};
type N_Identifier = {id: number, tok: number, tag: 'N_Identifier', name: string};
type N_Binding    = {id: number, tok: number, tag: 'N_Binding', name: string};
type N_Reference  = {id: number, tok: number, tag: 'N_Reference', target: string};
type N_Lambda     = {id: number, tok: number, tag: 'N_Lambda', bind: N_Binding, body: N_Expr};
type N_Let        = {id: number, tok: number, tag: 'N_Let', bind: N_Binding, value: N_Expr, body: N_Expr};
type N_If         = {id: number, tok: number, tag: 'N_If', cond: N_Expr, then_br: N_Expr, else_br: N_Expr};
type N_Call       = {id: number, tok: number, tag: 'N_Call', fn: N_Expr, arg: N_Expr};
```

## Flat AST

```typescript
type Id           = {id: number};
type F_AST        = F_Expression[];
type F_Expression = F_Literal | F_Identifier | F_Binding | F_Reference | F_Builtin
                  | F_Lambda | F_Let | F_If | F_Call;
type F_Literal    = {id: number, token?: number, tag: 'F_Literal', value: (boolean | number | string)};
type F_Identifier = {id: number, token?: number, tag: 'F_Identifier', name: string};
type F_Binding    = {id: number, token?: number, tag: 'F_Binding', name: string};
type F_Reference  = {id: number, token?: number, tag: 'F_Reference', target: Id};
type F_Lambda     = {id: number, token?: number, tag: 'F_Lambda', bind: Id, body: Id};
type F_Let        = {id: number, token?: number, tag: 'F_Let', bind: Id, value: Id, body: Id};
type F_If         = {id: number, token?: number, tag: 'F_If', cond: Id, then_br: Id, else_br: Id};
type F_Call       = {id: number, token?: number, tag: 'F_Call', body: Id, arg: Id};
type F_Builtin    = {id: number, token?: number, tag: 'F_Builtin',
    name: "==" | "!=" | "<" | ">" | "<=" | ">=" | "+" | "-" | "*" | "/" | "%" | "~" | "&&" | "||" | "!"
};
```

### Parsing Example: Identity Function

`((lambda x x) 42)`

This is the resulting AST, after parsing, flattening, and name resolution:

```typescript
const expected: F_Expression[] = [
    {id: 0, tok: 0, tag: 'F_Call', body: {id: 1}, arg: {id: 4}},
    {id: 1, tok: 1, tag: 'F_Lambda', bind: {id: 2}, body: {id: 3}},
    {id: 2, tok: 3, tag: 'F_Binding', name: 'x'},
    {id: 3, tok: 4, tag: 'F_Reference', name: 'x'},
    {id: 4, tok: 6, tag: 'F_Literal', value: 42},
];
```

### Example Parse: 'First' Function

((a, b => a) 1 2)

The function described above, selects the first of two arguments.
It can be written as:

`(((lambda a (lambda b a)) 1) 2)`

Resulting AST (token ids omitted, for brevity):

```typescript
const ast: F_AST = [
    {id: 0, tag: 'F_Call', body: {id: 1}, arg: {id: 8}},
    {id: 1, tag: 'F_Call', body: {id: 2}, arg: {id: 7}},
    {id: 2, tag: 'F_Lambda', bind: {id: 3}, body: {id: 4}},
    {id: 3, tag: 'F_Binding', name: 'a'},
    {id: 4, tag: 'F_Lambda', bind: {id: 5}, body: {id: 6}},
    {id: 5, tag: 'F_Binding', name: 'b'},
    {id: 6, tag: 'F_Reference', target: {id: 3}},
    {id: 7, tag: 'F_Literal', value: 1},
    {id: 8, tag: 'F_Literal', value: 2}
];
```
