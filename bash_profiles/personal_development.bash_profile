##
# Path configuration
#

# Python
PYTHON_PATH="$HOME/AppData/Local/Programs/Python/Python313"
export PATH="$PYTHON_PATH/Scripts:$PATH"
export PATH="$PYTHON_PATH:$PATH"

# Poetry
POETRY_PATH="$APPDATA/pypoetry/venv/Scripts"
export PATH="$POETRY_PATH:$PATH"

# Personal scripts repository
export PATH="$HOME/personal-scripts/:$PATH"

##
# Update this .bash_profile
#

PERSONAL_SCRIPTS_DIR="$HOME/personal-scripts"
PERSONAL_ALIASES_DIR="$PERSONAL_SCRIPTS_DIR/bash_aliases"
BASH_PROFILE_LOCAL_COPY="$PERSONAL_SCRIPTS_DIR/bash_profiles/personal_development.bash_profile"
PERSONAL_SCRIPTS_REPOSITORY="https://github.com/mauro-j-sanchirico/personal-scripts.git"

# Clone the latest personal scripts repository
clone_personal_scripts() {
  current_dir="$(pwd)"
  cd ~
  pwd
  echo "$PERSONAL_SCRIPTS_DIR"
  if [ -d "$PERSONAL_SCRIPTS_DIR" ]; then
    echo "Personal scripts already cloned. Pulling latest changes..."
    cd "$PERSONAL_SCRIPTS_DIR" &&
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
  cd "$PERSONAL_SCRIPTS_DIR" &&
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
source $PERSONAL_ALIASES_DIR/notepad_plusplus.bash_aliases

##
# Poetry configuration
#
poetry config virtualenvs.in-project true
source $PERSONAL_ALIASES_DIR/poetry.bash_aliases

##
# Command line shortcuts
#
source $PERSONAL_ALIASES_DIR/command_line.bash_aliases

##
# Git
#
source $PERSONAL_ALIASES_DIR/git.bash_aliases

