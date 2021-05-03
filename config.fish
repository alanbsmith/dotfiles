set PATH /usr/local/bin $PATH
#!/usr/bin/ruby

#git commands
alias clean="git clean -d -f" # kill any new uncommitted directories
alias checkout="git checkout"
alias clc="git log -1 --pretty=format:%H | pbcopy"
alias sha="git log --format=format:%H"
alias amend="git commit --amend" # amend commit
alias gcm="git commit -m" # commit with message
alias gcempty="git commit --allow-empty -m" # empty commit with message
alias wip="git add -A; git status; git commit -m 'wip' --no-verify" # add and commit a wip commit
alias ga="git add -A" # add everything
alias gs="git status" # git status
alias gas="git add -A; git status" # git add everything and show status
alias gcb="git checkout -b" # checkout a new branch
alias gb="git branch" # view local branches
alias gba="git branch -a" # view all branches
alias last="git log -1 --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # fancy commit log
alias gpom="git pull origin master" # pull down master
alias gpum="git pull upstream master" # pull upstream master
alias master="git checkout master" # switch to master branch
alias staging="git checkout staging" # switch to staging branch
alias gb-="git checkout -" # switch to previous branch
alias grm="git rebase master" # rebase you branch with master
alias rebase="git rebase -i" # interactive rebase
alias grh='git reset --hard' # reset all non-committed changes
alias push='git push origin HEAD' # push current branch
alias pull='git pull' # pull current branch"
alias pr_template="curl https://gist.githubusercontent.com/alanbsmith/7f1d754ea78cd27533121ebf6bbb3c7e/raw/be541149780f60bbe14ad1bafbe99bba918b1999/PULL_REQUEST_TEMPLATE.md | pbcopy" # copy pr template to keyboard

function get_wd_deps
  ag "\@workday/canvas-\w+" $argv -o
end

function mkcd
  mkdir $argv; cd $argv
end

function clonecd
  set repo (basename $argv | string split -r -m1 .)[1];
  git clone $argv;
  cd $repo
end

# fetch a remote branch and make a local copy
function fetch_remote
  set parsed (basename $argv | string split -r -m1 ':');
  set user $parsed[1];
  set branch $parsed[2];
  set local $user-$branch;
  echo fetching $branch from $user;
  git fetch git@github.com:$user/canvas-kit.git $branch:$local;
  git checkout $local;
end

function push_remote
  set parsed (basename $argv | string split -r -m1 ':');
  set user $parsed[1];
  set branch $parsed[2];
  git push git@github.com:$user/canvas-kit HEAD:$branch
end


function pbsha1
  git show HEAD~$argv --pretty=format:"%H" --no-patch | pbcopy
  echo copied!
end

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
  if git branch 2>&- >&-
    set_color normal --background FF16D1
    echo -n (git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1 /')
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

function nvm
   bass source (brew --prefix nvm)/nvm.sh --no-use ';' nvm $argv
end

set -x NVM_DIR ~/.nvm
nvm use default --silent
rvm default
