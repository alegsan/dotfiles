# Dotfiles

These dotfiles use [Dotbot](https://github.com/anishathalye/dotbot) for installation and are
based on [vsund dotfiles](https://github.com/vsund/dotfiles).

## Installation

Checkout repository and change to the dotfiles directory:

```bash
git clone --recursive https://github.com/alegsan/dotfiles.git ~/.dotfiles && \
  cd ~/.dotfiles
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

1 directory, 2 files
```

### Configurations

```
tree meta/configs

/meta/configs
├── applications-work.yaml
├── applications.yaml
├── bin-work.yaml
├── clang-format.yaml
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
├── zsh-work.yaml
└── zsh.yaml

1 directory, 21 files
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
│   │       ├── config
│   │       │   └── options.lua
│   │       └── plugins
│   │           ├── colorizer.lua
│   │           ├── colorscheme.lua
│   │           ├── conform.lua
│   │           ├── lsp.lua
│   │           ├── mason.lua
│   │           ├── nvim-lint.lua
│   │           └── snacks.lua
│   ├── tig
│   │   └── config
│   └── zsh
│       ├── aliases.zsh
│       ├── themes
│       │   └── powerline.zsh-theme
│       ├── zshenv-personal
│       ├── zshenv-work
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
        ├── labgrid.basesoftware
        │   └── envrc
        ├── linux
        │   └── envrc
        └── u-boot
            ├── clang-format
            └── envrc

27 directories, 29 files
```
