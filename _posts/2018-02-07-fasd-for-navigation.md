---
title: "Using Fasd for Command Line Navigation"
comments: true
categories:
  - blog
tags:
  - linux
  - osx
  - bash
  - zsh
---

Changing working directories is one of the most common operations you do while
working on the command line. While tab completion can help make path completion
more efficient, it is still a chore to do things manually, especially when
moving back and forth between commonly worked on project locations.

[fasd](https://github.com/clvv/fasd) is a tools which can help improve the
efficiency of navigating the file system. Fasd tool is a shell tool which
integrates with shells to _remember_ directories and files you have worked on
recectly. Think of fasd as keeping a
[MRU](https://en.wikipedia.org/wiki/Cache_replacement_policies#Most_Recently_Used_(MRU))
cache of files and directories you have worked on.

With fasd integration, it is possible to jump back to a directory you have
worked on previously with a few keystrokes with the power of fuzzy matching.
Same goes for files.

Refer to fasd project for full documentation regarding
[installation](https://github.com/clvv/fasd#install). Fasd is available for
installation on most Linux distributions through system packages, and macOS
through Homebrew and Macports.

## Combining fasd with fzf

You can make fasd integration even more powerful by combining a fuzzy filter
tool, such as [fzf](https://github.com/junegunn/fzf) through piping. 

Following are some of the most useful and oft-used utility functions which I
have defined for use in Zsh terminal, and these should work in the same way for
Bash as well. 

### Recently used directories

Following function helps changing back into most recently used directories.

```sh
# cd into recent directories
zd() {
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}
```

Since this is going to be a very common use case, you can set an easy to use
alias as follows,

```sh
# j: jump to directories
alias j=zd
```

Above function will directly jump to the directory if you invoke it with an
argument which results in an unambiguous match. Otherwise, fzf prompt will be
displayed for filtering through possible matches, as shown below.

```sh
# jump to recenty worked directory starting with word helm
> zd helm
```

![fasd directory search through fzf]({{ "/assets/postassets/fasd/fasd-fzf-zd.png" | absolute_url }}){: .align-center }

### Recently used files

Following bash function gives you a quick way to filter through your most
recently used files and open them in your default editor.

```sh
# View recent f files
v() {
    local file
    file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && $EDITOR "${file}" || return 1
}
```

Sometimes you remember a file you worked on but not the directory containing it
, which can be a common occurrence when you have multiple projects. Following
function ~cd~ into the directory of the project containing the file selected
based on fasd filtering through fzf.

```sh
# cd into the directory containing a recently used file
vd() {
    local dir
    local file
    file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && dir=$(dirname "$file") && cd "$dir"
}

```

There are other utility functions which can be developed based on fasd and fzf,
some of which are given in the [fzf wiki](https://github.com/junegunn/fzf/wiki/examples).
