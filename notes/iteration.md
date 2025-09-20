# Recursion and Iteration

Structured programming requires three primitives to create the set of all control flows:
- sequence (execute one block after another)
- selection (depending on a condition, execute block A or block B)
- iteration (execute a block until a certain condition is met)

Typically, functional programming languages implement control flow via branching and recursion.
Lambda calculus does not include recursion directly, since the functions are anonymous.
A fixed-point combinator, i.e. `fix`, can be used to allow recursion in lambda calculus, however.
On a real machine, recursion can incur runtime overhead though, due to the creation of a new stack frame with each function call.
Deeply-nested recursion can cause stack overflows.

If the language guarantees that the tail call optimization (TCO) is performed, stack overflows and runtime performance penalties can be avoided.
Only some recursive functions are tail recursive though.
This may leave the task of avoiding stack overflows up to the programmer, which is unfortunate.

Iteration on the other hand, is fast and does not risk overflowing the stack.
Pure functional languages typically don't have for-loops or while-loops, however.
This is because for/while-loops are stateful operations.

There are some ways to support iteration, even in a purely functional language.
Algorithms such as _map_, _filter_, and _reduce_ can be provided as language primitives, and other algorithms can be expressed in terms of them.

## 'Iterate Until' combinator

Another possibility is the 'iterate until' combinator.
The Haskell standard library contains this combinator.
We will refer to this combinator as 'until', and give it the following form:

```lisp
(until state
       stoppingCondition
       updateFunction)
```
The first argument is the initial state passed into the until combinator.
The second argument is the stopping condition, which takes the current state and returns true when it is time to terminate the iteration.
The third argument is the update function, which takes the current state and returns the next state.

If we do allow an effectful function `print` which outputs numbers to the display, then the following function would print the numbers 0, ..., 9 and return the value 10:

```lisp
(until 0
       (lambda a (== a 10))
       (lambda b (begin (print b) (+ b 1) end)))
```

If the language provides `until` as a primitive, all other iterative algorithms could be expressed in terms of `until`.
This includes algorithms such as map, filter, reduce, and countless others.

This primitive can be implemented in C++, for example, as follows:

```c++
// apply the update function to the state repeatedly until the condition is met
template <typename S, typename C, typename U>
S until(S state, C condition, U update) {
    while (condition(state) == false) {
        state = update(std::move(state));
    }
    return state;
};
```

## Cycle

The 'iterate until' combinator feels weird to use in practice.
It is similar to a do-while loop, which is rare in most C++ codebases, for example.
Adding to the confusion, it has a stopping condition, rather than a condition to keep going.
This is the inverse of what most programmers are used to, with `for` and `while` loops.
We can build on the idea from the previous section, but stay closer to the for-loop.

```lisp
(cycle state condition update)
```
A second really important question is: what do we return at the end?
Do we return the last state for which the condition was successful, or do we return the current state once it has failed the check?
This is similar to the distinction between while and do-while loops.
The first case is a bit trickier to implement, and may be slower, because we have to store the previous state.
We will take the second approach.
The example from above, printing [0, 9] and then returning 10 could be implemented as:

```lisp
(cycle 0
       (lambda a (< a 10))
       (lambda b (begin (print b) (+ 1 b) end)))
```

Note that if we have partial function application we can also just write:
```lisp
(cycle 0
       (< 10)
       (lambda b (begin (print b) (+ 1 b) end)))
```

The C++ implementation of `cycle` is almost identical to the implementation for `until`.

```c++
// apply the update function to the state repeatedly until the condition is met
template <typename S, typename C, typename U>
S cycle(S state, C condition, U update) {
    while (condition(state)) {
        state = update(std::move(state));
    }
    return state;
};
```
The while-loop inside the implementation clearly shows we are using a condition in the way most programmers are used to.
The implementation of 'until' inverts the condition, and is more similar to a termination condition for a recursion.
