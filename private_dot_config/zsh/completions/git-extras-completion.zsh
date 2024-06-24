# ------------------------------------------------------------------------------
# Description
# -----------
#
#  Completion script for git-extras (https://github.com/tj/git-extras).
#
#  This depends on and reuses some of the internals of the _git completion
#  function that ships with zsh itself. It will not work with the _git that ships
#  with git.
#
# ------------------------------------------------------------------------------
# Authors
# -------
#
#  * Alexis GRIMALDI (https://github.com/agrimaldi)
#  * spacewander (https://github.com/spacewander)
#
# ------------------------------------------------------------------------------
# Inspirations
# -----------
#
#  * git-extras (https://github.com/tj/git-extras)
#  * git-flow-completion (https://github.com/bobthecow/git-flow-completion)
#
# ------------------------------------------------------------------------------


# Internal functions
# These are a lot like their __git_* equivalents inside _git

__gitex_command_successful () {
  if (( ${#*:#0} > 0 )); then
    _message 'not a git repository'
    return 1
  fi
  return 0
}

    _git-changelog() {
        _arguments \
            '(-l --list)'{-l,--list}'[list commits]' \
    }

    _git-nuke() {
        _arguments \
            '(-f --force)'{-f,--force}'[force clear]' \
            '(-h --help)'{-h,--help}'[help message]' \
    }

    _git-coauthor() {
        _arguments \
            ':co-author[co-author to add]:__gitex_author_names' \
            ':co-author-email[email address of co-author to add]:__gitex_author_emails'
    }

    _git-contrib() {
        _arguments \
            ':author:__gitex_author_names'
    }

_git-ignore() {
    _arguments -C \
        '(--local -l)'{--local,-l}'[show local gitignore]' \
        '(--global -g)'{--global,-g}'[show global gitignore]' \
        '(--private -p)'{--private,-p}'[show repo gitignore]' \
        '*:filename:_files'
}


_git-info() {
    _arguments -C \
        '(--color -c)'{--color,-c}'[use color for information titles]' \
        '--no-config[do not show list all variables set in config file, along with their values]'
}


_git-standup() {
    _arguments -C \
        '-a[Specify the author of commits. Use "all" to specify all authors.]' \
        '-d[Show history since N days ago]' \
        '-D[Specify the date format displayed in commit history]' \
        '-f[Fetch commits before showing history]' \
        '-g[Display GPG signed info]' \
        '-h[Display help message]' \
        '-L[Enable the inclusion of symbolic links]' \
        '-m[The depth of recursive directory search]' \
        '-B[Display the commits in branch groups]'
}

_git-summary() {
    _arguments '--line[summarize with lines rather than commits]'
    _arguments '--dedup-by-email[remove duplicate users by the email address]'
    _arguments '--no-merges[exclude merge commits]'
    __gitex_commits
}


zstyle -g existing_user_commands ':completion:*:*:git:*' user-commands

zstyle ':completion:*:*:git:*' user-commands $existing_user_commands \
    browse:'open repo website in browser' \
    coauthor:'add a co-author to the last commit' \
    branch-delete:'delete branches' \
    branch-rename:'rename a branch' \
    contrib:'show user contributions' \
    changelog:'generate a changelog report' \
    ignore:'view .gitignore patterns' \
    ignogen:'add .gitignore patterns' \
    info:'returns information on current repository' \
    nuke:'rigorously clean up a repository' \
    setup:'set up a git repository' \
    standup:'recall the commit history' \
    rewrite-history:'recall the commit history' \
    sync-this-repo:'sync local branch with remote branch' \
    touch:'touch and add file to the index' \
    up:'Like git-pull but show a short and sexy log of changes' \
    undo:'remove latest commits' \
