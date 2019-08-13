---
title: "Customising IdeaVim"
comments: true
last_modified_at: 2019-07-27
categories:
  - blog
tags:
  - vim
  - IntelliJ IDEA
  - IdeaVim
---

# Vim in IntelliJ IDEA

IDEA is one of the IDEs with relative good support for Vim with IdeaVim
Plugin<sup>[2](#ideavimrc-gist)</sup>. I find that IntelliJ IDEA is a must have
for Scala development. You can almost get best of both world's this way.

IdeaVim can be customised in a similar way to Vim by editing a configuration
file: `~/.ideavimrc`.

I would refer to my current config file to get the full
details<sup>[2](#ideavimrc-gist)</sup>, but following are some of the more
useful settings to bring the experience closer to full Vim capabilities.

    " Emulated Plugins
    set surround

    " Use Idea to join lines smartly
    set ideajoin

    " Copy to system clipboard as well
    set clipboard+=unnamed

    " Multiple cursors support
    set multiple-cursors
    
- Vim surround enables support for popular vim-surround
  support<sup>[3](#vim-surround)</sup>.
- ideajoin is a recent setting which emulates IntelliJ's builtin line join
  semantics when you use Vim commands to join lines, such as `J`.
- Clipboard setting enables copying to system clipboard as well with the above
  setting which is useful for copying code from IntelliJ with normal Yanking
  commands to other applications. Thjs also removes the mismatch between native
  Copy action and IdeaVim based yanking.

My settings are quite tailor made to my work setup, so it wouldn't be a good
idea to copy them verbatim. I would suggest taking useful settings from there
for your own personalised setup. That is also what I've done from multiple
sources, some of which I've referenced in comments in the config file itself.

## Finding out available actions

To get a list of available actions which you can bind keys for, run the
following command in normal mode in IDEA after enabling IdeaVim plugin.

    :actionlist

This command is pretty useful to extend key bindings because IntelliJ Plugins
actions are also avaialble via a unified action system.

## Summon _real_ Vim for quick edits

Inevitably you'll find that IdeaVim, though really good, does not really
support all the myriad advanced ways you do ediging in vanilla Vim. For those
times, I recommend adding a leader key binding as follows to open a Vim
instance.

    " External GVim
    nmap <leader>v :action Tool_External Tools_gvim<cr>

Interested readers can find my current `.ideavimrc` file here.

For this binding to work, first you will need to setup gvim as an external
tool.

### Setting up GVim as an external tool in IDEA

![gvim external tool]({{ "/assets/postassets/ideavim/idea-gvim-external-tool.png" | absolute_url }}){: .align-center }

Make sure to tick the setting for `Synchronize files after execution` setting
as shown above in the settings window image.

I find that this is pretty useful for doing block edits in Vim which I'm more
used to than doing them in IntelliJ editor.

I have used similar settings for MacVim on macOS and Windows GVim as well,
although in the latter case I have not tested Vim client-server behaviour. This
is a simple usability improvement to reuse existing Vim instance for multiple
files opened via IntelliJ.

For ease of copying, here's the full command.

    --servernaem IdeaVim --remote-silent "+call cursor($LineNumber$, $ColumnNumber$)" "$FilePaths$"

# Resources

- <a name="jetbrains-ideavim">1</a>: [IdeaVim](https://plugins.jetbrains.com/plugin/164-ideavim)
- <a name="ideavimrc-gist">2</a>: [Personal .ideavimrc](https://gist.github.com/dewaka/ef947e52767bf453eaf77c852051eb7e)
- <a name="vim-surround">3</a>: [Vim Surround](https://github.com/tpope/vim-surround)
