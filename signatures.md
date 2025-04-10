# Type Signatures of the Built-In Functions

| name                         | symbols                      | example                                              | inputs                           | outputs              | comments |
| :---                         | :---                         | :---                                                 | :---                             | :---                 | :--- |
|                              |                              |                                                      |                                  |                      | |
| **[core](core.md) Arithmetic and Logic** |                  |                                                      |                                  |                      | |
| Equality, Inequality         | `==` `!=`                    | `(== a b)`                                           | T, T                             | Boolean              | |
| Arithmetic                   | `+` `-` `*` `/` `%` `^`      | `(+ a b)`                                            | (ensure T Number), (ensure T Number) | Number           | |
| Comparison                   | `<` `>` `<=` `>=`            | `(< a b)`                                            | (ensure T Number), (ensure T Number) | Boolean          | |
| Logical                      | `&` `\|` | `(& a b)`         | Boolean, Boolean                                     | Boolean                          |                      | |
| Negation                     |  `!` | `(! a b)`             | Boolean                                              | Boolean                          |                      | |
|                              |                              |                                                      |                                  |                      | |
| **[core](core.md) Control Flow** |                          |                                                      |                                  |                      | |
| Branching                    | `if`                         | `(if true 42 0)`                                     | Boolean, T0, T1                  | (Variant T0 T1)      | ternary if-expression |
| Recursion via fix            | `fix`                        | `(fix (* x f(x (- x 1))) 5)`                         | (F,T)→T, T                       | T                    | fixed-point combinator **TODO** prototype this in the interpreter and transpiler |
|                              |                              |                                                      |                                  |                      | |
| **[core](core.md) Functions and Variables** |                         |                                                      |                                  |                      | |
| Lambda functions             | `lambda` or `->`             | `(lambda [a b] (+ 1 (+ a b))`                        | (List Identifier), Expr          | T0, ..., Tn → U      | creates and returns an anonymous function, note that `lambda` and `->` are identical, it is a matter of preference |
| Let binding                  | `let`                        | `(let x 5 (display x))`                              | Identifier, Expr, Expr           | Expr                 | |
|                              |                              |                                                      |                                  |                      | |
| **Primitive IO**             |                              |                                                      |                                  |                      | |
| Display / print              | `display`                    | `(display 42)`                                       | T                                | Unit (?)             | |
|                              |                              |                                                      |                                  |                      | |
| **Enhanced Control Flow**    |                              |                                                      |                                  |                      | |
| Conditional                  |  `conditional`               | `(conditional [(> 1 0) "good"] [(<= 1 0) "broken"])` | [Boolean, T0] ... [Boolean, Tn]  | (Variant T0 ... Tn)  | lisp-style conditional expression, can be used to imitate pattern-matching and switch-case statements |
| Iteration                    | `until`                      | `(until 0 (lambda x (== x 10)) (lambda (+ x 1)))`    | (Tuple T0 ... Tn), (Tuple T0 ... Tn)→Boolean, (Tuple T0 ... Tn)→(Tuple T0 ... Tn) | (Tuple T0 ... Tn) | Until the input tuple satisfies a predicate, iteratively update it by applying a projection to it. Once the condition is satisfied, return the final tuple. |
|                              |                              |                                                      |                                  |                      | |
| **Enhanced Functions**       |                              |                                                      |                                  |                      | |
| Variadic lambda functions    | `...`                        | `(let sum (lambda [a ...rest] (foldl + a rest) (sum 1 2 4 8 16))` | T...                | (List T)             | |
|                              |                              |                                                      |                                  |                      | |
| **Imperative**               |                              |                                                      |                                  |                      | |
| Sequential block             | `do`                         | `(until expression_0 ... expression_n)`              | T0 ... Tn                        | Tn                   | evaluate a series of expressions in order
| Declaration                  | `declare`                    | `(declare x I32)`                                    | Identifier, Type                 | Unit (?)             | |
| _... Declaration (cont.)_    |                              | `(declare add (Function [I32 I32] I32))`             |                                  |                      | |
| Definition                   | `define`                     | `(define x 5)`                                       | Identifier, Expr                 | Unit (?)             | |
|                              |                              |                                                      |                                  |                      | |
| **List**                     |                              |                                                      |                                  |                      | **TODO** Should the list be homogeneous or heterogeneous? I need one homogeneous and one heterogeneous datatype (list, tuple, array) Maybe an inbuilt heterogeneous List is the best foundation |
| List constructor             | `list`                       |                                                      |                                  |                      | like `cons` in Scheme |
| Get first element of list    | `head`                       |                                                      |                                  |                      | like `car` in Scheme |
| Get rest of list             | `tail`                       |                                                      |                                  |                      | like `cdr` in Scheme |
| Check if a list is empty     | `empty`                      |                                                      |                                  |                      | like `null?` in Scheme |
| Destructuring / let-binding  |                              |                                                      |                                  |                      | **TODO** should I overload `let` for this? |
| Mutate / modify a list       | `mutate`                     | `(mutate 2 (move ['A' 'B' 'oops' 'D']) 'C')`         | Integer, (Linear (List T)), T    | (List T)             | **TODO** should I allow a setter which allows modification operations which maintain acyclicity? The setter would be _linear_, i.e. require a destructive move of the original list |
|                              |                              |                                                      |                                  |                      | |
| **Tuple**                    |                              |                                                      |                                  |                      | |
| Constructor                  | `tuple`                      | `(tuple ['a' 5 True])`                               | T0, ..., Tn                      | (Tuple T0 ... Tn)    | |
| Get (?)                      | `get`                        |                                                      | Integer, (Tuple T0 ... Tn)       | Tx                   | It could be made to access the elements using the type, i.e. `(get I32 tup)` so a type-checker can verify if the tuple has exactly one I32 in it and if so, get returns that one |
| At                           | `at`                         |                                                      | Integer, (Tuple T0 ... Tn)       | (Result Tx)          | Checks bounds, returns error if out-of-bounds |
| Destructuring / let-binding  |                              |                                                      |                                  |                      | **TODO** should I overload `let` for this? |
|                              |                              |                                                      |                                  |                      | |
| **Array / Vector**           |                              |                                                      |                                  |                      | |
| Constructor                  | `array`                      | `(array [1 2 3 4])`                                  |                                  |                      | Static array, with a fixed value type and fixed size |
| Get (?)                      | `get`                        | `(get 0 (array [1 2 4 8]))`                          | Integer, (Array T N)             |                      | Direct access, no bounds-checking. **TODO** Can I secure this with dependent type information? Should I clamp the index access? Or should I just allow direct unchecked access for maximum performance? |
| At                           | `at`                         | `(at 0 (array [1 2 4 8]))`                           |                                  | (Result T)           | Checks bounds, returns error if out-of-bounds |
| Destructuring / let-binding  |                              |                                                      |                                  |                      | **TODO** should I overload `let` for this? |
|                              |                              |                                                      |                                  |                      | |
| **Variant**                  |                              |                                                      |                                  |                      | |
| Constructor                  | `variant`                    | `(variant [I32 String] 5)`                           | (List T0 ... Tn), T              | (Variant [T0 ... Tn]) | |
| Check the type               |                              |                                                      |                                  |                      | |
| Get                          | `get`                        |                                                      |                                  | T                    | This will require type-narrowing, as in TypeScript, so it can be used effectively with if- and conditional-expressions without the type-checker throwing errors |
|                              |                              |                                                      |                                  |                      | |
| **Dictionary**               |                              |                                                      |                                  |                      | Fixed value type and key type (they can be a variant-type) |
| Constructor                  | `dictionary`                 | `(dictionary [['hello' 'world'] ['foo' 'bar']])`     | (List (List K T0) ... (List K Tn)) | (Dictionary [K T0] ... [K Tn]) | |
| Get (?)                      | `get`                        | `(get 'foo' (dictionary [['foo' '0'] ['baz' 42]]))`  | K, (Dictionary K V)              | V                    | **TODO** is this a good idea, or just too unsafe? In a const-eval context it would be good to have, to model objects, but otherwise it's probably too dangerous |
| At                           | `at`                         | `(at 'foo' (dictionary [['foo' 'bar'] ['baz' 2]])`   | K, (Dictionary K V)              | Result V             | **TODO** this might be improved with a dedicated notation for _pairs_, which in not `[]`, or a dedicated syntax for dictionaries `{}`. Perhaps that could also be used for function signatures |
|                              |                              |                                                      |                                  |                      | |
| **Function Overloading**     |                              |                                                      |                                  |                      | |
| Function overloading         | `overload`                   | `(overload add [I32 add_i32] [F32 add_fl])`          | Identifier, [T0 Function], ..., [Tn Function] | Expr    | similar to a let-binding? |
|                              |                              |                                                      |                                  |                      | |
| **Types**                    |                              |                                                      |                                  |                      | |
| Type annotation              | `:`                          | `(: I16 5)`                                          |                                  |                      | |
| _... Type annotation (cont.)_|                              | `(: (Function [I32 I32] I32) (lambda [a b] a))`      |                                  |                      | |
| Type retrieval               | `typeof`                     | `(typeof (+ 5 5))`                                   |                                  |                      | |
| Memory size of type          | `sizeof`                     | `(sizeof I32)`                                       |                                  |                      | |
| Linear type                  | `Linear`                     | `(Linear I32)`                                       | T                                | (Linear T)           | Creates a linear type |
|                              |                              |                                                      |                                  |                      | |
| **Modules**                  |                              |                                                      |                                  |                      | |
| Module                       | `module`                     |                                                      |                                  |                      | **TODO** check how Scheme does this! ... I want something similar to Python here, i.e. explicit module names, not implicit ones like in JavaScript/TypeScript |
| Import                       | `import`                     |                                                      |                                  |                      | **TODO** check how Scheme does this! ... It could be done similar to let-binding |
| Export                       | `export`                     |                                                      |                                  |                      | **TODO** check how Scheme does this! ... It this will probably be some sort of list of key-value pairs, consisting of identifiers and their associated expressions |
|                              |                              |                                                      |                                  |                      | |
| **Monads**                   |                              |                                                      |                                  |                      | |
| Inverse composition          | `pipe`                       | `(pipe value function_0 ... function_n)`             | T0, T0→T1, ... , Tm→Tn           | Tn                   | take a value, apply the first function to it, take that intermediate result, apply the 2nd function to it, and so on
| Monadic bind                 | `bind` `>>=`                 | `(>>= (just 5) (lambda x (x / 5)))`                  | (Monad T0), T0→T1, ..., Tm→Tn    | (Monad Tn)           | takes a monadic value and a series of non-monadic functions, passes the monadic value through those functions, and returns the monadic result
|                              |                              |                                                      |                                  |                      | |
| **Algebraic Effecs**         |                              |                                                      |                                  |                      | |
| C function call              | `syscall`                    | `(syscall pr [a] (Function I32 Unit SysEffect) "printf(a);")`  | Identifier, (List Identifier), [T0 ... Tn]→[U SysEffect], String | [T0 ... Tn]→U | similar to a `lambda` expression, except that it creates an algebraic effect which requests the execution of a C-function **TOOD:** how do users specify `#include` statements so they can include their own C-functions? |
| State                        |                              |                                                      |                                  |                      | |
| Logging                      |                              |                                                      |                                  |                      | |
| Memory alloc/free (?)        |                              |                                                      |                                  |                      | |
|                              |                              |                                                      |                                  |                      | |
| **Memory**                   |                              |                                                      |                                  |                      | |
| Copy                         |                              |                                                      |                                  |                      | |
| Move                         |                              |                                                      |                                  |                      | Destructive move. All functions which modify data, require the variable to be destructively moved into the modification function. This is consistent with immutability and prevents race-conditions. |
| Borrow                       |                              |                                                      |                                  |                      | This creates a const reference to a variable, its lifetime is verified at compile-time to ensure it is not destroyed (or destructively moved) while the reference exists. Prevents dangling-references. |
| Box    (?)                   |                              |                                                      |                                  |                      | Creates a unique pointer which holds data on the heap and allows only a single owner (i.e. a linear variable). **TODO** perhaps this should be the default and not an extra command? |
| Shared (?)                   |                              |                                                      |                                  |                      | Creates a shared pointer which holds data on the heap and uses reference counting to free the data |
|                              |                              |                                                      |                                  |                      | |
| **Interfaces**               |                              |                                                      |                                  |                      | **TODO** |
| Interface definition         |                              |                                                      |                                  |                      | Defines a type-class or function interface |
| Type constraint              | `ensure`                     | `(ensure T Number)`                                  | T, Typeclass                     | T                    | The type-checker enforces this constraint. Throws a compile-time type-error if this check fails |
|                              |                              |                                                      |                                  |                      | |
| **Generics**                 |                              |                                                      |                                  |                      | **TODO** |
| **Memory**                   |                              |                                                      |                                  |                      | **TODO** |
|                              |                              |                                                      |                                  |                      | |

---
**Copyright (c) 2025 Marco Nikander**

