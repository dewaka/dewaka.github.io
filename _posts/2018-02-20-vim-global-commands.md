---
title: "Vim Global Commands"
last_modified_at: 2018-02-20
tags:
  - vim
---

Global command<sup>[1](#vim-globals)</sup> is a very powerful, and a little
under-utilised command from my personal usage. Global command offers a powerful,
composable alternative to macros.

# Use cases

Usefulness of global commands is best explained through some practical examples.

## Using Vim global command to increment numbers

```xml
<inventory>
  <item>
    <name>Coffee</name>
    <price>230</price>
  </item>
  <item>
    <name>Sugar</name>
    <price>280</price>
  </item>
  <item>
    <name>Tea</name>
    <price>120</price>
  </item>
  ...
</inventory>
```

Let's say you have an XML file which looks as above, and you want to increase
the price of the items by 100 each. There are couple of ways to do this in Vim.
- Manually edit - this is the simplest and most straightforward way to go about
  this task, however it is not practical esp. if the file is a large one.
- Use Vim macros - this can be far more efficient than the editing manually.
  Vim macros are quite powerful and you can explicitly do that.
- Use multi-cursors<sup>[2](#vim-multi-cursors)</sup> - this is also a powerful
  option, might be more familiar to power users of Sublime Text, for example.
- Use a global command - see below!


Vim provides a way<sup>[3](#vim-inc-dec)</sup> to increment or decrement numbers
in a buffer, by pressing Ctrl+a and Ctrl+x, respectively. As with other commands
you can prepend such a command by a number to specify how many times it should
be repeated - thus, to increment a number 100 times, you will press `100Ctrl+a`
in normal mode.

What if there is a way to go to each price value, and repeat `100Ctrl+a`
command? Global command provides exactly, that capability as shown below.

```
:g/price/normal 100^A
```

Now all the prices in the file should be incremented by 100, as follows.

```
<inventory>
  <item>
    <name>Coffee</name>
    <price>330</price>
  </item>
  <item>
    <name>Sugar</name>
    <price>380</price>
  </item>
  <item>
    <name>Tea</name>
    <price>220</price>
  </item>
  ...
</inventory>
```

*Note* - we need to input Ctrl+A on the Vim command line, and to do that we need
to first press Ctrl+V followed by Ctrl+A.

General structure of a global command is `:<range>g/<pattern>/<command>`.
- range - is the usual Vim ranges which can be just a couple of lines or the
  whole buffer itself (as used above).
- pattern - can be powerful Vim regex. In the above example, we are just
  matching for lines which has the word "price", which is a crude match, but
  which works in this case.
- command - can be any *Ex* command, and in our example we have used normal
  command for incrementing numbers.

*Note* - For Emacs users out there who might be using evil mode for editing,
there is good news and bad news. Good news is that evil mode has support for
global commands, but the bad news is that without some extensions above example
command would not work for incrementing numbers. In evil mode, `Ctrl+a` in
normal mode, gets the cursor to the start of the line, *not* incrementing
numbers as in Vim.

See [evil numbers](https://github.com/cofi/evil-numbers) for similar functionality in
Emacs.

## Deleting matching lines

It is useful to learn the complement of `g` command, `v` as well. `v` runs the
command on *non*-matching lines given by the pattern.

```
0: <ul>
1:  <li style="even">Coffee</li>
2:  <li style="odd">Tea</li>
3:  <li style="even">Milk</li>
4:  <li style="odd">Sugar</li>
5: </ul>
```

Given above example content of a buffer, with line numbers as shown on the left,
the following `v` command gets rid of all list items *not* matching even style.

```
:1,4v/even/d
```

Resulting in following where only the even styled list items are preserved.

```
0: <ul>
1:  <li style="even">Coffee</li>
3:  <li style="even">Milk</li>
5: </ul>
```

There are many more uses of global commands worth knowing about given in the Vim
wiki<sup>[1](#vim-globals)</sup>.

# Resources

- <a name="vim-globals">1</a>: [Power of g](http://vim.wikia.com/wiki/Power_of_g)
- <a name="vim-multi-cursors">2</a>: [vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors)
- <a name="vim-inc-dec">3</a>: [Increasing or decreasing numbers](http://vim.wikia.com/wiki/Increasing_or_decreasing_numbers)
