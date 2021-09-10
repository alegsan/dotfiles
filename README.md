# Dotfiles

These dotfiles use [Dotbot](https://github.com/anishathalye/dotbot) for installation and are
based on [vsund dotfiles](https://github.com/vsund/dotfiles).

## Installation

```bash
~$ git clone --recursive https://gitlab.com/alegsan/dotfiles.git ~/.dotfiles
```

For installing a predefined profile:

```bash
~/.dotfiles$ ./install-profile <profile> [<configs...>]
# see meta/profiles/ for available profiles
```

For installing single configurations:

```bash
~/.dotfiles$ ./install-standalone <configs...>
# see meta/configs/ for available configurations
```

You can run these installation commands safely multiple times, if you think that helps with better installation.


## Contents

### Profiles

```
meta/profiles/
├── notebook-home
└── notebook-work
```

### Dotbot configurations

```
meta/configs/
├── applications-apt.yaml
├── applications-pacman.yaml
├── bin.yaml
├── docker-apt.yaml
├── git-work.yaml
├── git.yaml
├── greenclip.yaml
├── lauterbach.yaml
├── polybar.yaml
├── regolith.yaml
├── tig.yaml
└── vim.yaml
```

### Dotfiles

```
config/
├── git
│   ├── config
│   └── config-work
├── polybar
│   ├── config
│   ├── launch.sh
│   └── scripts
│       └── popup-calendar.sh
├── regolith
│   ├── i3
│   │   └── config
│   ├── i3xrocks
│   │   └── conf.d
│   │       ├── 01_setup
│   │       ├── 10_nm-vpn
│   │       ├── 40_cpu-usage
│   │       ├── 50_memory
│   │       ├── 80_battery
│   │       ├── 80_rofication
│   │       └── 90_time
│   ├── Xresources
│   └── Xresources-regolith
├── tig
│   └── config
└── walls
    ├── grey-hd.jpg
    └── wallpaper -> grey-hd.jpg
etc/
└── apt
    └── sources.list.d
        └── ubuntu-fallback.list
local/
└── bin
    └── exchange-gateway.sh
opt/
└── trace32
    └── config_usb_proxy.t32
```
