---
title: "Vim selection piping"
last_modified_at: 2021-02-28
comments: true
categories:
  - blog
tags:
  - vim
---

In this post I would like to show a Vim[^evil-mode] trick I use often to do some
repetitive editing tasks in a programmatic way.

This is best explained by discussing an example. Think that you have a long list
of values with duplicates and your task is to remove the duplicates and get the
set of unique values. 

In my case, this kind of editing requirement is something which frequently comes
up at work with data analysis queries. Often the values might come from a CSV,
Excel sheet, or other source.

## Using POSIX tools

If the order of the items do not matter, using `sort` and `uniq` tools is the
fastest way to get the desired output.

- Visual select the lines you want to remove duplicates from,
  ```
  gxazwcayu8BeY
  ZXDzrsfZtpwXm
  gxazwcayu8BeY
  ZXDzrsfZtpwXm
  VXAtmdTPRUjUp
  ZXDzrsfZtpwXm
  gxazwcayu8BeY
  ZXDzrsfZtpwXm
  VXAtmdTPRUjUp
  VXAtmdTPRUjUp
  VXAtmdTPRUjUp
  ```

- Run the following command on selection in Vim command mode,
  ```
  :'<,'>!sort|uniq
  ```

- Selected lines from the first step should be replaced with following output,
  ```
  VXAtmdTPRUjUp
  ZXDzrsfZtpwXm
  gxazwcayu8BeY
  ```

## Using Python

As can be seen from the output of the previous command, the order of the items
in the list gets mangled when you use the `sort` command. This is where some
creative use of inline Python[^lang] can be used to fix that.

Here's an example of a script I'd usually write to remove duplicates while
preserving order. Since this is just a demonstration of a Vim trick, I'm not
going to explain too much on the Python code itself, but this inline script has
to make sure following things are taken care of,
- Capture the text into a string - `s = """`. Python multi-line
  strings[^string-literal] are ideal for this use case.
- Split the string into lines - `s.split()`
- Remove duplicate lines - `set(l.rstrip() for l in s.split())`[^python-set-order]
- Print the unique lines to standard out - `print('\n'.join(set(l.rstrip() for l in s.split())))`

The important thing to keep in mind that the _output_ from the command is what
Vim _replaces_ the text with. Hence why the text transformation script need to
print to stdout.

With Vim it is pretty easy to undo(`u`) and experiment to get the
transformation you are looking for.

Here are all the steps,

- Write an inline script and visual select the whole area,
  ```python
  s = """
  gxazwcayu8BeY
  ZXDzrsfZtpwXm
  gxazwcayu8BeY
  ZXDzrsfZtpwXm
  VXAtmdTPRUjUp
  ZXDzrsfZtpwXm
  gxazwcayu8BeY
  ZXDzrsfZtpwXm
  VXAtmdTPRUjUp
  VXAtmdTPRUjUp
  VXAtmdTPRUjUp
  """
  print('\n'.join(set(l.rstrip() for l in s.split())))
  ```

- Run the following command on selection in Vim command mode,
  ```
  :'<,'>!python3
  ```

- Selected lines from the first step should be replaced with following output,
  ```
  gxazwcayu8BeY
  ZXDzrsfZtpwXm
  VXAtmdTPRUjUp
  ```

## Video demo

Here is a short demo of using the first method to remove duplicates from a long
list of items.

![Vim demo]({{ "assets/postassets/vim-selection-piping/vim-selection-piping.gif" | absolute_url }}){: .align-center }

--------------------

In summary, I find Vim selection piping to be a powerful technique when the
editing is of repetitive nature, but not too regular enough to write a macro. As
long as writing a short inline Python script is faster than writing a separate
script or a spreadsheet program when data is columnar, I find that Vim selection
piping is powerful enough for a lot of tasks.

--------------------

[^evil-mode]: Emacs [evil-mode](https://github.com/emacs-evil/evil) also supports this feature!
[^python-set-order]: Python set order can be implementation dependent.
[^lang]: This is not specific to Python. Any programming language with good string manipulation functions would do equally well here. 
[^string-literal]: https://docs.python.org/3/reference/lexical_analysis.html#string-and-bytes-literals
