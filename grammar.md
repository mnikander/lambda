# A-Normal Form Grammar

A program written in A-Normal Form (ANF) consists of blocks, where each block constists of zero or more let-bindings followed by exactly one tail expression.
Only simple atomic expressions or function calls are allowed on the right-hand side of let-bindings.
A tail expressions may be an atomic expression, function call, or complex control flow.

This grammar is expression-only, there are currently no mechanisms for state or other effects.
Furthermore, the grammar is strictly unary.
Function definitions and function calls have exactly one argument.
Built-in functions, such as `+`, are treated like any other identifier.

Note: the grammar is written in Augmented Backus-Naur Form (ABNF).

```abnf
block           =  "(" *let tail ")"
let             =  "let" variable "=" atomic_or_call "in"
lambda          =  "lambda" variable block
if              =  "if" atomic "then" block "else" block
tail            =  atomic_or_call / complex
complex         =  if
atomic_or_call  =  atomic [atomic]
atomic          =  literal / reference / lambda / block;
```

## Comments, Identifiers, and Literals

```abnf
variable        =  identifier
reference       =  identifier
identifier      =  (special *special) / (letter *(letter / digit))
literal         =  boolean-literal / number-literal / string-literal
number-literal  =  [sign] digit *digit ["." digit *digit]
boolean-literal =  "True" / "False"
string-literal  =  (q *(character / qq) q) / (qq *(character / q) qq)
ws              =  (space / linebreak) *(space / linebreak)
comment         =  "#" *(character / q / qq)
```

## Characters and Digits

```abnf
character       =  letter / digit / parenthesis / special / space
letter          =  "_" / "a" / ... / "z" / "A" / ... / "Z"
digit           =  "0" / ... / "9"
sign            =  "+" / "-"
parenthesis     =  "(" / ")" / "[" / "]" / "{" / "}"
special         =  "." / "," / ":" / ";" / "!" / "?" / "<" / ">" / "@" / "#" / "$" /
                   "+" / "-" / "*" / "/" / "%" / "=" / "&" / "|" / "^" / "~"
space           =   " " / "\t"
linebreak       =  "\n" / "\r\n"
q               =  `'`
qq              =  `"`
```

## Sources
- Lisp BNF: https://iamwilhelm.github.io/bnf-examples/lisp
- ABNF: https://www.ietf.org/rfc/rfc5234.txt

---
**Copyright (c) 2025 Marco Nikander**
