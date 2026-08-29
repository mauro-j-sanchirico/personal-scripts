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
PYTHON_EXE="$PYTHON_PATH/python.exe"
PYTHON_SCRIPTS_PATH="$PYTHON_PATH/Scripts"
POETRY_PATH="$(cygpath -u $APPDATA)/pypoetry/venv/Scripts"
PERSONAL_SCRIPTS_PATH="$HOME/personal-scripts"
BASH_SCRIPTS_PATH="$PERSONAL_SCRIPTS_PATH/bash_scripts"
PS_SCRIPTS_PATH="$PERSONAL_SCRIPTS_PATH/ps_scripts"

add_path $PYTHON_PATH
add_path $PYTHON_SCRIPTS_PATH
add_path $POETRY_PATH
add_path $BASH_SCRIPTS_PATH
add_path $PS_SCRIPTS_PATH

alias python="$PYTHON_EXE"

##
# API Keys
#
if [ -f "$HOME/.secrets/api_keys.sh" ]; then
    source "$HOME/.secrets/api_keys.sh"
fi

##
# Personal scripts configuration
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

alias pull-scripts="clone_personal_scripts"

##
# Text editing
#
source $PERSONAL_ALIASES_PATH/notepad_plusplus.bash_aliases

##
# Poetry configuration
#
poetry config virtualenvs.in-project true
alias poetry-use=" poetry env use \"$PYTHON_EXE\""
source $PERSONAL_ALIASES_PATH/poetry.bash_aliases

##
# Command line shortcuts
#
source $PERSONAL_ALIASES_PATH/command_line.bash_aliases

##
# Git
#
source $PERSONAL_ALIASES_PATH/git.bash_aliases

