# 'Iterate Until' combinator

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
       (-> i (== i 10))
       (-> i (begin (print i) (+ i 1) end)))
```

If the language provides `until` as a primitive, all other iterative algorithms could be expressed in terms of `until`.
This includes algorithms such as map, filter, reduce, and countless others.

This primitive can be implemented in C++, for example, as follows:

```c++
// apply the update function to the state repeatedly until the condition is met
template <typename S, typename C, typename U>
S until(S state, C condition, U update){
    while (condition(state) == false) {
        state = update(std::move(state));
    }
    return state;
};
```
