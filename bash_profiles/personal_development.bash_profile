##
# Path configuration
#

PYTHON_PATH=/c/Users/sanch/AppData/Local/Programs/Python/Python312
export PATH="$PYTHON_PATH/Scripts:$PATH"
export PATH="$PYTHON_PATH:$PATH"

# Personal scripts repository
export PATH="$HOME/personal-scripts/:$PATH"

##
# Text editing
#
open_notepad(){
    echo "Opening notepad++ in the background..."
    notepad++ $1 &
}
alias npp=" open_notepad "


##
# Poetry configuration
#

poetry config virtualenvs.in-project true

alias p-el=" poetry env list "
alias p-ei=" poetry env info --path "
alias p-n=" poetry new "
alias p-init=" poetry init "
alias p-a=" poetry add "
alias p-install=" poetry install "
alias p-inr=" poetry install --no-root "

##
# Disk Use Information
#

# Disk use
alias d-use=" du -h * "

# Displays disk usage information directory
alias d-use-ts=" du -sh * "

# Displays disk usage information for each file and directory
alias d-use-file=" du -ck * | sort -rn | head -11 "

##
# Shortcuts
#

alias  src="source ~/.bash_profile"
alias  la=" ls -la "
alias  latr=" ls -latr "
alias  ll=" ls -l "

alias  up1=" cd .. "
alias  up2=" cd ../.. "
alias  up3=" cd ../../.. "
alias  up4=" cd ../../../.. "
alias  up5=" cd ../../../../.. "
alias  up6=" cd ../../../../../.. "

alias cls=" clear; ls "
alias c=" clear "

alias h=" history "

##
# Find useful programs
#

alias where='
		echo ""
		echo "Python:"
		echo ""
		ls -al $(which -a python python3);
		echo ""
		echo "Pip:"
		echo ""
		ls -al $(which -a pip pip3);
		echo ""
		echo "Bash:"
		echo ""
		which bash;
		echo ""
		echo "Git:"
		echo ""
		which git;
		echo ""
		echo "VS Code:"
		echo ""
		which code;
		echo ""
		echo "Vim:"
		echo ""
		which vim;
		echo ""
		echo "Notepad++:"
		echo ""
		which notepad++;
            '

alias mypath='echo $PATH | tr ":" "\n" '

##
# Git
#

alias g-a=" git add "
alias g-ad=" git add . "
alias g-clone=" git clone "
alias g-cm=" git commit -m "
alias g-p=" git push "
alias g-l=" git log "
alias g-o=" git checkout "
alias g-om=" git checkout main "
alias g-b=" git branch "
alias g-shove='git add . && git commit -m "Add quick update (via bash alias)" && git push'
alias g-pa="pull_all.sh"

##
# Update this .bash_profile
#

PERSONAL_SCRIPTS_DIR="$HOME/personal-scripts"
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

update_bash_profile() {
  cp "$HOME/.bash_profile" "$BASH_PROFILE_LOCAL_COPY" &&
  cd "$PERSONAL_SCRIPTS_DIR"
  git add . &&
  git commit -m "Update .bash_profile via alias" &&
  git push;
  cd -
}

alias pull-scripts="clone_personal_scripts"
alias update-bp="update_bash_profile"

