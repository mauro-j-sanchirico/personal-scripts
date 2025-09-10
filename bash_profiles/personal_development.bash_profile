##
# Path configuration
#

# Add a path if the path exists and is not already added
add_path() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:$PATH"
    fi
}

PYTHON_PATH="$HOME/AppData/Local/Programs/Python/Python313"
PYTHON_SCRIPTS_PATH="$PYTHON_PATH/Scripts"
POETRY_PATH="$(cygpath -u $APPDATA)/pypoetry/venv/Scripts"
PERSONAL_SCRIPTS_PATH="$HOME/personal-scripts"

add_path $PYTHON_PATH
add_path $PYTHON_SCRIPTS_PATH
add_path $POETRY_PATH
add_path $PERSONAL_SCRIPTS_PATH

##
# Update this .bash_profile
#
PERSONAL_ALIASES_PATH="$PERSONAL_SCRIPTS_PATH/bash_aliases"
BASH_PROFILE_LOCAL_COPY="$PERSONAL_SCRIPTS_PATH/bash_profiles/personal_development.bash_profile"
PERSONAL_SCRIPTS_REPOSITORY="https://github.com/mauro-j-sanchirico/personal-scripts.git"

# Clone the latest personal scripts repository
clone_personal_scripts() {
  current_dir="$(pwd)"
  cd ~
  pwd
  echo "$PERSONAL_SCRIPTS_PATH"
  if [ -d "$PERSONAL_SCRIPTS_PATH" ]; then
    echo "Personal scripts already cloned. Pulling latest changes..."
    cd "$PERSONAL_SCRIPTS_PATH" &&
	git pull
  else
    echo "Cloning personal scripts..."
    git clone "$PERSONAL_SCRIPTS_REPOSITORY"
  fi
  cd "$current_dir"
}

# Take the latest local .bash_profile and push it to git
push_bash_profile() {
  cp "$HOME/.bash_profile" "$BASH_PROFILE_LOCAL_COPY" &&
  cd "$PERSONAL_SCRIPTS_PATH" &&
  git add . &&
  git commit -m "Update .bash_profile via alias" &&
  git push;
  cd -
}

alias pull-scripts="clone_personal_scripts"
alias push-bp="push_bash_profile"
alias update-bp=" cp $BASH_PROFILE_LOCAL_COPY $HOME/.bash_profile"

##
# Text editing
#
source $PERSONAL_ALIASES_PATH/notepad_plusplus.bash_aliases

##
# Poetry configuration
#
poetry config virtualenvs.in-project true
source $PERSONAL_ALIASES_PATH/poetry.bash_aliases

##
# Command line shortcuts
#
source $PERSONAL_ALIASES_PATH/command_line.bash_aliases

##
# Git
#
source $PERSONAL_ALIASES_PATH/git.bash_aliases

