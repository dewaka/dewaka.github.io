---
title: "Flashcards in Markdown"
last_modified_at: 2021-05-12
comments: true
categories:
  - blog
tags:
  - anki
---

<!-- Experience with anki --> 

[Anki](https://apps.ankiweb.net/) is an indispensable tool for studies which
aids memorisation through spaced repetition[^spaced-repetition]. Flashcards are
really good for learning new languages and any subjects which requires a lot of
memorisation.

There are other software both free and proprietor for spaced repetition based
learning. With its pretty good mobile application, which is free on the Android
platform, Anki has been my go to solution for flashcards. Having the ability to
use the flashcards on phone was an important factor in my decision to settle on
Anki for this purpose as opposed to other solutions such as org-mode based
solutions which briefly I explored initially.

I found that the cards I make myself are much more useful than the ready made
decks I can find from ankiweb[^ankiweb]. When you are making the notes yourself
chance of recalling the notes later is definitely higher because your mind has
to be engaged with the subject matter in the in the card making process itself.

However one aspect I was not quite happy with Anki is that I found it is a
little bit clunky to create flashcards in the bulk. For example, when you are
learning a new language, you might come across a couple of new words you want to
capture into your language learning deck. Using plain Anki the solution is to
create one card after another, which is not a super efficient process. The built
in flashcard editor is perfectly adequate, but it is nowhere as efficient as
capturing an org-mode note for example in Emacs, for example. 

Thus I have been looking for a solution to write flashcards in using my
favourite tools such as Emacs or Vim where I can easily edit things far more
efficiently compared to somewhat clunky Anki card builder interface.

## Markdown flashcards

After exploring a couple of software packages which support creating markdown
based flashcards, [mdanki](https://github.com/ashlinchak/mdanki) is the solution
I found which worked best. I found that the card format required by the package
is quite clear. This package handles images quite well.

Following is an example flashcard note demonstrating the basic elements,

```markdown
## What is the capital of New Zealand?

Wellington

![Wellington pic](images/wellingon.png)

[#Cities]()
```

- Front matter starts with a level two heading (`##`)
- The contents under the heading will be part of contents of the card
- You can optionally have tags, which are very useful for organising information, as links with the syntax: `#[tag_name]()`[^tags]

<!-- Why this solution is good -->

## Advantages and new possibilities

Having flashcards in markdown format addresses a couple of shortcomings I found
with my Anki card making workflow.

- Markdown is simpler to write for even nicely formatted card. Simple formatting
  for a flashcard can be done quite easily in the markdown syntax.
- They can be versioned easily. Putting markdown files in a git repository is
  super convenient than trying to version your binary anki decks!
- Editing in a note in a real editor is so much more efficient than using the
  Anki interface. For example, in my case I'm far more efficient in editing
  markdown notes in Emacs than the Anki editor. Even adding something like a
  table in markdown in super simple compared to what you can do in the Anki
  interface.
- Easily backup your notes. Anki has functionality to export your database for
  backup purposes, but Markdown text format is even more future proof because
  it's all just text at the end of the day!
- You can re propose the flashcard notes to other purposes very easily because
  your notes are just a simple collection of markdown notes organised into
  headings and paragraphs. In fact, I found that the notes I made are quite good
  for revising things by themselves. It helps that GitHub has pretty nice
  rendering for markdown files, for example.

---

[^spaced-repetition]: https://en.wikipedia.org/wiki/Spaced_repetition
[^tags]: I found that tags with spaces does not work well
[^ankiweb]: https://ankiweb.net/
