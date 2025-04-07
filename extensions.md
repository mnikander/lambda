# Optional Language Extensions

The language consists of a [core](core.md) feature set and a number of optional extensions.
The entire set of envisioned language features is documented in the table of type [signatures](signatures.md).
Several headings divide these features into groups.
The first few headings describe the core features of the language, and subsequent headings describe the optional extensions.

This distinction is made so that an interpreter or transpiler for the core is relatively easy to implement.
Instead of trying to implement everything at once, individual coding projects can consist of an implementation of the core and just _one_ of these Extensions.
That keeps the scope of individual projects small.
This makes it easier to experiment with different language features and different ways of implementing them.

Each individual project makes reference to which version of the core and which extension(s) it implements.

---
**Copyright (c) 2025 Marco Nikander**

