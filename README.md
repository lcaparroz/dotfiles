# Dotfiles

Dotfiles for customization of `bash`, `vim` and `tmux`.

## Dependencies

The following softwares must be installed prior to configuring these dotfiles:

* **bash**
* **vim**
* **tmux**
* **xclip**
* **curl**

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

2. Run the installation script `install.sh`:

```sh
$ ~/.dotfiles/install.sh
```

## Troubleshooting

If any error occurs during installation, it will be logged to `~/.dotfiles.log`

[vim_tips_wiki]: http://vim.wikia.com/wiki/Accessing_the_system_clipboard
