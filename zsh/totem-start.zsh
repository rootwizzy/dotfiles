# ### Totem Server Starter
# Simply run `totem-start-#{platform}` and assuming they are defined it will start all the correct servers.
#  => e.g. totem-start-thinkspace,  must have totem-start-thinkspace, totem-set-thinkspace defined in .bashrc
#
# Note: If you want your non-server terminals to have tab names set correctly, go to:
#       => (new terminal) -> Edit -> Title and Command -> and set the "When terminal commands set..." to "Keep intial title" 

# ### Note (JF): Removed until we can support both old/new formats.
# export TOTEM_REPOS=~/projects/repos
# ### Totem::Git
# function gsa { 
#   for dir in $TOTEM_REPOS/*/
#   do
#     printf "${blue}[Totem:GSA] git status in ${green}[${dir}]${normal}\n"
#     printf "${blue}##################################################${normal}\n"
#     cd $dir
#     git status
#   done
# }

# function totem-checkout-all {
#   if [ -z ${TOTEM_BRANCH+x} ]; then export TOTEM_BRANCH=development; fi
#   if [ -z ${TOTEM_ORIGIN+x} ]; then export TOTEM_ORIGIN=origin; fi

#   for dir in $TOTEM_REPOS/*/
#   do
#     printf "${blue}[Totem] Checkout out branch: ${green}[${TOTEM_BRANCH}] ${blue}in ${green}[${dir}]${normal}\n"
#     printf "${blue}##################################################${normal}\n"
#     cd $dir
#     git fetch origin
#     git checkout $TOTEM_BRANCH
#     git pull $TOTEM_ORIGIN $TOTEM_BRANCH
#   done
# }


  # gnome-terminal  --tab -e 'zsh -c "bash --init-file <(echo \". ~/.bash_profile; . ~/.bashrc; totem-start-rails-server;\")"' \
  #                 --tab -e 'bash -c "bash --init-file <(echo \". ~/.bash_profile; . ~/.bashrc; totem-navigate-rails-server;\")"' \
  #                 --tab -e 'bash -c "bash --init-file <(echo \". ~/.bash_profile; . ~/.bashrc; totem-navigate-rails-server;\")"' \
  #                 --tab -e 'bash -c "bash --init-file <(echo \". ~/.bash_profile; . ~/.bashrc; totem-start-ember-server;\")"' \
  #                 --tab -e 'bash -c "bash --init-file <(echo \". ~/.bash_profile; . ~/.bashrc; totem-start-oauth-server;\")"' \
  #                 --tab -e 'bash -c "bash --init-file <(echo \". ~/.bash_profile; . ~/.bashrc; totem-start-sio-server;\")"' \


# ##### Totem
# ### Totem::Shared
function totem-open-servers {
  gnome-terminal --tab
}
function totem-start-ember-server {
  totem-navigate-ember-server
  nvm use $TOTEM_NVM
  printf "[Totem] Starting Ember (CLIENT) server from $TOTEM_EMBER_SERVER..."
  ember server
}
function totem-start-rails-server {
  totem-navigate-rails-server
  printf "[Totem] Starting Rails (API) server from $TOTEM_RAILS_SERVER..."
  rails s --binding $TOTEM_IP
}
function totem-start-oauth-server {
  totem-setup-oauth-rvm
  totem-navigate-oauth-server
  printf "[Totem] Starting OAuth server from $TOTEM_OAUTH_SERVER..."
  rails s -p 3333
}
function totem-start-sio-server {
  if $TOTEM_HAS_SIO ; then
    totem-navigate-sio-server
    nvm use $TOTEM_NVM
    source node_env
    printf "[Totem] Starting Node SIO server from $TOTEM_SIO_SERVER"
    node app.js
  fi
}
function totem-setup-rvm {
  rvm use $TOTEM_RUBY
  rvm gemset use $TOTEM_GEMSET
}
function totem-setup-oauth-rvm {
  rvm use $TOTEM_RUBY
  rvm gemset use $TOTEM_OAUTH_GEMSET
}
function totem-navigate-ember-server {
  cd $TOTEM_EMBER_SERVER
}
function totem-navigate-oauth-server {
  cd $TOTEM_OAUTH_SERVER
}
function totem-navigate-rails-server {
  totem-setup-rvm
  cd $TOTEM_RAILS_SERVER
}
function totem-navigate-sio-server {
  cd $TOTEM_SIO_SERVER
}
function totem-navigate-deploy {
  cd $TOTEM_DEPLOY
}
function totem-navigate-production {
  cd $TOTEM_PRODUCTION
}
# ### /END Totem::Shared

