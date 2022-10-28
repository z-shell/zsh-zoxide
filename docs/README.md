<h1 align="center"><p>
  <a href="https://github.com/z-shell/zi">
    <img src="https://github.com/z-shell/zi/raw/main/docs/images/logo.svg" alt="Logo" width="80px" height="80px" />
  </a>
❮ Plugin - Zsh zoxide ❯
</p></h1>
<h2 align="center"><p><code>zoxide</code> is a smarter <code>cd</code> command, inspired by <code>z</code> and <code>autojump</code>.</p>
<p>The plugin calls <code>zoxide init</code> for Zsh.</p></h2>
<div align="center">
  <img align="center" src="https://user-images.githubusercontent.com/59910950/182589498-56f595c6-36d0-4c72-a02f-328018a37f74.gif" alt="ajeetdsouza/zoxide" width="100%" height="auto" />
</div>

## The [`ajeetdsouza/zoxide`](https://github.com/ajeetdsouza/zoxide)

### Install zoxide

- [Official install](https://github.com/ajeetdsouza/zoxide#step-1-install-zoxide) (recommended)
- With Zi:

```zsh
zi ice as'null' from"gh-r" sbin
zi light ajeetdsouza/zoxide
```

> Wiki: install [fzf](https://wiki.zshell.dev/ecosystem/packages/usage#the-fzf-command-line-fuzzy-finder) command-line fuzzy finder as Zi package.

### Install zsh-zoxide

#### [Standard syntax](https://wiki.zshell.dev/docs/guides/syntax/common#standard-syntax)

```zsh
zi ice has'zoxide'
zi light z-shell/zsh-zoxide
```

#### [The "For" syntax](https://wiki.zshell.dev/docs/guides/syntax/for)

```zsh
zi has'zoxide' light-mode for \
  z-shell/zsh-zoxide
```

#### [Turbo mode](https://wiki.zshell.dev/docs/getting_started/overview#turbo-mode-zsh--53) + "For" syntax

```zsh
zi has'zoxide' wait lucid for \
  z-shell/zsh-zoxide
```

> Wiki: [automatic, condition based (loading/unloading)](https://wiki.zshell.dev/docs/getting_started/overview#automatic-condition-based---load--unload)

### Environment variables and usage with Zi

The plugin will call `zoxide init` with prefixed commands `x`, `xi`:

- [x] Completions auto-loaded: [commands](https://wiki.zshell.dev/docs/guides/commands#completions-management), [ice-modifiers](https://wiki.zshell.dev/docs/guides/syntax/ice-modifiers#completions)
- [x] Manpages auto installed: [\$ZI[MAN_DIR]](https://wiki.zshell.dev/docs/guides/customization#customizing-paths)
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
