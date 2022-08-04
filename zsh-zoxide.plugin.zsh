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

# Autoload functions
autoload -Uz "${0:h}/functions"/.*(.:t)

if [[ ! -f ${Plugins[ZSH_ZOXIDE]}/man/man1/zoxide.1 ]]; then
  command git submodule --quiet init
  command git submodule --quiet update
  if [[ ! -f ${Plugins[ZSH_ZOXIDE]}/man/man1/zoxide-add.1 ]]; then
    print "Failed to initiate git submodules"
    return 1
  fi
fi

# When using Zi:
.zi-prepare-zoxide

# TODO: Env variables
# If not set for Zi use default or user prefered.
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

# Expand any tilde in the path.
export _ZO_DATA_DIR=${~_ZO_DATA_DIR}

# TODO: Output failures
if (( $+commands[zoxide] )); then
  if [[ $_ZO_CMD_PREFIX =~ ^[a-zA-Z]*$ ]]; then
    eval "$(zoxide init zsh --cmd $_ZO_CMD_PREFIX)"
  else
    eval "$(zoxide init zsh)"
  fi
fi
