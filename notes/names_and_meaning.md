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


# Another Perspective

Another way of looking at it is to distinguish between references into the AST and references to memory.
This covers most, but not all, of the cases outlined above.

1. AST references
- constants
- functions
- variable names

2. Storage references
- stack memory
- heap memory

Specifically namespaces/modules and types don't neatly fit into this scheme, though perhaps types can be fit into the AST references.

From this perspective, an interesting question.
Should objects in the AST, which are in the text and don't take up any dynamic memory, still support all the same operations as dynamic data located on the stack or heap?

| Operation | AST | Storage |
| --        | --  | --   |
| Reference | X   |  X   |
| Clone     |     |  X   |
| Move      |     |  X   |
| Destroy   |     |  X   |
| Update    |     |  X   |

---
**Copyright (c) 2025 Marco Nikander**
