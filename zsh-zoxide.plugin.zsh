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

# Autoload functions
autoload -Uz .{zi,zsh}-prepare-zoxide

# TODO: Investigate variables and functions.
# Unset variables and functions which is not required after initialization.

# Check and prepare zsh-zoxide.
# Used only once when zsh-zoxide is installed, or then
# Plugins[ZSH_ZOXIDE_READY] reset to 0 to prevent full re-initialization
if (( ! Plugins[ZSH_ZOXIDE_READY] )); then
  # Set zoxide as ready to initiate.
  Plugins[ZSH_ZOXIDE_READY]=1
  # Returns 100 if missing dependencies.
  # Returns 110 for incorrect dependencies version.
  # Returns 102 if git submodule failed to be initialized.
  .zsh-prepare-zoxide
  exit_code=$?
  if (( exit_code )); then
    print "Failed to prepare zoxide, exit code: $exit_code"
    return $exit_code
  fi
  # Prepare for Zi.
  if (( ZI[SOURCED] )) && [[ -d $ZPFX ]]; then
    # Returns 101 if directory failed to be created.
    # Returns 201 failed to copy files.
    .zi-prepare-zoxide
    exit_code=$?
    if (( exit_code )); then
      print "Failed to prepare Zi, exit code: $exit_code"
      return $exit_code
    fi
  fi
fi

# TODO: Investigate variables for potential use.
# Set variable to preferred prefix.
: ${_ZO_CMD_PREFIX:=$_ZO_CMD_PREFIX}
# Directory in which the database is stored.
: ${_ZO_DATA_DIR:=$_ZO_DATA_DIR}
# When set to 1, x will print the matched directory before navigating to it.
# _ZO_ECHO
# Excludes the specified directories from the database.
# _ZO_EXCLUDE_DIRS
# Custom options to pass to fzf during interactive selection. See man fzf for the list of options.
# _ZO_FZF_OPTS
# Configures the aging algorithm, which limits the maximum number of entries in the database.
# _ZO_MAXAGE
# When set to 1, x will resolve symlinks before adding directories to the database.
# _ZO_RESOLVE_SYMLINKS

if (( ${+commands[zoxide]} )); then
  if [[ -n $_ZO_DATA_DIR ]]; then
    # If a parameter specified does not already exist, it is created in the global scope,
    # The variable is set to the absolute path of the directory.
    typeset -gx _ZO_DATA_DIR=${~_ZO_DATA_DIR}
  fi
  # TODO: Check zoxide exit codes for possible improvements.
  if [[ $_ZO_CMD_PREFIX =~ ^[a-zA-Z]*$ ]]; then
    # Set zoxide commands x, xi when using with Zi.
    eval "$(zoxide init --cmd $_ZO_CMD_PREFIX zsh)"
    exit_code=$?
  elif (( ! _ZO_CMD_PREFIX )); then
    eval "$(zoxide init zsh)"
    exit_code=$?
  fi
  if (( exit_code )); then
    print "Failed to initialize zoxide, exit code: $exit_code"
    return $exit_code
  fi
else
  print "Please install zoxide or make sure it is in your PATH"
  print "More info: https://github.com/ajeetdsouza/zoxide#installation"
  exit 1
fi
