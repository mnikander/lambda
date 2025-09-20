# Core Features

The language core encompasses the following:

 1. Config to run and debug the toolchain in an IDE
 2. Unit testing from expression to result
 3. Lexer
 4. Parser
 5. Rudimentary semantic analysis (see below)
 6. Evaluation of nested expressions
 7. Output of integers and booleans
 8. Arithmetic and Logic
 9. Functions and Variable Bindings

Items 1-7 contain the basic infrastructure and functionality for the interpreter or compiler.
The semantic analysis must verify the arity of function calls and that identifiers are unique and defined before use.
Items 8-9 contain the special forms and built-in functions which make up the language.
More details on those language features can be found in the first few sections of the table of type [signatures](signatures.md).

The core feature set of the language is deliberately kept small, to keep the implementation effort in reasonable bounds.
It will probably be extended slightly over time, especially with regard to the type system.

---
**Copyright (c) 2025 Marco Nikander**
