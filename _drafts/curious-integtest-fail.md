---
title: "Curious integration test fail"
last_modified_at: 2020-01-01
comments: true
categories:
  - blog
tags:
  - programming
---

## macOS case insensitive

Recently I found.

```python
with open("fooBar.txt") as f:
    print(f.read())
```

Jenkins build server is running on Linux.

## Using CamelCase for Test Resources is not a good idea

When you are developing on macOS you will not detect these type of subtle errors
because of the nature of the macOS file system which is case-insensitive, but
case-preserving. This is a problem which I ran into at work where an ambiguosly
named file was passing the integration tests on the development machine, but
which failed on the Jenkins build server which runs on Linux. Latter is the
expected behaviour since most Linux file systems, by default, are case
sensitive.


## Background on case support in file systems

What is the history?
- DOS
- NTFS
- HFS
- Important Linux file systems' case support

## Why it is a bad idea to use resource files with camel case

- My contention is that it is better to use a name like `blacklist-ua.txt` than
  `blackListUA.txt`. Latter is susceptible to typos and not being detected as
  errors in a case-insensitive development environment such as macOS.
- Compiler cannot detect resource name errors - but isn't this mitigated by
  judiciously using constants instead of duplicating names? I think that's a
  good approach as well.
  
  There are two problems in my code then.
  - not using constants for the resource name
  - using tenous camel case resource names
