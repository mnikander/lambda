# A Minimal Grammar for Lisp

This grammar is written in Augmented Backus-Naur Form (ABNF).

```abnf
expression   = atom / "(" expression "." expression ")" / list
list         = "(" expression *expression ")"
atom         = letter character
character    = space / letter character / digit character
letter       = "a" / ... / "z" / "A" / ... / "Z"
digit        = "0" / ... / "9"
space        = " "
```

## Sources
- Lisp BNF: https://iamwilhelm.github.io/bnf-examples/lisp
- ABNF: https://www.ietf.org/rfc/rfc5234.txt
