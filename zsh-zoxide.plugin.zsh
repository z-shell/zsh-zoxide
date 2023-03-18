# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et
#
# Zsh Plugin Standard
# https://wiki.zshell.dev/community/zsh_plugin_standard#zero-handling
0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# https://wiki.zshell.dev/community/zsh_plugin_standard#standard-plugins-hash
typeset -gA Plugins
Plugins[ZSH_ZOXIDE]="${0:h}"

# https://wiki.zshell.dev/community/zsh_plugin_standard#funtions-directory
if [[ $PMSPEC != *f* ]]; then
  fpath+=( "${0:h}/functions" )
fi

# https://wiki.zshell.dev/community/zsh_plugin_standard#global-parameter-with-capabilities
if [[ $PMSPEC == *P* ]]; then
  _ZO_DATA_DIR=${ZPFX}/share
fi

# Check and prepare zsh-zoxide.
# Used only once when zsh-zoxide is installed, or then
# Plugins[ZSH_ZOXIDE_READY] reset to 0 to prevent full re-initialization
if (( ! Plugins[ZSH_ZOXIDE_READY] )); then
  autoload -Uz .zsh-prepare-zoxide
  # Set zoxide as ready to initiate.
  Plugins[ZSH_ZOXIDE_READY]=1
  # Returns 100 if missing dependencies.
  # Returns 110 for incorrect dependencies version.
  # Returns 102 if git submodule failed to be initialized.
  .zsh-prepare-zoxide || {
    print "Failed to prepare zsh-zoxide, exit code: $?"
    return $?
  }

  # Prepare for Zi.
  if (( ZI[SOURCED] )) && [[ -d $ZPFX ]]; then
    # Returns 101 if directory failed to be created.
    # Returns 201 failed to copy files.
    autoload -Uz .zi-prepare-zoxide
    .zi-prepare-zoxide || {
      print "Failed to prepare Zi, exit code: $?"
      return $?
    }
  fi

  unfunction .zsh-prepare-zoxide .zi-prepare-zoxide &> /dev/null
fi

# Set variable to preferred prefix.
: ${_ZO_CMD_PREFIX:=$_ZO_CMD_PREFIX}
# Directory in which the database is stored.
: ${_ZO_DATA_DIR:=$_ZO_DATA_DIR}
# When set to 1, x will print the matched directory before navigating to it.
: ${_ZO_ECHO:=$_ZO_ECHO}
# Excludes the specified directories from the database.
: ${_ZO_EXCLUDE_DIRS:=$_ZO_EXCLUDE_DIRS}
# Custom options to pass to fzf during interactive selection. See man fzf for the list of options.
: ${_ZO_FZF_OPTS:=$_ZO_FZF_OPTS}
# Configures the aging algorithm, which limits the maximum number of entries in the database.
: ${_ZO_MAXAGE:=$_ZO_MAXAGE}
# When set to 1, x will resolve symlinks before adding directories to the database.
: ${_ZO_RESOLVE_SYMLINKS:=$_ZO_RESOLVE_SYMLINKS}

# Initialize zoxide.
if (( ! $+commands[zoxide] )); then
  print "Please install zoxide or make sure it is in your PATH"
  print "More info: https://github.com/ajeetdsouza/zoxide#installation"
  exit 1
fi

if [[ -n $_ZO_DATA_DIR ]]; then
  # If a parameter specified does not already exist, it is created in the global scope,
  # The variable is set to the absolute path of the directory.
  typeset -gx _ZO_DATA_DIR=${~_ZO_DATA_DIR}
fi

# Autoload zsh-eval-cache.
autoload -Uz @zsh-eval-cache

if [[ -n $_ZO_CMD_PREFIX ]]; then
  # Set zoxide commands x, xi when using with Zi.
  @zsh-eval-cache zoxide init --cmd $_ZO_CMD_PREFIX zsh
else
  # Default zoxide commands z, zi when not using with Zi.
  @zsh-eval-cache zoxide init zsh
fi
