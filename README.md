# Lambda Language Definition

The syntax of a lambda language are outlined here.
It is defined via its [grammar](grammar.md) and the type [signatures](signatures.md) of its in-built functions.
Design decisions are documented in a [decision log](decisions.md).

The grammar uses Lisp-style symbolic expressions so that the syntax is homogeneous and easy to parse.
The language consists of a core feature set and a number of possible extensions.

## Core Features

The core feature set of the language is deliberately kept small, to keep the implementation effort within reasonable bounds:

1. Config to run and debug the toolchain in an IDE
2. Unit testing from expression to result
3. Lexer
4. Parser
5. Output of integers and booleans
6. Evaluation of a nested expression
7. Arithmetic and Logic
8. Control Flow
9. Functions and Variables

Items 1-6 contain the basic infrastructure and functionality for the interpreter or compiler.
Items 7-9 contain the actual language features.

The core feature set will probably be extended slightly over time, especially with regard to the type system.

## Language Extensions

Language features are documented via their type [signatures](signatures.md).
Several headings divide these features into groups.
The first several headings describe the core features of the language.
Subsequent headings describe possible extensions.

The goal is that an interpreter or transpiler for the core is relatively easy to implement.
Instead of trying to implement everything at once, an individual project could consist of the Core and just one of these Extensions.
That keeps the scope of individual projects small and allows experimenting with different language features and ways to implement them.
Each individual project documents which parts of the language it implements.

## Implementation Projects

The following repositories implement part of this lambda language:

1. [Interpreter](https://github.com/mnikander/interpreter)
2. [Transpiler](https://github.com/mnikander/transpiler)

---
**Copyright (c) 2025 Marco Nikander**

