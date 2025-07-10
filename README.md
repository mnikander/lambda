# A Lambda Language Specification

The syntax of a lambda language is specified here.
It uses Lisp-style symbolic expressions.
The language consists of a Core feature set and a number of optional Extensions.
The language is defined by:
1. a [grammar](grammar.md)
2. a set of [core](core.md) features
3. the type [signatures](signatures.md) of its built-in functions

The table of type signatures lists the Core functions as well as the functions for language Extensions.

## Implementation Projects

The following repositories implement part of this lambda language:

1. [Interpreter](https://github.com/mnikander/interpreter)
2. [Transpiler](https://github.com/mnikander/transpiler)

## Further Reading
- design decisions are documented in a [decision log](decisions.md)
- [introduction to symbolic expressions](resources/symbolic_expression_intro.md)
- proposal to use [iteration instead of recursion](notes/iteration.md) in a purely functional way
- proposal for a [memory model](notes/memory.md) without garbage collection, inspired by Rust

---
**Copyright (c) 2025 Marco Nikander**

