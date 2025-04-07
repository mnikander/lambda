# Core and Extensions

The language consists of a core feature set and a number of possible optional extensions.

## Core Features

The core feature set of the language is deliberately kept small, to keep the implementation effort in reasonable bounds:

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

## Optional Language Extensions

The entire set of envisioned language features is documented in the table of type [signatures](signatures.md).
Several headings divide these features into groups.
The first several headings describe the core features of the language, and subsequent headings describe the extensions.

This distinction is made so that an interpreter or transpiler for the core is relatively easy to implement.
Instead of trying to implement everything at once, individual coding projects can use a core and focus just one of these Extensions.
That keeps the scope of individual projects small and allows experimenting with different language features and ways of implementing them.
Each individual project documents which parts of the language it implements.

---
**Copyright (c) 2025 Marco Nikander**

