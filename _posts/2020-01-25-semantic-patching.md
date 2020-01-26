---
title: "Semantic Patching with Coccinelle"
last_modified_at: 2020-01-21
comments: true
categories:
  - blog
tags:
  - papers
  - research
---

Changing existing code in a software program is one of the most common things
software programmers do in their day to day jobs. For a well maintained piece of
code such as the Linux kernel the frequency of changes could be quite high, and
pervasive changes touching a more than double digit source files are not that
rare.

[Patch](https://en.wikipedia.org/wiki/Patch_(computing))[^diffutils] is a set of
changes to a program. Patches, as shown in the following example, contains `+`
indicating lines which are to be added and `-` indicating lines which are to be
removed. Patches could be applied not just to source code, but also for data and
configuration files as well.

```diff
@@ -247,7 +247,7 @@ u32 method_id, const struct acpi_buffer *in, struct acpi_buffer *out)
 	block = &wblock->gblock;
 	handle = wblock->handle;
 
-	if (!block->flags & ACPI_WMI_METHOD)
+	if (!(block->flags & ACPI_WMI_METHOD))
```

This patch, which is an actual bug fix in acpi drivers[^acpi-bug], is fixing a
subtle precendence issue with with the `!` operator when uesd with bitwise
operators. The intent here is to check if it is not an `ACPI_WMI_METHOD`, but
the original experession `(!block->flags & ACPI_WMI_METHOD)` is buggy. A simple
fix is to parenthesise the whole expression so that we do negatiion _after_ all
bitwise operations, and that's exactly what the above patch does in a
_speciffic_ source location as indicated in the preamble, which is the section
between `@@` symbols, of the patch.

In a kernel with millions of lines of code there high chance that bugs of
similar nature will be present in more than one file or function. Fixing such
bugs manually would be would be quite tedious since it is not even simple to
identify all the places where there are similar issues. It is not that simple to
write even a grep expression to find all such cases since simple source code
search does not take into account C expressions and statements at a semantic
level.

To generalise this patch to apply to all boolean checks following this pattern
of usage we need to capture the semantics of intent of the change. That's where
_semantic patches_ comes in.

## Semantic patches

Semantic patches are a generalisation on the patches which captures the change
at an intent level going beyond the source level. 

Let's quickly examine how to express the semantic intent of the above (raw)
patch. To fix this particular class of bugs what we want to do is to recognise
source code in matching,

```c
!Expression & Constant
```

To transform code to following form,
```c
!(Expression & Constant)
```

Here, _expression_ and _constant_ have precise semantics in the C language[^c-standard].

## Coccinelle

[Coccinelle](http://coccinelle.lip6.fr/) is a program matching and
transformation tool which applies semantic patches to C source code. This tool
started its life as a patching tool for Linux kernel drivers, but now has been
extended and improved to be used in any kind of C program.

In Coccinelle a semantic patch is given by the [SmPL Patch
language](https://web.imt-atlantique.fr/x-info/coccinelle/docs/index.html). A
SmPL patch for the above change can be written as follows[^acpi-bug],

```diff
@@
expression E;
constant C;
@@
- !E & C
+ !(E & C)
```

At a high level it is easy to see what we are trying to accomplish here. First
we are interesting an expression which we capture with variable `E` and then we
are also interested in a constant after the (literal) bitwise `&` operation
which we captuer as `C`. Then other parts of the SmPL patch is similar to the
original source level patch we showed before. In the semantic patch we
substiture variables to make the patch generic and location independent. Thus
the SmPL patch can be applied to _any_ instance of this bug occurring in various
source files.

A SmPL patch is designed to mimic a raw patch from a syntactic standpoint so
that it is easy to see what the patch intends to accomplish.

### Semantic patching pipeline

When it comes to C programs Coccinelle transformations are applied as follows.

- Processes C source code files one at at time ignoring header files.
- In a source file, Coccinelle then applies the rules on a C function level.
- Processing of a function is based on _control-flow_ graph. This allows
  Coccinelle to be precisely detect early returns from a function, for example.

### Limitations of Coccinelle approach

I think what made Coccinelle successful is the focus on what it is *not* as much
as what it _is_. Concretely, it does not try, 
- To be a static analysis tool - Coccinelle does not do alias analysis or other dataflow analysis.
- Only best case support for type inference - Coccinelle by default does not
  process headers and thus does not have complete type information.
- Lenient and fast parsing

There are other optimisations which Coccinelle does to make it a usable and
pragmatic tool used by possibly hundreds (or thousands?) of developers.
Coccinelle has been quite successful in making an impact on Linux kernel
development. Over 6000 commits mention Coccinelle in their commit
messages[^coccinelle-java]. This paper, [Coccinelle: 10 Years of Automated
Evolution in the Linux Kernel](https://hal.inria.fr/hal-01853271/document) to
get a perspective on Coccinelle's evolution and impact on Linux kernel
development in the last 10 years.

## Coccinelle for Java

Coccinelle4J[^coccinelle-java] is a project on applying the techniques learnt
from a decade of research and engineering on transforming C programs, to Java
programs. Even though syntactically C and Java belong to the same family,
advanced type system brings its own challenges.

I was quite impressed when I learned about Coccinelle and its impact on the
evolution on the Linux kernel and I would like to end the this post with a quote
from a Linux kernel developer[^coccinelle-lwn],

> Coccinelle is one of those schizophrenic projects situated on the boundary between academic research and practical software development.

## Footnotes

[^diffutils]: [GNU diffutils - Comparing and Merging Files](https://www.gnu.org/software/diffutils/manual/)
[^acpi-bug]: Examples are from - [Inside the mind of a Coccinelle programmer](https://lwn.net/Articles/698724/)
[^c-standard]: [C Standard](http://www.iso-9899.info/wiki/The_Standard)
[^coccinelle]: Main citation for Coccinelle
[^coccinelle-10-years]: [Coccinelle: 10 Years of Automated Evolution in the Linux Kernel](https://hal.inria.fr/hal-01853271/document)
[^coccinelle-java]: [Semantic Patches for Java Program Transformation](https://drops.dagstuhl.de/opus/volltexte/2019/10814/pdf/LIPIcs-ECOOP-2019-22.pdf)
[^coccinelle-lwn]: [Semantic patching with Coccinelle](https://lwn.net/Articles/315686/)
