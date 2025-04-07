# Core Features

The core language features are:

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
More details on those language features can be found in the first few sections of the table of type [signatures](signatures.md).

The core feature set of the language is deliberately kept small, to keep the implementation effort in reasonable bounds.
It will probably be extended slightly over time, especially with regard to the type system.

---
**Copyright (c) 2025 Marco Nikander**
