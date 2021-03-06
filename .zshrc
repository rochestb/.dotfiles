export NVM_DIR="$HOME/.nvm"
export TERM=xterm-color

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
ZSH=$HOME/.oh-my-zsh
# Path to your oh-my-zsh configuration.
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bira"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)


# Set git autocompletion and PS1 integration
if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
fi
if [ -f /opt/local/share/doc/git-core/contrib/completion/git-prompt.sh ]; then
    . /opt/local/share/doc/git-core/contrib/completion/git-prompt.sh
fi
GIT_PS1_SHOWDIRTYSTATE=true

alias gs="git status"
alias gp="git push origin"


function detect_git_dirty {
  local git_status=$(git status 2>&1 | tail -n1)
  [[ $git_status != "fatal: Not a git repository (or any of the parent
  directories): .git" ]] && [[ $git_status != "nothing to commit (working
  directory clean)" ]] && echo "*"
}

function detect_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/"
}
function dev_info {
  echo "[$(detect_git_branch)$(detect_git_dirty)]"
}

source $ZSH/oh-my-zsh.sh

alias tails='tail -f log/development.log'
alias ebash='vim ~/.bash_profile'
alias rebash='. ~/.bash_profile'
alias ehosts='sudo mvim /etc/hosts'
alias tmamp='tail -f /Applications/MAMP/logs/*'
alias tache='tail -f /var/log/apache2/*'
alias vinstall= 'vim +PluginInstall +qall'
alias vimrc='vim ~/.vimrc'
alias gvimrc='vim ~/.gvimrc'
alias rmlogs="sudo rm -f /private/var/log/asl/*.asl"
alias ephp="sudo vim /etc/php.ini"
alias apr="sudo apachectl restart"
alias iphone="open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app"
alias ngxweb="sudo nginx -g 'daemon off;' -c nginx.conf -p ~/Development/VO/webclient-server"
alias ngxwebd="sudo nginx -g -c nginx.conf -p ~/Development/VO/webclient-server"
alias ngxstop="sudo nginx -s stop"
alias updateVUI= "cd ~/Development/VO/victory-ui/ && npm version patch && npm publish && git push upstream HEAD:master --tags"
alias clearStaging= "ssh repl1.stg.den02.victorops.net 'rm -rf .amm .ammonite'"
alias clearProd= "ssh repl1.pr.den02.victorops.net 'rm -rf .amm .ammonite'"
alias clearManual= "rm -rf .ammonite .amm"
alias repl="~/Development/VO/platform-repl/scripts/repl stage"
alias webvi="vim ~/Development/VO/webclient"
alias webbuild="cd ~/Development/VO/webclient && npm run build:watch"
alias gtw="cd ~/Development/VO/webclient"
alias gtv="cd ~/Development/VO/victory-ui"
alias nb="git checkout development && git pull upstream development && git checkout -b"
alias gcp="git cherry-pick"
alias linked="ls -la /Users/brochester/Development/VO/webclient/node_modules/@victorops | grep '\->'"
#alias killnginx ="sudo kill $(ps aux | grep '[n]ginx' | awk '$2')"

function getOption() {
  PS3='Please enter your choice: '
  options=("Option 1" "Option 2" "Option 3" "Quit")
  select opt in "${options[@]}"
  do
    case $opt in
      "Option 1")
        echo "you chose choice 1"
        ;;
      "Option 2")
        echo "you chose choice 2"
        ;;
      "Option 3")
        echo "you chose choice 3"
        ;;
      "Quit")
        break
        ;;
      *) echo invalid option;;
    esac
  done
}

function gitURL {
  if [[ "$(git config remote.upstream.url)" != "" ]]; then
    echo $(git config remote.upstream.url | cut -d: -f2-3 | cut -d. -f1)
  else
    echo $(git config remote.origin.url | cut -d: -f2-3 | cut -d. -f1)
  fi
}

function create_ssh_pr {
  branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
  echo "https://github.com/"$(gitURL)"/compare/development...rochestb:$branch"
}

alias opr='open -a /Applications/Google\ Chrome.app $(create_ssh_pr)'

function create_branch_pr {
  branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
  remote=$(git config remote.origin.url | cut -d. -f1-2)
  echo "$remote/compare/develop...$branch"
}


rcg () {
  git rev-list --reverse $1..$2 . | git cherry-pick --strategy=recursive -X theirs --stdin
}

rnext () {
  git reset && git cherry-pick --continue
}

alias ophr='open -a /Applications/Google\ Chrome.app $(create_branch_pr)'

connectMe () {
  open -a /Applications/Google\ Chrome.app 'https://victorops.atlassian.net/secure/RapidBoard.jspa?projectKey=PBJ'
  open -a /Applications/Google\ Chrome.app 'https://mail.google.com/mail/u/1/#inbox'
  open -a /Applications/Google\ Chrome.app 'https://mail.google.com/mail/u/0/#inbox'
}

myprs () {
  open -a /Applications/Google\ Chrome.app 'https://github.com/pulls/review-requested'
}

ob () {
  open -a /Applications/Google\ Chrome.app 'https://github.com/victorops/webclient/tree/'$(detect_git_branch)'/'$1
}

ojt () {
  open -a /Applications/Google\ Chrome.app 'https://victorops.atlassian.net/browse/'$(detect_git_branch)
}

ojb () {
  open -a /Applications/Google\ Chrome.app 'https://victorops.atlassian.net/secure/RapidBoard.jspa?projectKey=PBJ'
}

oj () {
 open -a /Applications/Google\ Chrome.app 'https://victorops.atlassian.net/browse/'$1
}

getUnused () {
  awk '{for (I=1;I<=NF;I++) if ($I == "unused" && index($NF, "node_modules") == 0 ) { print $(I+0) " " $(I+1) " " $(I+2) " ------------->  " $(I+3) " " $(NF)};}' $1
}

commit () {
  git commit -m "$(detect_git_branch) - $1"
}

ggrep () {
  git grep "$1"
}

gapp () {
  git grep -nr "$1" js/app"$2"
}
gadmin () {
  git grep -nr "$1" js/admin"$2"
}
gcomp () {
  git grep -nr "$1" js/components"$2"
}
gscss () {
  git grep -nr "$1" scss"$2"
}
