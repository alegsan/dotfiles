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
└── workstation
```

### Dotbot configurations

```
meta/configs/
├── applications-pacman.yaml
├── i3.yaml
├── lightdm.yaml
├── picom.yaml
├── polybar.yaml
├── termite.yaml
└── wall.yaml
```

### Dotfiles

```
gui
├── i3
│   └── config
├── lightdm
│   └── lightdm-gtk-greeter.conf
├── picom
│   └── picom.conf
├── polybar
│   ├── config
│   ├── launch.sh
│   └── scripts
│       └── popup-calendar.sh
└── walls
    ├── grey-hd.jpg
    └── wall.jpg -> grey-hd.jpg

terminals
└── termite
    └── config
```
