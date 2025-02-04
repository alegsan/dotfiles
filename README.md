# Dotfiles

These dotfiles use [Dotbot](https://github.com/anishathalye/dotbot) for installation and are
based on [vsund dotfiles](https://github.com/vsund/dotfiles).

## Installation

```bash
git clone --recursive https://github.com/alegsan/dotfiles.git ~/.dotfiles
```

For installing a predefined profile:

```bash
cd ~/.dotfiles

# see meta/profiles/ for available profiles
./install --profile <profile>
```

For installing single configurations:

```bash
cd ~/.dotfiles

# see meta/configs/ for available configurations
./install --standalone <configs...>
```

You can run these installation commands safely multiple times, if you think that helps :-).

## Contents

### Profiles

```
tree meta/profiles

/meta/profiles
├── ubuntu-generic
└── ubuntu-work-additions

1 directory, 2 files
```

### Dotbot configurations

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

1 directory, 19 files
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

25 directories, 20 files
```
