# Names and their Meaning

Defining a name or symbol to have a certain meaning is one of the fundamental building blocks of programming.
In most programming languages, there are at least eight different categories of what the usage of a name can refer to.
Typically this is implicit and a programmer must infer it from the context.

## 1. Name binding or manipulation
- create, (re-)assign, or destroy a variable/parameter binding

Examples:
- variable declaration
- variable definition (i.e. let binding)
- function arguments
- pattern matching
- end-of-scope or destructor call
- destructive move
- shadowing

## 2. Namespace or module
- a name which is a container for other names (i.e. std::vector or math.sqrt)

## 3. Value retrieval
- using the name to retrieve the associated value from memory
- note that this could be a compound name such as `point.x`

## 4. Storage location
- take the memory address where the data is stored

## 5. Function invocation
- treat the name as a callable and execute it
- jump to a location in the assembly, create a stack frame, and store the return address

## 6. Jump target
- jump to a location in the assembly

## 7. Symbolic substitution
- compile-time inlining
- thunks in call-by-name or call-by-need languages

## 8. Type
- using a name to refer to a type, not a value
- typically has a compile-time meaning only