# ### Totem::Modern
function totem-set-env {
  export TOTEM_IP=192.168.1.44
  export TOTEM_RUBY=2.3.1
  export TOTEM_GEMSET=rails5
  export TOTEM_OAUTH_GEMSET=rails5
  export TOTEM_NVM=6.9.1
  export TOTEM_BASE_DIR=~/Desktop/ember20
  export TOTEM_APPS_EMBER=$TOTEM_BASE_DIR/apps-ember
  export TOTEM_APPS_RAILS=$TOTEM_BASE_DIR/apps-rails
  export TOTEM_APPS_NODE=$TOTEM_BASE_DIR/apps-node
}
function totem-set-otbl {
  totem-set-env
  export TOTEM_APP_NAME=orchid
  export TOTEM_EMBER_SERVER=$TOTEM_APPS_EMBER/$TOTEM_APP_NAME
  export TOTEM_RAILS_SERVER=$TOTEM_APPS_RAILS/$TOTEM_APP_NAME
  export TOTEM_OAUTH_SERVER=$TOTEM_APPS_RAILS/totem-oauth
  export TOTEM_SIO_SERVER=$TOTEM_APPS_NODE/$TOTEM_APP_NAME
  export TOTEM_HAS_SIO=true
}
function totem-start-otbl {
  printf "${yellow}[Totem] Initializing environment variables for OpenTBL \n"
  totem-set-otbl
  printf "  => Starting servers...${normal}\n"
  totem-open-servers
}
# ### /END Totem::Modern

# ### Totem::Legacy
function totem-set-legacy-env {
  export TOTEM_IP=192.168.1.44
  export TOTEM_RUBY=2.3.1
  export TOTEM_GEMSET=rails4
  export TOTEM_OAUTH_GEMSET=rails5
  export TOTEM_NVM=0.12.0
  export TOTEM_BASE_DIR=~/projects
  export TOTEM_APPS_EMBER=$TOTEM_BASE_DIR
  export TOTEM_APPS_RAILS=$TOTEM_BASE_DIR
  export TOTEM_HAS_SIO=false
}
function totem-set-legacy-thinkspace {
  totem-set-legacy-env
  export TOTEM_APP_NAME=thinkspace
  export TOTEM_EMBER_SERVER=$TOTEM_APPS_EMBER/$TOTEM_APP_NAME
  export TOTEM_RAILS_SERVER=$TOTEM_APPS_RAILS/$TOTEM_APP_NAME-orchid
  export TOTEM_DEPLOY=$TOTEM_BASE_DIR
  export TOTEM_PRODUCTION=$TOTEM_BASE_DIR/deployment/$TOTEM_APP_NAME/production
  export TOTEM_OAUTH_SERVER=$TOTEM_BASE_DIR/repos/totem-oauth
}
function totem-set-legacy-cnc {
  totem-set-legacy-env
  export TOTEM_APP_NAME=cnc
  export TOTEM_EMBER_SERVER=$TOTEM_APPS_EMBER/$TOTEM_APP_NAME
  export TOTEM_RAILS_SERVER=$TOTEM_APPS_RAILS/$TOTEM_APP_NAME-orchid
  export TOTEM_DEPLOY=$TOTEM_BASE_DIR
  export TOTEM_PRODUCTION=$TOTEM_BASE_DIR/deployment/$TOTEM_APP_NAME/production
  export TOTEM_OAUTH_SERVER=$TOTEM_BASE_DIR/repos/totem-oauth
}
function totem-start-thinkspace {
  printf "${cyan}[Totem] Initializing environment variables for ThinkSpace\n"
  totem-set-legacy-thinkspace
  printf "  => Starting servers... ${normal}\n"
  totem-open-servers
}
function totem-start-cnc {
  printf "${cyan}[Totem] Initializing environment variables for CNC\n"
  totem-set-legacy-cnc
  printf "  => Starting servers... ${normal}\n"
  totem-open-servers
}
# ### /END Totem::Legacy

# ### Totem::Utility
function totem-pg-restore {
  sudo -u postgres pg_restore --verbose --clean --no-acl --no-owner -h localhost -d $1 -U postgres $2
}
function totem-prod {
  cd $TOTEM_PRODUCTION
}
function totem-set-branch {
  export TOTEM_BRANCH=$1
}
function set-title {
  ORIG=$PS1
  TITLE="\e]2;$@\a"
  PS1=${ORIG}${TITLE}
}

alias totem-app='~/projects/repos/totem-api/totem-cli/bin/totem-app'
alias totem-ember-cli='~/projects/repos/totem-api/totem-cli/bin/totem-ember-cli'
alias totem-deploy='~/projects/repos/totem-api/totem-cli/bin/totem-deploy'

black="$(tput setaf 0)"     # Black - Regular
red="$(tput setaf 1)"     # Red
green="$(tput setaf 2)"     # Green
yellow="$(tput setaf 3)"     # Yellow
blue="$(tput setaf 4)"     # Blue
purple="$(tput setaf 5)"     # Purple
cyan="$(tput setaf 6)"     # Cyan
white="$(tput setaf 7)"     # White
normal=$(tput sgr0)

export rvm_silence_path_mismatch_check_flag=1 # Silence RVM warning.
# ### /END Totem::Utility
# ##### /END Totem