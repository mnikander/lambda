# Lambda Language

The syntax of a lambda language are outlined here.
It is defined via its [grammar](grammar.md) and the type [signatures](signatures.md) of its in-built functions.
The grammar uses Lisp-style symbolic expressions so that the syntax is homogeneous and easy to parse.

The language consists of a core feature set and a number of possible extensions.

## Core Features

The core feature set of the language is deliberately kept small, to keep the implementation effort within reasonable bounds.

1. Lexer
2. Parser
3. Evaluation of integers and nested expressions
4. Basic output
5. Unit testing from symbolic expressions through evaluation
6. IDE config to run and debug the toolchain
7. Arithmetic and Logic
8. Control Flow
9. Functions

Items 1-6 contain the basic infrastructure and functionality for the interpreter or compiler.
Items 7-9 contain the actual language features.

The core feature set will probably be extended slightly over time, especially with regard to the type system.

## Language Extensions

The available language features are documented via their type [signatures](signatures.md).
Several headings divide the language features into groups.
The first few headings describe the core features of the language.
Subsequent headings describe possible extensions.

The goal is that an interpreter or transpiler for the core should be relatively easy to implement.
Instead of trying to implement everything at once, an individual project could consist of the Core and just one Extension.
It also keeps the scope of individual projects small and allows experimenting with different language features and different ways to implement them.

The documentation of each implementation project makes reference to the Core and which of these Extensions they implement.

## Implementation Projects

The following repositories implement part of this lambda language:

1. [interpreter](https://github.com/mnikander/interpreter)
2. [transpiler](https://github.com/mnikander/transpiler)
