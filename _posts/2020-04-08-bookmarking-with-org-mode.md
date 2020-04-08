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

<!-- But I thought why not make use of Emacs which I have open almost all the time -->
<!-- while browsing. -->

<!-- ## Offline bookmarks -->

<!-- Main workflow of my approach is to use Emacs to capture bookmarks into a notes -->
<!-- buffer in org-mode format. -->

<!-- Why Emacs? In my case I have Emacs open all the time since it is my main tool -->
<!-- for capturing notes. -->

<!-- Why org-mode? Org mode is powerful note taking (and much more!) Emacs -->
<!-- plugin which offers the kind simplicity of Markdown format coupled with very tight -->
<!-- integration with Emacs ecosystem, empowering Emacs to be one of the most feature -->
<!-- rich note taking applications. -->

<!-- This is an alternative approach to using online bookmarking services, such as -->
<!-- pinboard, or even using browser specific bookmarks. A couple of arguments for not using latter, -->
<!-- - Browser bookmarks are specific to browsers and does not offer easy way to share bookmarks between browsers.  -->
<!-- - Online bookmarking services, such as pinboard, are not guaranteed to survive -->
<!--   long. Most people who were using delicious might not have thought of its -->
<!--   possible demise when they were using it. But demise it did! -->

<!-- There are a couple of advantages to offline bookmarking in a text format. Text -->
<!-- is pretty much universal. -->

<!-- In my personal experience, browser bookmarks are good for keeping only a handful -->
<!-- of links to most used resources. They are _not_ a good way to store links and -->
<!-- references for research topics because of rudimentary nature of bookmark -->
<!-- managers. -->

<!-- On the other hand, offline bookmarks allow you to add context and accompanying -->
<!-- notes to a bookmarking link, which I find very valuable. Sometimes, I find -->
<!-- peripheral things I learn from web resources are even more important than the -->
<!-- links themselves. Org mode bookmarks, as captured via following template allows -->
<!-- me to easily do just that. -->

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

I tend to capture bookmarks on daily notes file, which I create per day. Another
common approach is to use a `file+olp+datetree` type of capture for bookmarks.

Following is how a sample bookmarked link looks like in a daily notes file.

![org-mode bookmark example]({{ "/assets/postassets/org-bookmarks/org-bookmark-example.png" | absolute_url }}){: .align-center }

Since bookmarks captured in this method are simply org-mode text node, all
things you can with a text node can be done with your bookmark entries as well.

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

<!-- In my case, I capture bookmarks into a daily note file, which I keep as a -->
<!-- journal. There are other approaches one can take, such as using a single -->
<!-- bookmarks file. -->

<!-- One can even download a copy of a web page, or a PDF version of it and _attach_ -->
<!-- it to the org-mode buffer with the bookmark link. Org-mode file attachments work -->
<!-- quite nicely for this use case. -->

<!-- With org-mode notes, bookmarks is not just a link, but could be part of a -->
<!-- overall note taking system. -->

### Link tags

Org-mode supports tags[^org-tags] and they are quite powerful. It is pretty easy
to set tags while capturing a new bookmark via Emacs. Tags can be used to filter
bookmarks on based on topics. For example, all bookmarks links with the tag
`agda` can be searched quite easily with org-mode.

### Data ownership

Notes in org-mode is just plain text. Thus bookmark data is portable across
operating systems with almost no risk of getting locked into a proprietary data
format.

<!-- My main point of this article is that you can treat online bookmarks as one -->
<!-- element of your note capturing system. Org mode is just a very nice way to do -->
<!-- that in a friction less way, provided that you are already using Emacs. -->

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

<!-- In the past when I looked at using org-mode on the phone, none of the apps I -->
<!-- tried could handle the large notes repository I had. In the end I decided use a -->
<!-- hybrid approach when I'm on the phone - that is to dump interesting things which -->
<!-- I might read on phone into a either Google Keep note to revisit and add as a -->
<!-- bookmark later on. This works for me now because I do not tend to use the phone -->
<!-- for any kind of serious reading or research. -->

<!-- If it is something I would like to just read later, I might add that to Pocket -->
<!-- reading queue, which integrates quite nicely with the Firefox mobile browser. -->

<!-- Mobile story of org-mode leaves a lot to be desired. I have tried Org Mobile and -->
<!-- Orgzly[^orgzly] in the past, but they weren't all that great from my experience. -->
<!-- Probably I have too many notes for either of them to handle. -->

<!-- When I want to bookmark something when browsing on the phone what I usually do -->
<!-- is set myself a reminder as a Google Keep note or may be add that to Pocket. -->
<!-- Then later I usually revisit them and add a bookmark manually if they seem to be -->
<!-- useful enough. -->

<!-- ## Alternatives -->

<!-- I have heard good reviews on pinboard and as a paid service with a good -->
<!-- reputation thus far, there's a good chance that it will continue to operate in -->
<!-- the foreseeable future. -->


<!-- Sites like pinboard makes things easy to share your bookmarks with others quite -->
<!-- easy since everything is online. With an offline solution like the one I'm -->
<!-- describing here, that's no longer possible. There are archival facilities in the -->
<!-- paid tier which can be quite handy if you do not want to lose an important page -->
<!-- later on even in the event the original page goes dark, which is not too -->
<!-- uncommon an occurrence. -->

------

I wanted to write more on making a case _for_ using offline bookmarks, but then
I realised that the case for this is same as making a case for why I'm using
org-mode for note taking - and there are many other posts around the internet
making _that_ case. So, in the end I decided to keep the post very short just
describe above capture template and very useful `org-cliplink` package.

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

<!-- [^orgzly]: [Orgzly](http://www.orgzly.com/) -->

[^pinboard]: [Pinboard - Social bookmarking for Introverts](https://pinboard.in/)

[^org-mobile]: In the past when I looked at using org-mode on the phone, none of
    the apps I tried could handle the large notes repository I had. Things might
    have gotten better in the meantime.
