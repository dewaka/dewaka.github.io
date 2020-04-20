---
title: "Emacs Custom Compilation"
last_modified_at: 2020-04-20
comments: true
categories:
  - blog
tags:
  - emacs
---

One of the convenient things I quite like about Sublime Text is the easy to
setup build system[^sublime-build]. It is pretty easy to add a custom build
setup with Sublime Text, to compile a single C++17 source file, for example. 
Once configured it is very efficient and keyboard friendly to compile and run a 
C++ program with a single key press, `F7` with default key bindings.

This blog post is about how to configure Emacs in a similar vein. 

The use case I had in mind was to configure Emacs to compile and run single file C++ programs without having to write a `Makefile`. It is pretty easy to invoke shell commands within Emacs, so if you have a build setup with `make` and the like, it is not difficult to to build and run programs within Emacs. However, what I wanted was to build and run one off C++ source files. 

<!-- I had a simple question - how can I have a simple single file build system for
Emacs, similar to what I have with Sublime Text.

After some research and trial and error, I figured out the use of `custom-compile` command.
 -->
<!-- I had to do some research to get a similar setup for compiling -->

## Compile Command

Emacs compile command to the rescue[^compile-command]!

Default compile command for C/C++ mode is `make -k`, which is _not_ what I want in this case. Compile command can be customised on a per-mode basis.

Following is the compile command I configured for compiling one off C++ source files. This command builds and runs C++ source files based on the current buffer name. For our purposes, buffer name is equivalent to the file name of the C++ source file.

```elisp
(add-hook 'c++-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 (format "g++ -std=c++17 -Wall %s -o a.out && ./a.out" (shell-quote-argument (buffer-name))))))
```

Once setup up, to compile the current source file you are editing can be accomplished by invoking `compile` command in Emacs (`M-x compile`).

Since the compile command is differentiated based on the mode it is bound to,
you can have custom compilation systems for different programming languages.

## Per-file (or per-directory) customisation

Pretty cool thing about the `compile-command` is that it can be set and
customised on a per-file basis, using Emacs file variables[^file-variables].



```cpp
// Local Variables:
// compile-command: "g++ -std=c++11 -Wall A.cpp -o a.out && ./a.out"
// End:
```

Make sure to quote compile command as a string.

Similar customisations can be applied on a directory basis with `.dir-local.el` files[^dir-local].

Emacs customiability reminds me of following xkcd[^butterfly]!

![Real Programmers](https://imgs.xkcd.com/comics/real_programmers.png "xkcd - Real Programmers")

## References

[^sublime-build]: [Sublime Build System](https://www.sublimetext.com/docs/3/build_systems.html)
[^compile-command]: [Emacs manual - Running compilation under Emacs](https://www.gnu.org/software/emacs/manual/html_node/emacs/Compilation.html)
[^file-variables]: [Emacs manual - Local Variables in Files](https://www.gnu.org/software/emacs/manual/html_node/emacs/File-Variables.html#File-Variables)
[^dir-local]: [Emacs manual - Per-Directory Local Variables](https://www.gnu.org/software/emacs/manual/html_node/emacs/Directory-Variables.html#Directory-Variables)
[^butterfly]: [Real Programmers](https://xkcd.com/378/)

