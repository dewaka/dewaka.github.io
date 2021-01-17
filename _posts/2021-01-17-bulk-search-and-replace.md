---
title: "Bulk search and replace with ripgrep and sed"
last_modified_at: 2021-01-10
comments: true
categories:
  - blog
tags:
  - osx
---

Following a post on a couple of neat tricks I learned while bulk changing links
in org-mode text files.

I keep scanned hand written notes in PDF format in the main notes directory with
org-mode files. Then I link them as appropriate on daily notes I might keep
while working on tasks etc. Scanned notes were dumped in a single directory
before the start of this year. This was soon getting quite messy as notes got
accumulated over the months and with the new year, I wanted a better
organisation structure for the notes.

Moving existing files was quite simple because I only had scanned notes for the
last year (2020) and all of them could be moved to the 2020 directory. But the
problem was updating existing links to them in existing org-mode notes files. 

I had to change links with diffs such as follows and I wanted to automate the
task instead of manually fix them in 50 or so odd files!

```
-[[file:~/Dropbox/Documents/Notes/Pages/Scan 15 Dec 2020.pdf][Dec 15, 2020]].
+[[file:~/Dropbox/Documents/Notes/Pages/2020/Scan 15 Dec 2020.pdf][Dec 15, 2020]].
```

After thinking about this problem a bit I thought of using `ripgrep`[^grep] and
`sed` for the task.

Coming up with the search and replace command was the easy part, but it wasn't
as straightforward to find out how to pipe things together using `xargs` given
that most of the examples and stackoverflow answers assume the use of GNU tools.

## Command for bulk change

Following is the final command I used for the bulk change of links in org-mode
text files,

```sh
rg 'Notes/Pages/Scan*' -l | xargs -I@ sed -i '' 's,Pages/Scan,Pages/2020/Scan,g' @
```

It is worth breaking down the command and discuss about parts which were
tailored for the job to make it easier to follow.

### ripgrep

- `-l` (`--files-with-matches`) option to get a list of files which matches the
  search expression

### xargs

- Use of `xargs` `-I` option for substitution
- As in the following example the variable can be used for substituting output.
  Variable can be any symbol, as `_` in the following example or `@` in the
  above one.

  ```
  > echo hello | xargs -I_ echo _ _
  hello hello
  ```

### sed

- Use of custom separator `,` makes it cleaner when there `/` in the search and
  replace expressions as in the original example
- `-i ''` this option has to be given on macOS and this was the head scratcher.
  While GNU `sed` accepts empty `-i` argument, it _has_ to be given empty `''`
  on macOS.

------

[^grep]: Ripgrep is an overkill for this particular search where `grep` would be
    equally sufficient. But `rg` is easier to type and that's what I used!
