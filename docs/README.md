<h1 align="center"><p>
  <a href="https://github.com/z-shell/zi">
    <img src="https://github.com/z-shell/zi/raw/main/docs/images/logo.svg" alt="Logo" width="80px" height="80px" />
  </a>
❮ Plugin - Zsh zoxide ❯
</p></h1>
<div align="center">
  <img align="center" src="https://user-images.githubusercontent.com/59910950/182589498-56f595c6-36d0-4c72-a02f-328018a37f74.gif" alt="ajeetdsouza/zoxide" width="100%" height="80%" />

<h2 align="center">The plugin calls <kbd><samp>zoxide init</samp></kbd> for Zsh.</p></h2>

<h3 align="center"><p><kbd>zoxide</kbd> is a smarter <kbd>cd</kbd> command, inspired by <kbd>z</kbd> and <kbd>autojump</kbd>.</p>
</h3>
</div>

## The <samp>[`ajeetdsouza/zoxide`](https://github.com/ajeetdsouza/zoxide)</samp>

### Environment variables

| Variable                   | Description                               | Default                                 |
| -------------------------- | ----------------------------------------- | --------------------------------------- |
| <kbd>\_ZO_CMD_PREFIX</kbd> | Set variable to preferred prefix          | Zi: <kbd>x</kbd>, other: <kbd>z</kbd>   |
| <kbd>\_ZO_DATA_DIR</kbd>   | Directory in which the database is stored | Zi: <kbd>$ZPFX/share</kbd>, other: none |

All environment variables: [ajeetdsouza/zoxide#environment-variables](https://github.com/ajeetdsouza/zoxide#environment-variables)

#### Eval-cache options

Before setting the environment variables, you must declare the associative array:

```shell
typeset -A ZEC
```

Set the following environment variables to change the default behavior:

| Variable                 | Description                                             | Default         |
| ------------------------ | ------------------------------------------------------- | --------------- |
| <kbd>ZEC[DISABLED]</kbd> | Disable eval-caching                                    | <kbd>0</kbd>    |
| <kbd>ZEC[DEBUG]</kbd>    | Enable debug mode for eval-caching                      | <kbd>0</kbd>    |
| <kbd>ZEC[MAX]</kbd>      | Maximum number to load from cache (until force refresh) | <kbd>1000</kbd> |

> Eval-cache files are stored in <kbd><samp>${Plugins[ZSH_ZOXIDE]}/.\_zoxide/\*</samp></kbd> directory.

### Install zoxide

- [Official install](https://github.com/ajeetdsouza/zoxide#step-1-install-zoxide) (recommended)
- With Zi:

```vim
zi ice as'null' from"gh-r" sbin
zi light ajeetdsouza/zoxide
```

> Wiki: install [fzf](https://wiki.zshell.dev/ecosystem/packages/usage#the-fzf-command-line-fuzzy-finder) command-line fuzzy finder as Zi package.

### Install **zsh-zoxide**

> **Note**: the alternative for <kbd>zsh-zoxide</kbd> is [🌀 eval annex](https://wiki.zshell.dev/ecosystem/annexes/eval)

#### [Standard syntax](https://wiki.zshell.dev/docs/guides/syntax/common#standard-syntax)

```vim
zi ice has'zoxide'
zi light z-shell/zsh-zoxide
```

#### [The "For" syntax](https://wiki.zshell.dev/docs/guides/syntax/for)

```vim
zi has'zoxide' light-mode for \
  z-shell/zsh-zoxide
```

#### [Turbo mode](https://wiki.zshell.dev/docs/getting_started/overview#turbo-mode-zsh--53) + "For" syntax

```vim
zi has'zoxide' wait lucid for \
  z-shell/zsh-zoxide
```

> Wiki: [automatic, condition based (loading/unloading)](https://wiki.zshell.dev/docs/getting_started/overview#automatic-condition-based---load--unload)

#### [Profile startup time](https://wiki.zshell.dev/docs/guides/benchmark)

After loading the plugin – shows profiling results and then unloads `zsh/zprof`

```vim
zi ice has'zoxide' atinit'zmodload zsh/zprof' \
  atload'zprof | head -n 20; zmodload -u zsh/zprof'
zi light z-shell/zsh-zoxide
```

### Environment variables and usage with Zi

The plugin will call <kbd>zoxide init</kbd> with prefixed commands <kbd>x</kbd>, <kbd>xi</kbd>:

- [x] Completions auto-loaded: [commands](https://wiki.zshell.dev/docs/guides/commands#completions-management), [ice-modifiers](https://wiki.zshell.dev/docs/guides/syntax/ice-modifiers#completions)
- [x] Manpage auto installed: [\$ZI[MAN_DIR]](https://wiki.zshell.dev/docs/guides/customization#customizing-paths)
- [x] [Database](https://github.com/ajeetdsouza/zoxide#environment-variables) directory set: [\$ZPFX/share](https://wiki.zshell.dev/community/zsh_plugin_standard#global-parameter-with-prefix), [customizing-paths](https://wiki.zshell.dev/docs/guides/customization#customizing-paths)

```sh
x foo              # cd into highest ranked directory matching foo
x foo bar          # cd into highest ranked directory matching foo and bar
x foo /            # cd into a subdirectory starting with foo
```

```sh
x ~/foo            # x also works like a regular cd command
x foo/             # cd into relative path
x ..               # cd one level up
x -                # cd into the previous directory
```

```sh
xi foo             # cd with interactive selection (using fzf)
```

```sh
x foo<SPACE><TAB>  # show interactive completions
```

### Environment variables and usage with other plugin managers

The plugin will call `zoxide init` with prefixed commands `z`, and `zi`.
