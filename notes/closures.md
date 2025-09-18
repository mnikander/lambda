# Functions and Closures

Should there be a distinction between simple functions and closures?
This question is relevant both for the semantics of the language, as well as the actual implementation of the language.

## Lambda Calculus, Functions, and Closures

Two places where closures can be necessary, are:
1. when we have functions which return other functions, and
2. when we have functions which take other functions as arguments

The first case is actually everywhere.
Say we have a lambda function such as:
```
Lambda a b -> a + b
```
Then we can Curry that function to:
```
Lambda a -> Lambda b -> a + b
```

We now have the outer lambda which returns  the inner lambda.
Does this mean that we need closures _everywhere_?

## It's All About the Arguments

The lambda itself doesn't really know or care if it is a function or a closure under the hood..
Whether a simple funciton is sufficient, or whether we need a closure, which has its own persistent storage, depends on _how we supply the arguments_.
There are several cases:

1. a lambda function is provided with **none** of the arguments => **a function is sufficient**
2. a lambda function is provided with **all** the arguments, we can evaluate it immediately to compute a value => **a function is sufficient**
3. a lambda function is provided with **some**, but not all, of the required arguments (i.e. partial application), and...
    - A. ... all of the provided arguments are literals or functions-of-literals => **a function is sufficient**
    - B. ... at least one of the provided arguments is a dynamic (runtime) value which lives on the heap or stack => **a closure is necessary**

Say we wanted to add '1' to each value in an array [0, 1, 2, 3].
This is an example of case **3A**:
```
(map (+ 1) [0 1 2 3])
```

Now, say that we wanted to add an `offset`, some value which is only available at runtime.
This is an example of case **3B**:
```
(map (+ addOffset) [0 1 2 3])
```

In the `(+ addOffset)`, we need to store the fact that we are calling `+` with the runtime value of `offset`.
To do this, we need to store at least a reference to `offset`, which means we need a closure.
Note: Under the hood, we have to store a pointer to memory here, that is different from a literal which is baked into the source code.

## Explicit Syntax for Closures

So: a lambda is just a lambda.
How we supply the arguments, and what sort of values those arguments are, decides whether or not we truly need a closure.
From this standpoint, it may actually make sense to distinguish these two cases syntactically.

There are several reasons why an explicit distinction in the syntax makes sense:
- It is clear to the user whether that 'callable thing' is a simple function or a closure, since the user had to make that decision explicitly. That makes debugging easier.
- If the compiler secretly made the decision whether or not to use a closure, the user may have to debug what the compiler selected and why. That could be confusing. 
- Compared to a simple function, A closure costs extra runtime and/or memory. For performance-oriented code it is advantageous if costs are visible and avoidable.
- The compiler is told upfront what properties it must verify: for functions it must verify that case 1, 2, or 3A is present, and for closures it must perform borrow-checking.

There is also the question of what a closure should close over.
It could capture:
- the entire environment
- only those variables which are actually used
- only what it is _told_ to capture

C++ and Rust both take the third approach.
We want to empower the user to choose the best memory allocation strategy for their use-case.
This means we want to enable them to reference, copy, or move values into data structures and closures.
Having a syntax to capture variables explicitely would give us that fine-grained control.
It also fits well into the mental model that the creation of a closure is really just an another way of doing function application.
Rust uses `| |` as a new type of parentheses, for closures.
Adopting this syntax, we could rewrite the example from above as:

```
(map |+ offset| [0 1 2 3])
```

The default behavior of the language will probably be to pass arguments by immutable-reference.
Thus, the above would create a closure with a immutable _reference_ to the variable `offset`.
If we wanted to copy or move the `offset` into the closure, and thereby store the value inside the closure, we could write:

```
(map |+ (move offset)| [0 1 2 3])
```

If we wanted to heap-allocate that storage, i.e. place it inside a 'box', we could write:

```
(map |+ (box (copy offset))| [0 1 2 3])
```

Here too, the user must actively choose to store something on the heap.
The call stack is usually in cache, while heap data may or may not be in cache.
Memory allocation on the heap (`malloc`) is also expensive.
So we won't heap allocate unless the user says so explicitly, even for closures.


## Problematic Cases

Say we again want to add an `offset`, which is a runtime value, a each element in an array.
This time we do that a little differently, however:

```
(let
    addOffset
    (lambda x |+ offset x|)
    (map addOffset [0 1 2 3])
)
```

Now we have a closure `|+ offset x|` inside of a lambda.
This would probably force the outer `(lambda x ...)` to also be a closure, though we haven't even applied the argument to it.
This breaks the idea that 'a lambda is just a lambda, the application of the arguments decides whether or not it's a closure'.
So should the above code be forbidden?
If so, what implications does that have?

Rewriting it, so that the closure is on the outside, is easy enough:
```
(let
    addOffset
    |(lambda a (lambda b (+ a b))) offset|
    (map addOffset [0 1 2 3])
)
```
It's more verbose, but it does get the job done.
Obviously, we could just have written `(map |+ offset| [0 1 2 3])` as before.
However, the `(lambda a (lambda b (+ a b)))` is really just a placeholder for _any_ function which we might have.
This case is relevant.
By writing the closure on the outside, and only 'pure lambdas' on the inside, the lambdas stay _ambivalent_ about whether they are part of a simple function or part of a closure.
Does the necessity of creating the closure on the outside, create fundamental problems for the language?

---
**Copyright (c) 2025 Marco Nikander**
