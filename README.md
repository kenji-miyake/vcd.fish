# vcd.fish

vcstool-cd for fish-shell

## Prerequisites

- [fzf](https://github.com/junegunn/fzf)
- [fd](https://github.com/sharkdp/fd)
- [jq](https://github.com/stedolan/jq)

### Using apt (Ubuntu 20.04)

```sh
sudo apt install fzf fd-find jq
sudo ln -snfv /usr/bin/fdfind /usr/bin/fd
```

### Using Homebrew / Linuxbrew

```sh
brew install fzf fd jq
```

## Installation

### Using fisher (recommended)

```sh
fisher install kenji-miyake/vcd.fish
```

### Using local-install script (for development)

```sh
git clone git@github.com:kenji-miyake/vcd.fish.git
cd vcd.fish
./install
```

## Usage

This package provides `vcd` and `ccd` commands for workspaces set up by [`vcstool`](https://github.com/dirk-thomas/vcstool).

### `vcd`

`vcd` is a command for moving to vcs repositories in a workspace.

```sh
cd {vcstool_workspace_dir}
vcd <Tab>
# or use Ctrl-V key bindings
```

![vcd.gif](/images/vcd.gif)

This command reads setting files to find repositories and supports two modes.

1. `repos`: use `.repos` files to find directories
2. `workspace`: use `.code-workspace` files to find directories

To switch the mode, please set `$VCD_MODE`.

```sh
# To use repos mode (default)
set -U VCD_MODE repos

# To use workspace mode
set -U VCD_MODE code-workspace

# To use gitmodules mode
set -U VCD_MODE gitmodules
```

> Note
>
> To use workspace mode, you need to prepare `.code-workspace` file, which is a workspace-config file of VSCode.
> It can be generated from `.repos` file using [`repos2workspace.py`](https://github.com/kenji-miyake/vscode-utils#repos2workspacepy).
>
> ```sh
> cd vcd.fish
> wget -P /tmp https://raw.githubusercontent.com/kenji-miyake/vscode-utils/main/repos2workspace.py
> python3 /tmp/repos2workspace.py YOUR_COLCON_WORKSPACE/YOUR_REPOS_FILE.repos
> ```

### `ccd`

`ccd` is a command for moving to colcon packages in a workspace.

```sh
cd {vcstool_workspace_dir}
ccd -s <Tab> # To move under src directory
ccd -i <Tab> # To move under install directory
ccd <Tab> # To move according to the default mode
# or use Ctrl-Alt-V key bindings
```

![ccd.gif](/images/ccd.gif)

To switch the default mode, please set `$CCD_DEFAULT_MODE`.

```sh
# To use src mode (default)
set -U CCD_DEFAULT_MODE src

# To use install mode
set -U CCD_DEFAULT_MODE install
```

## Tips

### Using from outside of workspaces

This tool can find workspaces based on `$COLCON_PREFIX_PATH` or `$CMAKE_PREFIX_PATH`.  
If you source `setup.bash`, you can use commands from outside of workspaces.

```sh
bass source {vcstool_workspace_dir}/install/setup.bash
# use commands from everywhere
```

![colcon-workspace.gif](/images/colcon-workspace.gif)

### Disable key bindings

If you'd like to disable key bindings, set `VCD_DISABLE_KEYBINDINGS` and/or `CCD_DISABLE_KEYBINDINGS`.

```sh
set -U VCD_DISABLE_KEYBINDINGS
set -U CCD_DISABLE_KEYBINDINGS
```

To re-enable,

```sh
set -e VCD_DISABLE_KEYBINDINGS
set -e CCD_DISABLE_KEYBINDINGS
```
