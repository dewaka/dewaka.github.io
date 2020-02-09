---
title: "Rust Cookbook"
last_modified_at: 2020-02-09
comments: true
categories:
  - blog
tags:
  - rust
---

[Rust](https://www.rust-lang.org/) is quite an exciting programming language
from two points of views for me. On one hand there's strong influence from
functional programming lanugages, such as OCaml, in Rust to feel like an
expression oriented language with pattern matching[^rust-patterns], algebraic
data types[^rust-enums] etc.

Then there's also the focus on zero cost abstractions[^zero-cost-abstractions]
in Rust which makes it possible to be competitive with C/C++ when it comes to
performance[^techempower]. Even though C++ is no longer a stagnant language,
Rust is increasing a very good option already where former is dominating
currently, at the very least for greenfield projects.

Thus playing with and learning Rust has been in the back of my mind for quite
some time now and I thought of documenting recipes and simple solutions to
practical programming problems on the way in the form for a
[Gitbook](https://www.gitbook.com/), mostly for my own reference.

I plan to go about the task of writing recipes based two approaches. One is to
follow other well received cookbooks, 
such as [Python Cookbook](http://shop.oreilly.com/product/0636920027072.do), and think about
solving those problems _in_ Rust in an idiomatic way. Then also I would like to
focus on aspects of writing high performant and reliable backend services in
Rust - the types of which Java or Go is used (at my current full time work, for
example).

Wiki book is published at <https://rust-book.dewaka.com>. All code and source files
for the book are [open source](https://github.com/dewaka/rust-notebook) and PRs
are welcome for any inaccuracies or improvements.

--------

[^rust-patterns]: [Rust Pattern matching](https://doc.rust-lang.org/book/ch18-03-pattern-syntax.html)
[^rust-enums]: [Rust Enums](https://doc.rust-lang.org/book/ch06-01-defining-an-enum.html)
[^zero-cost-abstractions]: [Zero Cost Abstractions](https://boats.gitlab.io/blog/post/zero-cost-abstractions/)
[^techempower]: Round 18 of [TechEmpower Web Framework Benchmarks](https://www.techempower.com/benchmarks/#section=data-r18&hw=ph&test=fortune)
