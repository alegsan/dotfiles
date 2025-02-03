#!/bin/bash

# Function to print the tree structure of a directory
print_tree() {
  local dir=$1
  tree -I 'meta|install|install-test|LICENSE|README.md|dotbot.git' "$dir" | sed "s|$ROOT_PATH||"
}

# Determine the root path of the git repository
ROOT_PATH=$(git rev-parse --show-toplevel)

# Print the README content
cat <<EOF
# Dotfiles

These dotfiles use [Dotbot](https://github.com/anishathalye/dotbot) for installation and are
based on [vsund dotfiles](https://github.com/vsund/dotfiles).

## Installation

\`\`\`bash
git clone --recursive https://github.com/alegsan/dotfiles.git ~/.dotfiles
\`\`\`

For installing a predefined profile:

\`\`\`bash
cd ~/.dotfiles

# see meta/profiles/ for available profiles
./install --profile <profile>
\`\`\`

For installing single configurations:

\`\`\`bash
cd ~/.dotfiles

# see meta/configs/ for available configurations
./install --standalone <configs...>
\`\`\`

You can run these installation commands safely multiple times, if you think that helps :-).

## Contents

### Profiles

\`\`\`
tree meta/profiles

$(print_tree "$ROOT_PATH/meta/profiles")
\`\`\`

### Dotbot configurations

\`\`\`
tree meta/configs

$(print_tree "$ROOT_PATH/meta/configs")
\`\`\`

### Dotfiles

\`\`\`
tree -I 'meta|install|install-test|LICENSE|README.md|dotbot.git'

$(print_tree "$ROOT_PATH")
\`\`\`
EOF
