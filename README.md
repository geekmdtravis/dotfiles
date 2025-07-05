# My Dotfiles

My personal dotfiles, managed with `stow`.

## About Me

- **Name**: Travis Nesbit, MD
- **GitHub**: [geekmdtravis](https://github.com/geekmdtravis)

## The Tool `tool_check.sh`

This script is used to check if my most commonly used tools are installed on my system.

## Managed Applications

This repository contains configurations for the following applications:

- Aider
- Ghostty
- Git
- i3
- Neovim
- Tmux
- Zsh

## Installation

To use these dotfiles, you will need to have `stow` installed. Then, you can clone this repository and use `stow` to create symbolic links to the configuration files in your home directory.

This repository uses submodules for some of the plugins. To get everything set up correctly, follow these steps:

1.  **Clone the repository:**

    ```bash
    git clone --recurse-submodules https://github.com/geekmdtravis/dotfiles.git
    cd dotfiles
    ```

2.  **Install the dotfiles using `stow`:**

    ```bash
    stow .
    ```

3.  **If you have already cloned the repository without the submodules, you can initialize them with:**

    ```bash
    git submodule init
    git submodule update
    ```


