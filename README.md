# Dotfiles

Dotfiles for customization of `bash`, `vim` and `tmux`.

## Dependencies

The following software must be installed prior to configuring these dotfiles:

### Common (cross OS)

* [bash](https://www.gnu.org/software/bash/) (GNU Project's shell)
* [bat](https://github.com/sharkdp/bat) (`cat` clone)
* [curl](https://curl.se) (CLI tool for transferring data)
* [emacs](https://www.gnu.org/software/emacs) (secondary editor, still learning)
* [fd](https://github.com/sharkdp/fd) (fast alternative to `find`)
* [fzf](https://github.com/junegunn/fzf) (command line fuzzy finder)
* [git-delta](https://github.com/dandavison/delta) (syntax-highlighting pager for git)
* [hunspell](https://github.com/hunspell/hunspell) (command line spell checker)
* [kitty](https://github.com/kovidgoyal/kitty) (GPU based terminal emulator)
* [python3](https://www.python.org) (programming language)
* [ripgrep](https://github.com/BurntSushi/ripgrep) (fast alternative to `grep`)
* [tig](https://github.com/jonas/tig) (text-mode interface for git)
* [tmux](https://github.com/tmux/tmux) (terminal multiplexer)
* [vim](https://www.vim.org) (primary editor)

#### Font

Currently, using [JetBrains Mono Nerd Fonts](https://github.com/ryanoasis/nerd-fonts).

See [Installation/Font](#font) for instructions on how to intall.

### Linux

* [i3](https://i3wm.org) (window manager)
* [rofi](https://github.com/davatorium/rofi) (window switcher, application launcher)
* nm-applet (network manager applet)
* xclip (to allow tmux copying to system clipboard)

### macOS

* pbcopy (to allow tmux copying to system clipboard)

Optional:

To make `vim` yank to clipboard by default, check if it was compiled to support
clipboard (tip from [Vim Tips Wiki][vim_tips_wiki]). Run the following command:

```sh
$ vim --version | grep clipboard
```

If output shows `+clipboard` or `+xterm_clipboard`, `vim` supports clipboard and
no further software is required.

However, if outputs show `-clipboard` or `-xterm_clipboard`, `vim` does not
support clipboard. On [Vim Tips Wiki][vim_tips_wiki] there are some solutions.
On Fedora 26, installing `vim-X11` worked fine.

## Installation

1. Clone this repository to the directory `~/.dotfiles`:

```sh
$ git clone --depth=5 https://github.com/lcaparroz/dotfiles.git ~/.dotfiles
```

2. Run the installation script `install`:

```sh
$ ~/.dotfiles/install
```

### Fonts

To install the required fonts for these dotfiles, run the script below:

```sh
$ ~/.dotfiles/linux/share/fonts/install.sh
```

### Language Dictionaries

In order to the `ispell` command to work properly with `hunspell` in `emacs`,
there must be some dictionary files under a specific directory (set in the
`DICPATH`).

There is a script for downloading and installing the dictionaries. You can
execute it with the following command:

```sh
$ ~/.dotfiles/share/dictionaries/install.sh
```

The same script can be used to "update" the dictionaries (though I guess they
are not frequently updated).

P.S.: I decided to do not install the dictionaries automatically, because some
files have more than 50 MB (e.g.: `pt_BR` dictionary). As I often modify my
dotfiles and execute the `install.sh` script, downloading dictionaries everytime
is a costly operation.

### Linux

Using i3 requires some extra steps to configure hardware. The following commands
allow configuring a touchpad (for laptops) and a Logitech Marble Trackball.

```sh
export DOTFILES_DIR="${HOME}/.dotfiles" && sudo -E ./linux/share/xorg/config.sh
```

Notice that it must be run as `root`, if the Xorg configuration directory
already exists, it probably is owned by the `root` user. Otherwise, the script
will not correctly create the directory and symbolic links with `root`
credentials.

## Troubleshooting

If any error occurs during installation, it will be logged to `~/.dotfiles.log`

[vim_tips_wiki]: http://vim.wikia.com/wiki/Accessing_the_system_clipboard
