# Memory Model

To avoid the runtime overhead of garbage collection, this language will use a memory model inspired by Rust.
This language has pure functions only, which allows several simplifications to be made to the memory model.
Most notably, the complete absence of mutable references simplifies the borrowing rules.
A new construct, the 'destructive update' is introduced alongside the destructive move.
Destructive update allow in-place updates for performance-critical code, while maintaining the paradigm of immutable data.

## Four ways to pass data

1. deep copy
2. read-only reference
3. destructive move
4. destructive update

This set of operations provides clear semantics, simplifies lifetime analysis, and (hopefully) allows lifetime annotations to be avoided altogether.
The following sections explain each operation.
Note that code examples are provided, but the syntax is not final and is subject to change.
These code examples do illustrate the underlying concepts, however.

### Deep Copy

Creates a copy of a location in memory.
For an aggregate data structure, each component is recursively copied, all the way down to the primitive data types.
This is expensive but offers simple and clear semantics.
It avoids any and all issues with shared ownership of data.

```
(let x 5
(let y (copy x)
(+ x y
)))
```

### Read-Only Reference

Creates an alias to an existing location in memory.
This alias can only be used to read the data.
A reference has a different _type_ than the data it is refering to, it is a pointer/reference type.
As long as references to a particular location in memory exist, it is an error for that memory location to be destroyed, destructively moved, or destructively updated.

References will _probably_ be the default way in which data is passed around within the code, so that the keyword `reference` can be omitted when programming.

References can be created to data which is not stored in memory, such as inlined constants or functions which reside in the source-code.
For primitive types such as integers, for example, data may actually be copied under the hood, since that is faster than creating and dereferencing a pointer.
What happens under the hood is not relevant for the language user, however.
From the outside, a reference will always behave as if it's a read-only handle at some data or function.

```
(let x 5
(let y (reference x)
(+ x y
)))
```

Note: given that inlined constants functions can be referenced as well, and a variety of implementation techniques are used under the hood by the compiler, it may be a good idea to call this an 'alias', 'handle', or 'borrow'.
Making a clear distinction between this construct and the 'references' which people know from most other programming languages, may help avoid confusion.

### Destructive Move

Transfers the ownership of a location in memory from one symbol to another.
After the move, the old symbol is no longer defined.

```
(let x 5
(let y (move x)
(+ x y                 # error: x is undefined, x was moved
)))
```

```
(let x 5
(let y (move x)
(+ y y
)))
```

### Destructive Update

Similar to move, it transfers the ownership of a location in memory from one symbol to another.
While that memory location is being transfered to the new symbol, the data in that memory location is updated.
Just as with destructive move, the old symbol is no longer defined.
This allows in-place updates of large data-structures, though the modified data is bound to a newly created symbol.
Semantically and conceptually, this is consistent with the notion of immutable data, since the old symbol can no longer be used.

```
(let x 5
(let y (update x 4)
(+ x y                 # error: x is undefined, x was updated
)))
```

```
(let x 5
(let y (update x 4)
(+ y y
)))
```

## Thoughts and Questions

A clear distinction between symbols and references is needed.
A symbol can be moved or updated, a reference cannot be.
Can symbols ever be passed into a function, or do they always go into a function via one of the four passing strategies?
How are temporary values (rvalues) handled in all of this?
When you write a symbol somewhere, how does the compiler know whether it should pass that symbol along (for example for copy, reference, move, update), or if the compiler should dereference that symbol and retrieve a temporary value (rvalue)?
How are stack and heap-based values treated consistently?
How can references for inlined constants and functions be implemented?

---
**Copyright (c) 2025 Marco Nikander**
