---
title: "Fix for Chrome dithering issue with Nvidia on Linux"
last_modified_at: 2020-10-18
comments: true
categories:
  - blog
tags:
  - linux
  - chrome
---

## Dithering in Chrome after resuming

I have had this annoying problem with Chrome on latest Xubuntu LTS[^lts]
installation on my Thinkpad T470p laptop where Chrome would get dithering
artefacts after resuming from sleep. Installing the latest versions of software
didn't really solve the problem.

Following are the system configurations I observed this issue.
- Xubuntu 20.04 (Linux 5.40.0-51)
- NVIDIA driver 450.80.02
- Chrome 86.0.4240.75

This problem has been bothering me ever since I started using Ubuntu 20.04 on
this particular laptop. After resuming Chrome was unusable till I restarted the
browser. 

## The fix

After some googling, it seemed that this is a pretty common problem with
Chromium based browsers and applications on Linux with latest Nvidia drivers.
People have reported that programs which are based on Chromium, such as VSCode
also runs into this issue. Firefox does not have this problem.

Finally, the solution which worked was the 2nd answer from this StackOverflow
question - [Problems with Chrome browser after suspending the computer on Ubuntu
20.04](<https://askubuntu.com/questions/1273399/problems-with-chrome-browser-after-suspending-the-computer-on-ubuntu-20-04>).
So, I'm documenting this for myself and for other's who might be facing the same
issue. I found that other suggested fixes for this problem didn't really solve
the issue, or they came with their own problems, such as slowdowns.

The fix is quite simple: use Chrome flag `--use-gl=desktop` when launching
Chrome. You can change the default `desktop` entry for launching Chrome and add
the flag there, but I just decided to have a small script for launching[^rofi]
Chrome with content as follows.

```
#!/usr/bin/env sh

google-chrome --use-gl=desktop
```

With this flag provided, I didn't see dithering issues with Chrome after
resuming from sleep and neither did I notice any performance issues, thus far.

[^lts]: [Ubuntu 20.04 (Focal Fossa)](https://releases.ubuntu.com/20.04/)
[^rofi]: I use excellent [rofi](https://github.com/davatorium/rofi) launcher as
    the default application launcher on Ubuntu
