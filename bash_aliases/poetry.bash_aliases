alias p-el=" poetry env list "
alias p-eip=" poetry env info --path "
alias p-ei=" poetry env info "
alias p-n=" poetry new "
alias p-init=" poetry init "
alias p-a=" poetry add "
alias p-install=" poetry install "
alias p-inr=" poetry install --no-root "
alias p-use=" poetry env use \"$(which python)\" "

pyup(){
  SYSTEM_PYTHON="$(cygpath -w "$(which python)")"
  echo "Ensuring latest pip and setuptools in system Python..."
  "$SYSTEM_PYTHON" -m ensurepip --upgrade
  "$SYSTEM_PYTHON" -m pip install --upgrade setuptools
  poetry env use "$SYSTEM_PYTHON"

  # Get path to local python and convert to Unix path for better interaction
  # with pip and poetry
  LOCAL_PYTHON="$(cygpath -u "$(poetry env info --path)")/Scripts/python"
  alias localpy="$LOCAL_PYTHON"
  poetry config virtualenvs.in-project true

  echo "Ensuring latest pip and setuptools in local Python..."
  $LOCAL_PYTHON -m ensurepip --upgrade
  $LOCAL_PYTHON -m pip install --upgrade setuptools
}