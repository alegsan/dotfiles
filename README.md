# Dotfiles

These dotfiles use [Dotbot](https://github.com/anishathalye/dotbot) for installation and are
based on [vsund dotfiles](https://github.com/vsund/dotfiles).

## Installation

```bash
❯ git clone --recursive https://github.com/alegsan/dotfiles.git ~/.dotfiles
```

For installing a predefined profile:

```bash
❯ cd ~/.dotfiles

# see meta/profiles/ for available profiles
❯ ./install-profile <profile> [<configs...>]
```

For installing single configurations:

```bash
# see meta/configs/ for available configurations
❯ ./install-standalone <configs...>
```

You can run these installation commands safely multiple times, if you think that helps with better installation.


## Contents

### Profiles

```
❯ tree meta/profiles

meta/profiles
├── notebook-hp-830-g5-privat
├── notebook-lenovo-p15s-work
└── pc-lenovo-thinkstation-work -> notebook-lenovo-p15s-work
```

### Dotbot configurations

```
❯ tree meta/configs

meta/configs
├── applications.yaml
├── bin.yaml
├── docker-apt.yaml
├── gdm-background.yaml
├── git-work.yaml
├── git.yaml
├── gnome-settings.yaml
├── gnome-terminal.yaml
├── keepercommander.yaml
├── lauterbach.yaml
├── nvim.yaml
├── tig.yaml
└── zsh.yaml
```

### Dotfiles

```
❯ tree -I meta -I install-profile -I install-standalone -I LICENSE -I README.md

.
├── config
│   ├── git
│   │   ├── config
│   │   └── config-work
│   ├── nvim
│   │   ├── init.lua
│   │   ├── lua
│   │   │   ├── config
│   │   │   │   ├── auto-session.lua
│   │   │   │   ├── bufferline.lua
│   │   │   │   ├── cmp.lua
│   │   │   │   ├── dashboard.lua
│   │   │   │   ├── doge.lua
│   │   │   │   ├── galaxyline.lua
│   │   │   │   ├── lsp
│   │   │   │   │   ├── go.lua
│   │   │   │   │   ├── init.lua
│   │   │   │   │   ├── lua.lua
│   │   │   │   │   ├── null-ls.lua
│   │   │   │   │   ├── python.lua
│   │   │   │   │   ├── rust.lua
│   │   │   │   │   ├── typescript.lua
│   │   │   │   │   └── utils.lua
│   │   │   │   ├── lspsaga.lua
│   │   │   │   ├── lualine.lua
│   │   │   │   ├── neogit.lua
│   │   │   │   ├── neorg.lua
│   │   │   │   ├── nlsp-settings.lua
│   │   │   │   ├── sniprun.lua
│   │   │   │   ├── symbols-outline.lua
│   │   │   │   ├── telescope.lua
│   │   │   │   ├── test.lua
│   │   │   │   ├── treesitter.lua
│   │   │   │   ├── vimspector.lua
│   │   │   │   └── which-key.lua
│   │   │   ├── defaults.lua
│   │   │   ├── keymappings.lua
│   │   │   ├── plugins.lua
│   │   │   ├── settings.lua
│   │   │   └── utils
│   │   │       └── cheatsheet.lua
│   │   └── stylua.toml
│   ├── tig
│   │   └── config
│   └── zsh
│       ├── aliases.zsh
│       ├── themes
│       │   └── powerline.zsh-theme
│       └── zshrc
├── etc
│   └── apt
│       └── sources.list.d
│           └── ubuntu-fallback.list
├── local
│   └── bin
│       └── switch-apt-sources.sh
└── opt
    └── trace32
        └── config_usb_proxy.t32
```
