# ebony-prompt.zsh — minimal, fast, git-aware
autoload -Uz colors
colors

# palette (use same muted values)
EB_BG="%F{245}"        # near charcoal (fallback)
EB_FG="%F{250}"        # off-white
EB_ACC="%F{28}"        # your #5D6658 mapped to zsh color index (may vary by terminal)
EB_DIM="%F{240}"
EB_RESET="%f%k"

# a tiny safe git branch function (fast)
git_branch() {
    local branch
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || return 1
    printf "%s" "$branch"
}

# short git status marker (clean/dirty)
git_dirty() {
    git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return 1
    if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
        printf "*"
    else
        printf ""
    fi
}

# PROMPT: two lines — user@host : cwd (line1) ; git + prompt symbols (line2)
PROMPT="%{$EB_FG%}%n%{$EB_DIM%}@%m %{$EB_RESET%}:%{$EB_ACC%}%~%{$EB_RESET%}\n"
RPROMPT='$( [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ] && echo "%{$EB_ACC%} $(git_branch)$(git_dirty)%{$EB_RESET%}" )'

# PS2 (continuation)
PS2="%{$EB_DIM%}→ %{$EB_RESET%}"

# Small niceties
setopt PROMPT_SUBST
zstyle ':completion:*' menu select
