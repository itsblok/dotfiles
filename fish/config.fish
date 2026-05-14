set -gx EDITOR nvim
set -gx GOPATH $HOME/go

fish_add_path /usr/local/go/bin
fish_add_path $GOPATH/bin
fish_add_path $HOME/.local/bin

set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# don't show any greetings
set fish_greeting ""

# git prompt settings
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_char_stateseparator ' '
set -g __fish_git_prompt_char_dirtystate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_conflictedstate "+"
set -g __fish_git_prompt_color_dirtystate yellow
set -g __fish_git_prompt_color_cleanstate green --bold
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_branch cyan --dim 

#aliases
alias tm=sessionizer
alias k="kubectl"
alias kns="kubectl config set-context --current --namespace"
alias d="docker"
alias dc="docker compose"
alias g="git"

fzf --fish | source

zoxide init fish | source
direnv hook fish | source
starship init fish | source
