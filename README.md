# My dotfiles

This directory contains the dotfiles for my system

<p align="center">
  <img src="https://i.imgur.com/7YZLEIN.gif" alt="resulting config" width="70%" height="70%"/>
</p>

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

