---
title: "Personal Wiki"
last_modified_at: 2019-08-24
comments: true
categories:
  - blog
tags:
  - wiki
  - writing
---

## Journaling Habit

<!-- A bit of history on my personal habits when it comes to keeping notes. -->

I have been keeping org-mode<sup>[1](#org-mode)</sup> notes on a daily basis for
a couple of years now. I started keeping journal notes with Evernote around
2012, but soon got disillusioned on proprietary formats for keeping notes,
especially given that I pretty much hate to use any text interface without good
Vi key bindings.

After learning about the power, flexibility and simplicity of org-mode with
Emacs, which does have a pretty good Vi mode<sup>[2](#evil-mode)</sup>, I
transitioned to use org-mode for journal notes exclusively.

Even though these notes are source controlled, they are not in a public
repository and I realised that there are probably some notes which might be
useful for others as well.

## Starting a public Wiki

<!-- Why start a wiki now? -->

One of the primary reasons for starting a wiki is the fact that I found most of
the blog posts I want to write are better served in a wiki format. Wikis have
following advantages compared to often static blog posts,

- Editability and version history - A wiki by its very nature is supposed to be
  a living document updated with new information when they get outdated. 
- Extensibility - Since the wiki source is public, which is in my case, even
  others can fork the repository and fix/correct errors in the wiki easily with
  a git work flow.
- Better discoverability - Wiki is organised around topics with articles
  inter-linked for related concepts. Blog posts on the other hand are not
  organised around topics and not so well inter-linked considering that old blog
  posts rarely changed to link to newer blog posts.
- Narrow focus - As someone who's just starting to write publicly, I like the
  narrow focus of a wiki article compared to the open ended nature of a blog
  post. I can write about even the most trivial thing as a wiki article without
  too much self reflection on the fact that whether this really deserves writing
  a blog post about!

A wiki would be a good way to organise knowledge and know hows in a personalised
way. The point of a personal wiki in my mind is not to be an exhaustive source
of information, a la Wikipedia, but to organise information as one learns things
on a daily basis. This information while not exhaustive or even authoritative,
is pretty useful for recall, and incidentally, might be useful for others as
well.

## GitBook Integration

<!-- Where did I get the inspiration from? -->

There are plenty of personal wiki software, but I wanted to find something which
can be integrated with my existing blog easily. I followed the excellent wiki by
[Nikita Voloboev](https://wiki.nikitavoloboev.xyz/). Nikita's wiki is the
primary source of inspiration for starting a wiki on my own, especially when it
comes to the format and the hosting option.

<!-- What did I do? -->

I signed up with [GitBook](https://www.gitbook.com) with their Github
integration. The interface for setting up a new book is pretty simple. GitBook
has the option to link the book to a Github repository. Source for the new wiki
is at [Personal knowledge wiki](https://github.com/dewaka/wiki) in my case.

GitBook also enables serving via a custom sub-domain and it thus was quite
painless integrate it with [this](https://dewaka.com) domain at
[wiki.dewaka.com](https://wiki.dewaka.com).

Even though I much prefer org-mode considering most of my writing is done via
Emacs these days, I'm fine with Markdown format. In fact Markdown has much
better support in a wider variety of tools compared to org-mode which is mostly
used within the Emacs ecosystem. Also there's pandoc<sup>[3](#pandoc)</sup> for
converting my existing notes to Markdown format should I so choose.

<!-- What do I plan to write about? -->

## Plans for the Wiki

I plan to distil some of my personal notes into a these wiki articles for my own
use and others who might find useful. For example, there are many things in day
to day work or in my own explorations I learn and I want to remember for later
use. It could be as simple as a Vim trick, or something like a programming
language concept.

# Resources

- <a name="org-mode">1</a>: [org-mode - Org mode is for keeping notes and more!](https://orgmode.org/)
- <a name="evil-mode">2</a>: [evil-mode - Evil is an extensible vi layer for Emacs](https://www.emacswiki.org/emacs/Evil)
- <a name="pandoc">3</a>: [Pandoc - A Universal Document Converter](https://pandoc.org/)
