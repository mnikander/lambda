# Lisp-Like Grammar

This grammar is written in Augmented Backus-Naur Form (ABNF).
Note that this grammar supports only unary functions, and three special forms: `lambda`, `let`, and `if`.

```abnf
expression      =  (atom / call / lambda / let / if ) [comment]
atom            =  identifier / number-literal / boolean-literal / string-literal
call            =  "(" [sp]             expression sp expression               [sp] ")"
lambda          =  "(" [sp] "lambda" sp identifier sp expression               [sp] ")"
let             =  "(" [sp] "let"    sp identifier sp expression sp expression [sp] ")"
if              =  "(" [sp] "if"     sp expression sp expression sp expression [sp] ")"
```

## Comments, Identifiers, and Literals

```abnf
comment         =  "#" *(character / q / qq)
identifier      =  (special *special) / (letter *(letter / digit))
number-literal  =  [sign] digit *digit ["." digit *digit]
boolean-literal =  "True" / "False"
string-literal  =  (q *(character / qq) q) / (qq *(character / q) qq)
sp              =  (space / linebreak) *(space / linebreak)
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

