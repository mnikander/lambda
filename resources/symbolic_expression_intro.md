# Introduction to Symbolic Expressions
Here is a basic example of a [symbolic expression](https://en.wikipedia.org/wiki/S-expression) which computes computes `1 + 2`:
```lisp
(+ 1 2)
```
Symbolic expressions are written in prefix-notation, i.e. Polish notation, so the name of the function, in this case `+` is written first.
The function name is followed by its arguments, separated by spaces.
The entire expression is enclosed by parentheses, to ensure it is absolutely clear which arguments belong to which function.
This also means that the order of execution is made explicit, instead of relying on precedence rules.
For a mathematical expression such `1 + 2 * 3`, the usual precedence rule is to compute multiplication before addition.
In a symbolic expression, the order of execution is explicit:
```lisp
(+ 1 (* 2 3))
```

If we want to print something to the console, we can write:
```lisp
(display 42)
```

We can use a ternary if-expression to do branching.
Say we wanted to check a condition, `1 > 0`, and if this condition is true we want to print "All good", and otherwise we want to print "Something is wrong".
We could implement this as follows:
```lisp
(display
    (if (> 1 0)
        "All good"
        "Something is wrong"))
```

We can create anonymous functions, lambda functions, as follows:
```lisp
(lambda a (+ a 1))
```
The 'lambda' or 'arrow' function `->` is an inbuilt function which _creates a new function_.
The created function takes an argument `a` and returns the value `a + 1`.
The newly created function is anonymous, i.e. it does not have a name.
This lambda function takes an argument and returns a value.
Given a lambda, we can:
1. provide it an argument value and evaluate it immediately
2. pass it into a higher-order function such as map
3. assign it a name and use it later via a `let`-binding
4. assign it a name using `define`, iff we are inside an imperative context such as a `do` block

Here is an example of creating and immediately invoking a lambda:
```lisp
(-> a (+ a 1) 2)
```
This creates a takes the value of `a` and returns `a` + 1.
The value `2` is passed into this lambda function, so this whole expression evaluates to a `3`.

We can use the keyword `let` to assign names to values, types, and functions, within a context.
For example to create a variable named `x` with the value `5` inside a specific context:
```lisp
(let x 5 (display x))
```
This defines the variable x, inside of the expression `(display x)`.
In C-code, this would be the same as writing:

```C
// equivalent code in C
{
    int x = 5;
    printf("%d", x);
}
// notice that the entire block is enclosed in braces
// which limit the scope of the variable definition x
// to just this block
```

In a similar manner, we can assign a name to a function.
We could assign the function, from the examples above, the name `successor` and then call the function using that name:
```lisp
(let successor (lambda x (+ x 1)) (successor 2))
```
...which evaluates to 3.

---
**Copyright (c) 2025 Marco Nikander**

