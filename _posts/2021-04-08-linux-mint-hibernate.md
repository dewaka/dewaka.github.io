---
title: "Linux Mint Hibernate"
last_modified_at: 2021-04-08
comments: true
categories:
  - blog
tags:
  - linux
---

I have a Thinkpad T470p laptop with Linux Mint 20.1 (Xfce) installed for
personal use and power management is one of the things I dislike in otherwise a
pretty good laptop. Compared to my work laptop, a Macbook, the Thinkpad drains
battery in sleep mode and I often find the battery completely drained if I
happen to not to use the laptop for a couple of days.

Since Linux Mint does not come with Hibernation option enabled out of the box,
following are the steps I did to enable this option.

## Swap partition

I found it is easier to have the right size of swap partition at installation
time rather than trying hibernation support based on a swap file. Following
instructions are based on my setup with a swap partition. 

I created a swap partition of 25G since I have 24G of RAM at install time.

## Install hibernate utilities

Install hibernate utils,

```
sudo apt install pm-utils && sudo pm-hibernate
```

## Update grub

Find the UUID of the swap partition by `grep swap /etc/fstab`.

You need to update grub boot loader to add option to resume from disk. For that,
edit `/etc/default/grub` and modify the `GRUB_CMDLINE_LINUX_DEFAULT` as super
user[^update-grub]. 

In my case the the required edit looks as follows.

```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash resume=UUID=putYourSwapUUIDhere"
```

Then update grub with command `sudo update-grub`.

## Power menu

Now you should be able to hibernate with `systemctl hibernate`. 

However the power menu in Linux Mint doesn't show the Hibernate option.

For that I needed to add the following policy[^forum] to
`/etc/polkit-1/localauthority/90-mandatory.d/enable-hibernate.pkla`.

```
[Enable hibernate]
Identity=unix-user:*
Action=org.freedesktop.login1.hibernate;org.freedesktop.login1.handle-hibernate-key;org.freedesktop.login1;org.freedesktop.login1.hibernate-multiple-sessions
ResultActive=yes
```

After adding the policy Hibernate should show up as a power management option in
the Mint menu.

----

Hibernation has been working quite smoothly thus far in my laptop. I prefer to
use this option when I know that I'm not likely to pick up the laptop in a
while.

----

[^forum]: https://forums.linuxmint.com/viewtopic.php?t=326063.
[^update-grub]: https://superuser.com/questions/383140/linux-grub2-how-to-resume-from-hibernation
