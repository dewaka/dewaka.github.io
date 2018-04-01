---
title: "Configuring Fish Shell"
comments: true
last_modified_at: 2018-04-01
tags:
  - linux
  - osx
  - fish
---

I have been eyeing to change the default shell from Zsh to Fish shell for a
while now, but never made the transition because I missed a couple of power
tools and configurations which didn't work in the quite the same way on fish.

After giving fish shell configuration another go, I found that I could
configure fish to match the functionality of my current zsh configuration with
some new features and niceties which comes with a [_modern shell_](https://fishshell.com/).

This post is about how I went about configuring fish shell for my usage
patterns.

## Installing and managing fish plugins

Fish shell comes with powerful autocompletion and other conveniences out of the
box without the need for extensive configuration from the user. There are
plugins to extend the functionality even further, and two most popular ones for
fish seems to be,

- [oh-my-fish](https://github.com/oh-my-fish/oh-my-fish)
- [fisherman](https://github.com/fisherman/fisherman)

Of the two `fisherman` seems to be more minimalist, focusing on providing a
package manager for fish plugins. Thus after installing `fisherman` you are
required to install plugins of your choosing. It also seems that the impact on
shell startup time with `fisherman` is lower than with `oh-my-fish`, but this is
not something I have benchmarked myself.

As of this writing, I have installed following plugins with `fisherman`, but if
you choose `oh-my-fish` the same plugins are available as well.

### Managing plugins with fisherman

- Update plugins - `fisher update`
- Remove a plugin - `fisher rm <plugin name>`
- If you want to get rid of `fisherman` plugin manager itself - `fisher self-uninstall`

## Integrating fzf

Installing [fish fzf](https://github.com/fisherman/fzf) is pretty easy -
`fisher fzf`. Note that for this plugin to work you should have already
installed `fzf` tool itself.

FZF is a powerful fuzzy filtering tool. Till version `2.6` fish shell had
issues with fzf, and that was the main reason I held up transitioning to fish
as I am a heavy user of fzf for filtering directories and files. With the `2.7`
version I'm using now, those issues seems to be fixed and I have been able to
replicate most of the useful functions for fish shell as well.

There are couple of differences worth noting,

- Fish shell does not support fuzzy glob expansion - with zsh or bash, you can
  press `Tab` on command line after entering `> ~/Dropbox/**` and fzf would
  give you filtering based on the path you entered before the glob `**`. This
  does *not* work in the same way on fish, but you can get the same
  functionality by just pressing `Ctrl+T` after entering part of the path.

- Make sure that your `$FZF_DEFAULT_OPTS` variable contains options in a format
  which is valid for the fish shell. This is something I had to debug to fix
  because I had an old config option which was set for zsh, but invalid for
  fish shell. If you see error or warning messages when you run fzf completion
  commands, then it is a good idea to check this environment variable, and
  probably set it to a simple value in your fish config file (usually at
  `~/.config/fish/config.fish`)

## Integrating fasd

I have written about integrating fasd with respect to zsh integration -
[Using Fasd for Command Line Navigation]({% post_url 2018-02-07-fasd-for-navigation %}).
Fasd works in the same way with fish shell as well.

Installing [fish fasd](https://github.com/fishgretel/fasd) plugin is pretty easy -
`fisher gretel/fasd`. Please follow instructions to install `fasd` for your OS.

With fzf we can make directory switching even more awesome. Default behavioiur
for `d` command which is provided by fasd does not give ability to filter
output if there are multiple matches. We can utilise fzf to get that
behaviour with the following function.

```fish
# Function to filter through recently used directories
function zd --argument-names 'name'
  set -l zd_command "command fasd -Rdl $name 2> /dev/null"
  fish -c "$zd_command" | __fzfcmd -1 -0 --no-sort -m | read -la select
  if test ! (count $select) -eq 0
    cd "$select"
  end
end

# Set above function to even shorter j alias
alias j   "zd"
```

## Cleaner prompt

[fish pure prompt](https://github.com/rafaelrinaldi/pure) provides popular
`pure` shell prompt in zsh for the fish shell. This can be installed with
fisher as follows - `fisher rafaelrinaldi/pure`

# Some thoughts

- One thing I tried to port from my zsh config was backgrounding and
  foregrounding of Vim in a terminal with the same key combination - `Ctrl+Z`.
  After a bit of research, I found that, as of now it, is 
  [not possible](https://stackoverflow.com/questions/30662735/how-to-map-ctrl-z-to-fg-in-fish)
  to assign `Ctrl+Z` for this functionality with the fish shell.

- Zsh completion is quite nice, but fish has even better completion! I quite
  like how fish offers completions based on history and they are most of the
  time the right one as well which I want to run.

- Fish shell seems to start a bit faster than zsh for me, which could be due to
  my zsh configuration! This is not a major point, but fish shell feels a bit
  snappier overall.
