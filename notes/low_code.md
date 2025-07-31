# Low Code with an Expression-Only Language

If the language is an expression-only language, there is no machine state to keep track of.
That makes it practical to represent a program visually, and perhaps to create a graphical editor for the language.
Ideally, this would not require any additional constructs for components or wires, but would just be a direct visual representation of the AST for a program.
It would be helpful if procedure/function names are displayed, and a representation as a high-level block diagram can is available.
Deciding how and where to group elements together into blocks, in an automated way, will be tricky.
The usefulness of the graphical representation will depend greatly on how well this automatic grouping works.
One way to do it, might be to group things together, to which the programmer has assigned a name.
For example:

```
(let add (lambda x (lambda y (+ x y))) (add 2 3))
```

Here the programmer has deliberately assigned a function name `add` to the the function.
It's probably a good idea to display it like this:

```
  add
 /   \
2     3
```

and then allow the user to click on `add` to see its definition.

So let-bindings are an obvious cue that things should be grouped together, in the graphical representation.

Let-bindings and lambda abstractions (function definitions) are very similar.
Does it make sense to group every function definition as well, irrespective of whether it has a name or not?
In unary lambda calculus, do you then group each inner function as well?
I feel like that makes for awful readability.
The short-hand, for multi-argument functions, makes a lot more sense for grouping though.
For example:

```
(lambda [x y] (+ x y))
```

could be sensibly be displayed as one group/block.

If the language allows both unary and n-ary functions, and the transformation to unary functions happens under the hood, then perhaps it makes sense to display each function as its own block.
If the programmer chooses to express a function as an n-ary function, then it's one block.
If the programmer chooses to express his code as several nested functions, then each one of those is a block.

Perhaps the simplest solution though, is to only group let-bindings.
That is explicit, and requires no heuristics which try to guess what is grouped together into a block, and what isn't.
