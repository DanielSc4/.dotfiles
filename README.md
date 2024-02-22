# My dotfiles

This directory contains the dotfiles for my system

![Resulting config](https://imgur.com/a/qjpO6Pq)

## Requirements

- `git`, ofc
- `stow` to create symlinks

## Installation

First, check out the dotfiles repo in your $HOME directory

```
$ git clone git@github.com:DanielSc4/.dotfiles.git
$ cd .dotfiles
```

then, using GNU stow, create symlinks from $HOME to the .dotfiles directory

```
$ stow .
```

GNU stow will place symlinks into the parent directory of where you run it ($HOME in this case).

