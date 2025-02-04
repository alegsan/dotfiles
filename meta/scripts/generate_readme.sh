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

Checkout repository and change to the dotfiles directory:

\`\`\`bash
git clone --recursive https://github.com/alegsan/dotfiles.git ~/.dotfiles && \\
  cd ~/.dotfiles
\`\`\`

Installing a predefined profile:

\`\`\`bash
./install --profile <profile>
\`\`\`

Installing single (or multiple) configuration:

\`\`\`bash
./install --standalone <configs...> [<configs...>]
\`\`\`

You can run these installation commands safely multiple times, if you think that will help you :-).

## Contents

### Profiles

\`\`\`
tree meta/profiles

$(print_tree "$ROOT_PATH/meta/profiles")
\`\`\`

### Configurations

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
