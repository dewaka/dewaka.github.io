---
title: "Bookmarking with org-mode"
last_modified_at: 2020-04-08
comments: true
categories:
  - blog
tags:
  - org-mode
  - emacs
---

I thought about writing a short post on how I tend to capture bookmarks using
org-mode[^org-mode] these days.

## Capture template

I have following org-capture template[^org-capture], defined in my Emacs configuration file
based on the Doom config[^doom],

```elisp
;; Capture template
("l" "Daily Bookmarks" entry
    (file+headline (lambda () (personal-note 'daily)) "Bookmarks")
       "** %(org-cliplink-capture)%?\n" :unnarrowed t)

;; Utility function
(defun personal-note (ntype)
  (cond
    ((string= 'daily ntype) (concat org-directory (format-time-string "/%Y/%B_%-e.org")))
    ((string= 'work ntype) (concat org-directory (format-time-string "/work/%Y/note_%m_%d.org")))
    (t (error "Invalid personal note type: " ntype))))
```

Most important time saver in this capture template is the use of
`org-cliplink-capture` functionality which is provided by the `org-cliplink`[^org-cliplink] package.

I tend to capture bookmarks on daily notes file, as can be seen from the above
template. As an example, notes for today will be captured in a dedicated file
`$ORG_DIR/2020/April_8.org`, where `$ORG_DIR` is the root directory for notes. 

With this approach, bookmarks will be scattered on multiple note files. Using
instead the `file+olp+datetree` capture method, one can maintain a single note
dedicated to bookmarks, say `$ORG_DIR/Bookmarks.org`.

Following is how a sample bookmarked link looks like in my current setup.

![org-mode bookmark example]({{ "/assets/postassets/org-bookmarks/org-bookmark-example.png" | absolute_url }}){: .align-center }

Since bookmarks captured in this method are simply org-mode text nodes, you can
embellish entries in the same way as any other org-mode entry node.

Following are some of the advantages of bookmarking in this manner instead of
using an online service, such as pinboard[^pinboard].

### Contextual information

Bookmarks with org-mode allow you to add context and accompanying notes to a
bookmarking link (as can be seen in above example), which I find very valuable.
Sometimes, I find peripheral things I learn from web resources are even more
important than the links themselves. Org mode bookmarks, as captured via
following template allows me to easily do just that.

I add a bit of a background on things while I bookmark _because_ it is so easy
to do that, with Emacs, being a full fledged text editor. In fact, the capture
template as I've defined above, gets me right into a prompt to add more
details after inserting the link to the Emacs buffer.

### Link tags

Org-mode supports tags[^org-tags] and they are quite powerful. It is pretty easy
to set tags while capturing a new bookmark via Emacs. Tags can be used to filter
bookmarks on based on topics. For example, all bookmarks links with the tag
`agda` can be searched quite easily with org-mode.

### Data ownership

Notes in org-mode is just plain text. Thus bookmark data is portable across
operating systems with almost no risk of getting locked into a proprietary data
format.

### Fast local search

Emacs can filter and find bookamrked links very quickly using tools such as
helm[^helm] or ivy[^ivy]. Also one can classic POSIX tools such as `grep` and
other text processing tools to locate and filter bookmarks.

Going a one step further, one can setup indexed local search for org-mode note
files for even faster and more precise search experience. I have used
recoll[^recoll] on Linux for such a setup in the past.

## Limitations of this approach

Just as the advantages of this bookmarking approach is parallel to the
advantages of using org-mode in general, the disadvantages are pretty much
the same as general limitations of org-mode ecosystem.

- Lack of good mobile support[^org-mobile] - after not finding a good mobile
  org-mode solution, what I tend to do is to capture one off links while
  browsing from phone to a temporary note on Google Keep.
- Separate synchronisation solution - I use Dropbox to sync notes between
  computers. With Emacs and org-mode, syncing is something separate you have to
  think about.
- Lack of sharabilty - online bookmarking tools often provides a way to share
  your bookmarks within the service itself, i.e. without the need to export to a
  different format. But with the method I'm describing here, you cannot easily
  share your bookmarks without exporting only parts of your notes you might want
  to share.

------

I wanted to write more on making a case _for_ using offline bookmarks, but then
I realised that the case for this is same as making a case for why I'm using
org-mode for note taking - and there are many other posts around the internet
making _that_ case. So, in the end I decided to keep the post very short just
describing the capture template which I find very useful.

---------

### Links

[^org-mode]: [Org mode](https://orgmode.org/)

[^doom]: My current Emacs configuration is based on [Doom Emacs](https://github.com/hlissner/doom-emacs). However, the capture
    template is fairly standard and should be portable on recent org-mode
    setups.

[^org-cliplink]: [org-cliplink](https://github.com/rexim/org-cliplink). Note
    that `org-cliplink` does not come packaged with the default Doom
    configuration. You will need to add `org-cliplink` as an additional package.

[^org-tags]: [Tags - org-mode manual](https://orgmode.org/manual/Tags.html)

[^org-capture]: [Capture templates - Org mode manual](https://orgmode.org/manual/Capture-templates.html)

[^pinboard]: [Pinboard - Social bookmarking for Introverts](https://pinboard.in/)

[^org-mobile]: In the past when I looked at using org-mode on the phone, none of
    the apps I tried could handle the large notes repository I had. Things might
    have gotten better in the meantime.

[^helm]: [helm - Emacs incremental completion and selection narrowing framework](https://github.com/emacs-helm/helm)

[^ivy]: [ivy - a generic completion frontend for Emacs](https://github.com/abo-abo/swiper)

[^recoll]: [Recoll is a desktop full-text search tool](https://www.lesbonscomptes.com/recoll/)
