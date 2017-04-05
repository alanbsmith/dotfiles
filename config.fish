#ruby-fish
source /usr/local/share/chruby/chruby.fish
source /usr/local/share/chruby/auto.fish

#minimalist rails app
#bundle commands
alias be="bundle exec"
alias bc="bundle check"
alias bi="bundle install"
alias bil="bundle install --local | bundle install"

#rake
alias rake="bundle exec rake"

#git commands
alias clc="git log -1 --pretty=format:%H | pbcopy"
alias amend="git commit --amend" # amend commit
alias gcm="git commit -m" # commit with message
alias ga="git add -A" # add everything
alias gs="git status" # git status
alias gas="git add -A; git status" # git add everything and show status
alias gcb="git checkout -b" # checkout a new branch
alias gb="git branch" # view local branches
alias gba="git branch -a" # view all branches
alias last="git log -1 --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # fancy commit log
alias gpom="git pull origin master" # pull down master
alias master="git checkout master" # switch to master branch
alias staging="git checkout staging" # switch to staging branch
alias gb-="git checkout -" # switch to previous branch
alias grm="git rebase master" # rebase you branch with master
alias rebase="git rebase -i" # interactive rebase
alias grh='git reset --hard' # reset all non-committed changes
alias push='git push origin HEAD' # push current branch
alias pull='git pull' # pull current branch"

source /usr/local/share/chruby/chruby.fish
source /usr/local/share/chruby/auto.fish

function fish_prompt
  set -l last_status $status

  # the time
  set_color normal --background FF16D1
  echo -n (date +" %I:%M %p ")
  set_color --background normal
  echo -n ' '

  # the path
  set_color normal --background FF16D1
  echo -n " "(pwd | sed s:$HOME:~:)" "
  set_color --background normal
  echo -n ' '

  # the git shell
  if git branch ^&- >&-
    set_color normal --background FF16D1
    echo -n (git branch --no-color ^ /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1 /')
    set_color --background normal
  end

  # the prompt depends on the last status
  if [ $last_status = 0 ]
    echo -n \n "🐠 ";
  else
    echo -n \n"🍣 " # sushi
    # other option: 🎣
  end
  set_color --background normal
  echo -n ' '

end

