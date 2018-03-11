---
title: "Why I use Emacs"
last_modified_at: 2018-03-10
tags:
  - emacs
---
# The reasons I use Emacs

Although I use Vim for quick edits, and occasionally for programming, for any
prolonged text editing tasks, my go to editor has been Emacs for a while now.
There are a couple of reasons for this.

<!-- 
Talk about how I use Emacs, specifically Spacemacs.
My rationale for using Spacemacs.
Drawbacks.

There are a couple of things which are not great about macOS Emacs. I have found
that it can get stuck on a text editing operation in some mode for any kind of
reason than what I would experience on Linux. -->

For me, Emacs occupies the middle ground between a full blown editor and an
efficient, but basic text editor. With enough customisation, and a bit of
adaptation of my current workflow it shouldn't be too difficult to use Vim as
the main development tool. However, Emacs coupled with a handful of plugins
offer me the raw efficiency of Vim and integrated experience of Emacs.

## Evil mode

If Emacs did not have a great Vim emulation layer in evil mode, I would not be
using it. Although I'm familiar with basic non-modal Emacs key chords for
editing, I would be quite inefficient at that with plain Emacs.

Even though evil-mode is not a _complete_ Vim emulation layer with a one to one
mapping of functionality from Vim, it does provide me with a sufficiently great
Vim emulation to use confidently and not to be surprised. One significant area
where I have found the differences to be glaring is in search functionality and
Vim global commands.

## Org mode

I'm using org mode for keeping journal notes in a daily basis. Org capture
enables me to capture thoughts, development notes, bookmarks etc. without
interrupting the main task I am doing at the moment. For example, if I need to
make a note of something while I am coding on a C++ source file in Emacs, with a
couple of key presses I can make a note of something in my daily journal file
without even leaving the current Emacs frame. Org capture for notes is the most
used, and useful feature for me personally.

When it comes to notes itself, they are quite powerful. I can make use of source
code snippets, with full syntax highlighting in a note, and with org-babel, I
can even execute them if I fancy. Org babel can be quite magical to use
especially with scripting languages.

## Projectile mode

Projectile mode is a very simple to use workspace management plugin which is
both simple to use and powerful. This is a feature which I use all the time. Vim
the working directory of a buffer is different from Emacs, and projectile mode
helps bridge that gap and makes it even more powerful.

With a couple of key combinations it has never been easier to do following tasks
on a project,
- Open a project specific file. Although this sounds simple, in a deeply nested
  project structure, the file I want to open might be up a couple of levels, but
  with projectile mode coupled with a selector like *helm* it has never been
  easier to find the right file.
- Search through only the project files.

All those benefits comes from the definition of a project. So, what exactly is a
project. There are many ways to define what a project. Oftentimes projectile
mode will figure the project structure based on repository structure.

Sometimes when I start working on a project, I would start with a `.projectile`
file to mark a directory to be containing a workspsace for projectile. This is
perfectly adequate to get a really good project specific work behaviour in
Emacs.


## Miscellaneous features

<!-- Even though Vim with its modal editing might be more efficient --> 

<!-- Theme is that Emacs is a little bit smarter editor. At least can be made
smarter more easily! -->

Emacs is actually no slouch when it comes to text editing. There are keybindings
to transpose words, and that is as simple as pressing `Meta+t` in Emacs.

## Magit

Magit is really one of the easiest way to use git, even though I'm not an
advanced user of magit. Just with a couple of modal key presses it is possible
to do most git tasks in an easier manner with magit than with command line
interface.
