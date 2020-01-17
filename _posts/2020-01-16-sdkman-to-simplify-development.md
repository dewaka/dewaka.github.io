---
title: "Using sdkman to simplify development"
last_modified_at: 2020-01-17
comments: true
categories:
  - blog
tags:
  - development
---

Oftentimes you find that there are different SDK requirements for different
projects. A classic example would be that your Scala project might be stuck at
JDK 8 level[^scala-java-8], but Java projects themselves might be using later
versions, such as JDK 11.

It would be cumbersome to switch between different JDK versions manually, having
to make sure to correctly setup `JAVA_HOME` when you switch between projects.
[sdkman](https://sdkman.io/) is there to address this problem and the same class
of problems for other types of development setups as well. These include Scala,
Groovy, Gradle and a whole of others.

## Installation and setup

Follow the [instructions](https://sdkman.io/install) to install sdkman.

The installation script integrates to bash/zsh automatically. You can
alternatively add the following at the end of the ~/.bashrc or ~/.zshrc for bash
and zsh respectively.

```sh
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
```

`SDKMAN_DIR` is the default location for the install and on a POSIX system it is
`$HOME/.sdkman`.

Default location can be customised by exporting `$SDKMAN_DIR` variable to a
custom location, as shown below,

```sh
export SDKMAN_DIR="/usr/local/sdkman" && curl -s "https://get.sdkman.io" | bash`
```

### Integration with fish shell

Fish shell, which is my current shell, requires a third party plugin, or manual
setup. I found that
[sdkman-for-fish](https://github.com/reitzig/sdkman-for-fish) works quite
nicely. This plugin adds sdkman binaries to fish path and also adds
autocompletion for sdkman commands.

To install for fish shell with the popular fisher[^fisher] tool run 
```sh
fisher add reitzig/sdkman-for-fish
```

## Usage

Usage is illustrated in following examples in terms of Java SDKs, but adapting
the same commands for other SDKs should be quite simple given they follow the
same usage patterns.

- To see a list of all available SDK types,

  ```sh
  sdk list
  ```

- To get a list of available Java sdk versions,

  ```sh
  sdk list java
  ```

- To install a version of Java, after selecting a version using the above command,

  ```sh
  sdk install java 8.0.232.hs-adpt
  ```
  
- To remove sdk version,

  ```sh
  sdk rm java 8.0.232.hs-adpt
  ```

  `uninstall` also works in place of `rm`.

- How to change the default version globally,

  ```sh
  sdk default java 11.0.5.hs-adpt
  ```

- Using a specific version for a specific shell session without changing the
  default globally,

  ```sh
  sdk use java 8.0.232.hs-adpt
  ```

## Where to find the installed SDKs?

Candidates for a given SDK is found under the `candidates` directory in
`$SDKMAN_DIR`. For example, in Java SDKs,

- Location for JDK 11 from OpenJDK,
  ```sh
  $SDKMAN_DIR/candidates/java/11.0.5.hs-adpt`.
  ```
  
  Specific version locations are useful for setting up project specific JDKs in
  IDEs.
  
- Current version is a symbolic link to one of the instlaled candidates,

  ```sh
  $SDKMAN_DIR/candidates/java/current
  ```

It is useful to set the `JAVA_HOME` environment variable to always point to the
_current_ version.

- For bash/zsh shells,

  ```sh
  export JAVA_HOME='$SDKMAN_DIR/candidates/java/current'
  ```

- For fish shell,

  ```sh
  set -g -x JAVA_HOME '$SDKMAN_DIR/candidates/java/current'
  ```


## Footnotes

[^scala-java-8]: _Running vs compiling_ in [Scala JDK compatibility](https://docs.scala-lang.org/overviews/jdk-compatibility/overview.html).

[^fisher]: [fisher](https://github.com/jorgebucaran/fisher) - A package manager for the fish shell.
