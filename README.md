# Dotfiles

These dotfiles use [Dotbot](https://github.com/anishathalye/dotbot) for installation and are
based on [vsund dotfiles](https://github.com/vsund/dotfiles).

## Installation

```bash
git clone --recursive https://github.com/alegsan/dotfiles.git ~/.dotfiles && cd ~/.dotfiles
```

Installing a predefined profile:

```bash
./install --profile <profile>
```

Installing single (or multiple) configuration:

```bash
./install --standalone <configs...> [<configs...>]
```

You can run these installation commands safely multiple times, if you think that will help you :-).

## Contents

### Profiles

```
tree meta/profiles

/meta/profiles
├── ubuntu-generic
└── ubuntu-work-additions

0 directories, 2 files
```

### Configurations

```
tree meta/configs

/meta/configs
├── applications-work.yaml
├── applications.yaml
├── bin-work.yaml
├── community-package-manager.yaml
├── direnv-work.yaml
├── docker-apt.yaml
├── gdm-background.yaml
├── git-work.yaml
├── git.yaml
├── gnome-settings.yaml
├── gnome-terminal.yaml
├── gnucash.yaml
├── google-chrome.yaml
├── keepercommander-work.yaml
├── lauterbach-work.yaml
├── lazyvim.yaml
├── ssh-work.yaml
├── tig.yaml
└── zsh.yaml

0 directories, 19 files
```

### Dotfiles

```
tree -I 'meta|install|install-test|LICENSE|README.md|dotbot.git'


├── config
│   ├── git
│   │   ├── config
│   │   └── config-work
│   ├── nvim
│   │   └── lua
│   │       └── plugins
│   │           ├── colorscheme.lua
│   │           └── mason.lua
│   ├── tig
│   │   └── config
│   └── zsh
│       ├── aliases.zsh
│       ├── themes
│       │   └── powerline.zsh-theme
│       ├── zshenv-u015645
│       └── zshrc
├── etc
│   └── apt
│       └── sources.list.d
│           └── ubuntu-fallback.list
├── local
│   └── bin
│       ├── m-arm
│       ├── m-arm64
│       ├── ssh-multiplex.sh
│       └── switch-apt-sources.sh
├── opt
│   └── trace32
│       └── config_usb_proxy.t32
├── ssh
│   └── config
├── usr
│   └── local
│       └── bin
│           └── vzdump-hook-script
└── workspace
    └── git
        ├── barebox
        │   └── envrc
        ├── linux
        │   └── envrc
        └── u-boot
            └── envrc

24 directories, 20 files
```
