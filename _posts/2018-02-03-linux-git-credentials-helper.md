---
title: "Linux - Git Credential Helpers"
tags:
  - linux
  - fedora
  - arch linux
---

Typing remote repository passwords for Github and the like quickly becomes
tedious when you are working on a couple of repositories on a daily basis. To
help that case, modern git comes tools integrating with keyring implementations
on various platforms.

A credential helper integrates with system installed keyring to securely store
username/passwords, so that you do not have to type them everytime you want to
interact with a remote repository. Popular keyrings include gnome-keyring,
which is the one I use on both my Linux installations - Arch and Fedora.

Recently, when I was trying to configure a git credential helper in Fedora, I
found that things have changed a bit from the configuration I used with Arch
Linux sometime back. I used to have a configuration as follows on Arch Linux,
for gnome-keyring integration:

```
[credential]
  helper = /usr/lib/git-core/git-credential-gnome-keyring
```

Following the Arch configuration, I tried to set the same for Fedora 27, only
to find that there is no such `git-credential-gnome-keyring` in
`/usr/libexec/git-core`. After a bit of googling I found that the configuration
to use is as follows now:

```
[credential]
	helper = /usr/libexec/git-core/git-credential-libsecret
```

[libsecret](https://wiki.gnome.org/Projects/Libsecret) provides a unified library for accessing keyrings on Linux
platforms, and this is the setting to use if you have gnome-keyring as your
keyring on Fedora. Arch Wiki also shows this configuration as of this writing - [GNome Keyring - Git Integration](https://wiki.archlinux.org/index.php/GNOME/Keyring#Git_integration).
